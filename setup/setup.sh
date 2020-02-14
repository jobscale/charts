#!/usr/bin/env bash

# get location of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


print_style () {
    if [[ "$2" = "info" ]] ; then
        COLOR="36m";
    elif [[ "$2" = "success" ]] ; then
        COLOR="32m";
    elif [[ "$2" = "warning" ]] ; then
        COLOR="33m";
    elif [[ "$2" = "danger" ]] ; then
        COLOR="31m";
    else #default color
        COLOR="0m";
    fi

    START_COLOR="\e[$COLOR";
    END_COLOR="\e[0m";
    printf "$START_COLOR%b$END_COLOR" "$1";
}


# Cloud on which setup is running
# export CLOUD Environment Variable
# run export CLOUD=XYZ
# Possible Values:
# 1. AWS_INTERNAL: EKS Cluster running on Private VPC with no Internet Access
# 2.          AWS: EKS Cluster running in public subnet of VPC
# 3.          GCP: K8s Cluster on GCP or GKE
# 4.        AZURE: Cluster of Azure of AKS
# 5.       DOCKER: Local Cluster on Docker for Desktop
function check_could_env_variable() {
    if [[ -z "${CLOUD}" ]]; then
        print_style "\nCLOUD ENV VARIABLE IS NOT SET, please set 'export CLOUD=<One of AWS,AWS_INTERNAL,GCP,AZURE,DOCKER'\n"  "danger" && exit 1
    elif [[ "${CLOUD}" != "AWS_INTERNAL" ]] && [[ "${CLOUD}" != "AWS" ]] && [[ "${CLOUD}" != "GCP" ]] && [[ "${CLOUD}" != "AZURE" ]] && [[ "${CLOUD}" != "DOCKER" ]]; then
        print_style "\nInvalid value for CLOUD: ${CLOUD}, please set 'export CLOUD=<One of AWS,GCP,AZURE,DOCKER'\n" "danger" && exit 1
    fi
}

function install_dashboard() {
    # Install Kubernetes Dashboard and Permissions
    print_style "\nInstalling Kubernetes Dashboard on Cluster\n" "success"
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
    kubectl apply -f ${DIR}/dashboard/dashboard-admin-user.yaml
}

function install_ngnix_ingress_controller() {
    print_style "\nSetting Up Ngnix Ingress Controller\n" "success"
    # Install Ngnix Ingress Controller
    kubectl apply -f ${DIR}/nginx-ingress-controller/mandatory.yaml

    print_style "\nCreating Load Balancer Service for Cloud: ${CLOUD}\n" "success"

    if [[ "${CLOUD}" = "DOCKER" ]]; then
        # Docker for Mac
        kubectl apply -f ${DIR}/nginx-ingress-controller/generic/cloud-generic.yaml
    elif [[ "${CLOUD}" = "AWS" ]]; then
        # AWS
        kubectl apply -f ${DIR}/nginx-ingress-controller/aws/service-l4.yaml
        kubectl apply -f ${DIR}/nginx-ingress-controller/aws/patch-configmap-l4.yaml
    elif [[ "${CLOUD}" = "AWS_INTERNAL" ]]; then
        # AWS
        kubectl apply -f ${DIR}/nginx-ingress-controller/aws_internal/service-l4.yaml
        kubectl apply -f ${DIR}/nginx-ingress-controller/aws_internal/patch-configmap-l4.yaml
    elif [[ "${CLOUD}" = "GCP" ]]; then
        # GKE
        kubectl apply -f ${DIR}/nginx-ingress-controller/generic/cloud-generic.yaml
    elif [[ "${CLOUD}" = "AZURE" ]]; then
        # Azure
        kubectl apply -f ${DIR}/nginx-ingress-controller/generic/cloud-generic.yaml
    fi
}

function install_charts() {
    print_style "\nInstalling Components\n" "success"
    # NOTE: modify kustomize/hive-metastore/base/config/metastore-hive-metastore.env
    #       and add your AWS Access and Secret Key
    print_style "\nInstalling Hive Metastore\n" "success"
    print_style "please ensure AWS Keys are populated in kustomize/hive-metastore/base/config/metastore-hive-metastore.env file, if not populated already please \add the details and re-run the script\n" "warning"
    kubectl apply -k ${DIR}/../kustomize/hive-metastore/base

    print_style "\nInstalling Logging FWK\n" "success"
    if [[ "${CLOUD}" = "DOCKER" ]]; then
        kubectl apply -k ${DIR}/../kustomize/logging/minikube
    else
        kubectl apply -k ${DIR}/../kustomize/logging/base
    fi

    print_style "\nInstalling Monitoring FWK\n" "success"
    kubectl apply -k ${DIR}/../kustomize/monitoring/base

    print_style "\nInstalling Presto Operator\n" "success"
    kubectl apply -k ${DIR}/../kustomize/presto/base

    print_style "\nInstalling Security Components\n" "success"
    kubectl apply -k ${DIR}/../kustomize/security/base

    # NOTE: modify kustomize/spark/base/kustomization.yaml and add your aws access and secret
    #       key to <AWS ACCESS KEY ID> and <AWS SECRET ACCESS KEY>
    print_style "\nInstalling Spark Operator and History Server" "success"
    print_style "\n\nPlease ensure AWS Access Keys are populated in kustomize/spark/base/kustomization.yaml, if not populated already please add the details and re-run the script\n\n" "warning"
    kubectl apply -k ${DIR}/../kustomize/spark
}

function install_metrics_server() {
    if [[ "${CLOUD}" = "DOCKER" ]]; then
        print_style "\n\nInstalling Metrics Server\n" "success"
        kubectl apply -f ${DIR}/metrics-server/
    fi
}

function on_completion_method() {
    print_style "\nInstall Successful!!\n\n" "success"
    kubectl get pods --all-namespaces
    print_style "\n\n**  KUBERNETES DASHBOARD  **\n" "warning"
    token=$(kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') | awk -v FS="token:" 'NF>1{print $2}')
    print_style "\nUse this token to login on Home Page: \n\n${token}\n\n" info
    print_style "\n\nTo Access Dashboard: run command 'kubectl proxy'" "info"
    print_style "\n\nAccess Dashboard Using URL: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login " "info"
    print_style "\n\n ** INGRESS ** \n" "warning"
    kubectl -n ingress-nginx get svc
    print_style "\nUse above External IP to Login to Ingress" "info"
    ip=$(kubectl -n ingress-nginx get svc | awk 'FNR == 2 {print $4}')
    print_style "\nKibana Access URL: http://${ip}/kibana" "info"
    print_style "\nGrafana Access URL: http://${ip}/grafana User: admin Password: dUplXNB1zTX3kRCKP2GgjlNW0tjVJt19ONhpomEp" "info"
}


check_could_env_variable
install_dashboard
install_metrics_server
install_ngnix_ingress_controller
install_charts
on_completion_method
#!/usr/bin/env bash

script_file=$1

if [[ -z ${script_file} ]];
then
    cd /examples/scripts
    rm -rf generated*
rm -rf  Record*
    export JAVA_OPTS="-Xmx512M -Xms32M"
    scalac -classpath ./*:/opt/spark/jars/* -target:jvm-1.7 script-create-tables.scala
    jar cvf code-create-tables.jar *
    rm generated*
    rm Record*


    scalac -classpath ./*:/opt/spark/jars/* -target:jvm-1.7 script-tpc-ds-run.scala
    jar cvf code-tpc-ds-run.jar *
    rm generated*
    rm Record*
else
    cd /examples
    rm -rf generated*
    rm -rf  Record*
    export JAVA_OPTS="-Xmx512M -Xms32M"
    scalac -classpath ./*:/opt/spark/jars/* -target:jvm-1.7 ${script_file}
    jar cvf code.jar *
    rm generated*
    rm Record*
fi
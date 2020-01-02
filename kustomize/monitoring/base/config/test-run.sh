@test "Test Health" {
  url="http://metrics-grafana/api/health"

  code=$(curl -s -o /dev/null -I -w "%{http_code}" $url)
  [ "$code" == "200" ]
}
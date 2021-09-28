#!/bin/bash
DB_HOME='/opt/module/db_log'

function add_property() {
  if [ ! -e "$1" ]; then
    touch "$1"
  fi
  sed -i "/$2/d" "$1"
  echo "$2=$3" >>"$1"
}

function mock_data() {
  add_property $DB_HOME/application.properties "mock.date" "$1"
  cd $DB_HOME || exit 1
  java -jar gmall2020-mock-db-2021-01-22.jar 1>/dev/null 2>&1
}

case $1 in
"init")
  add_property "$DB_HOME/application.properties" "mock.clear" "1"
  add_property "$DB_HOME/application.properties" "mock.clear.user" "1"
  DT=$(date -d "2020-06-14 -15 days" +%F)
  echo "正在生成${DT}的数据"
  mock_data "$DT"
  add_property "$DB_HOME/application.properties" "mock.clear" "0"
  add_property "$DB_HOME/application.properties" "mock.clear.user" "0"
  for ((i = 14; i >= 0; i--)); do
    DT=$(date -d "2020-06-14 -$i days" +%F)
    echo "正在生成${DT}的数据"
    mock_data  "$DT"
  done
  ;;
*)
  mock_data "$1"
  ;;
esac

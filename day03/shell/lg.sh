#!/bin/bash
CLUSTER='hadoop102,hadoop103'
APP_HOME='/opt/module/applog'
if [ "$1" ]; then
  xcall -w "$CLUSTER" "sed -i '/mock.date/s/\".*\"/\"$1\"/' $APP_HOME/application.yml"
fi
xcall -w "$CLUSTER" "cd $APP_HOME; java -jar gmall2020-mock-log-2021-01-22.jar >/dev/null 2>&1 &"


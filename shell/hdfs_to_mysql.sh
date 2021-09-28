#!/bin/bash

hive_db_name='gmall'
mysql_db_name='gmall_report'
mysql_host='hadoop105'
mysql_user='root'
mysql_password='000000'
SQOOP_HOME='/opt/module/sqoop'

export_data() {
$SQOOP_HOME/bin/sqoop export \
--connect "jdbc:mysql://$mysql_host:3306/${mysql_db_name}?useUnicode=true&characterEncoding=utf-8"  \
--username $mysql_user \
--password $mysql_password \
--table $1 \
--num-mappers 1 \
--export-dir /warehouse/$hive_db_name/ads/$1 \
--input-fields-terminated-by "\t" \
--update-mode allowinsert \
--update-key $2 \
--input-null-string '\\N'    \
--input-null-non-string '\\N'
}

case $1 in
  "ads_activity_stats" )
    export_data "ads_activity_stats" "dt,activity_id"
  ;;

  "ads_coupon_stats" )
    export_data "ads_coupon_stats" "dt,coupon_id"
  ;;

  "ads_order_by_province" )
    export_data "ads_order_by_province" "dt,province_id"
  ;;

  "ads_order_spu_stats" )
    export_data "ads_order_spu_stats" "dt,spu_id"
  ;;

  "ads_order_total" )
    export_data "ads_order_total" "dts"
  ;;

  "ads_page_path" )
    export_data "ads_page_path" "dt,source,target"
  ;;

  "ads_repeat_purchase" )
    export_data "ads_repeat_purchase" "dt,tm_id"
  ;;

  "ads_user_action" )
    export_data "ads_user_action" "dt"
  ;;

  "ads_user_change" )
    export_data "ads_user_change" "dt"
  ;;

  "ads_user_continuity" )
    export_data "ads_user_continuity" "dt"
  ;;

  "ads_user_online_count_min" )
    export_data "ads_user_online_count_min" "dt,mins"
  ;;

  "ads_user_retention" )
    export_data "ads_user_retention" "create_date"
  ;;

  "ads_user_total" )
    export_data "ads_user_total" "dt"
  ;;

  "ads_visit_stats" )
    export_data "ads_visit_stats" "dt,is_new,channel"
  ;;
  "all" )
    export_data "ads_activity_stats" "dt,activity_id"
    export_data "ads_coupon_stats" "dt,coupon_id"
    export_data "ads_order_by_province" "dt,province_id"
    export_data "ads_order_spu_stats" "dt,spu_id"
    export_data "ads_order_total" "dts"
    export_data "ads_page_path" "dt,source,target"
    export_data "ads_repeat_purchase" "dt,tm_id"
    export_data "ads_user_action" "dt"
    export_data "ads_user_change" "dt"
    export_data "ads_user_continuity" "dt"
    export_data "ads_user_online_count_min" "dt,mins"
    export_data "ads_user_retention" "create_date"
    export_data "ads_user_total" "dt"
    export_data "ads_visit_stats" "dt,is_new,channel"
  ;;
esac

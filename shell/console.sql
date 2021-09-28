--商品主题表首日导入
select sku_id,
       sum(if(dt = '2020-06-14', order_count, 0)),
       sum(if(dt = '2020-06-14', order_num, 0)),
       sum(if(dt = '2020-06-14', order_activity_count, 0)),
       sum(if(dt = '2020-06-14', order_coupon_count, 0)),
       sum(if(dt = '2020-06-14', order_activity_reduce_amount, 0)),
       sum(if(dt = '2020-06-14', order_coupon_reduce_amount, 0)),
       sum(if(dt = '2020-06-14', order_original_amount, 0)),
       sum(if(dt = '2020-06-14', order_final_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_count, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_num, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_activity_count, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_coupon_count, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_activity_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_coupon_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_original_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_final_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_num, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_activity_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_coupon_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_activity_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_coupon_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_original_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_final_amount, 0)),
       sum(order_count),
       sum(order_num),
       sum(order_activity_count),
       sum(order_coupon_count),
       sum(order_activity_reduce_amount),
       sum(order_coupon_reduce_amount),
       sum(order_original_amount),
       sum(order_final_amount)
from dws_sku_action_daycount
group by sku_id;

--商品主题每日导入06-15
with old as
         (
             select *
             from dwt_sku_topic dst
             where dt = date_add('2020-06-15', -1)
         ),
     new as
         (
             select *
             from dws_sku_action_daycount
             where dt = '2020-06-15'
         ),
     7d as
         (
             select *
             from dws_sku_action_daycount
             where dt = date_add('2020-06-15', -7)
         ),
     30d as
         (
             select *
             from dws_sku_action_daycount
             where dt = date_add('2020-06-15', -30)
         )
select nvl(new.sku_id, old.sku_id),
       nvl(new.order_count, 0),
       nvl(new.order_num, 0),
       nvl(new.order_activity_count, 0),
       nvl(new.order_coupon_count, 0),
       nvl(new.order_activity_reduce_amount, 0),
       nvl(new.order_coupon_reduce_amount, 0),
       nvl(new.order_original_amount, 0),
       nvl(new.order_final_amount, 0),
       nvl(old.order_last_7d_count, 0) + nvl(new.order_count, 0) - nvl(7d.order_count, 0),
       nvl(old.order_last_7d_num, 0) + nvl(new.order_num, 0) - nvl(7d.order_num, 0),
       nvl(old.order_activity_last_7d_count, 0) + nvl(new.order_activity_count, 0) - nvl(7d.order_activity_count, 0),
       nvl(old.order_coupon_last_7d_count, 0) + nvl(new.order_coupon_count, 0) - nvl(7d.order_coupon_count, 0),
       nvl(old.order_activity_reduce_last_7d_amount, 0) + nvl(new.order_activity_reduce_amount, 0) -
       nvl(7d.order_activity_reduce_amount, 0),
       nvl(old.order_coupon_reduce_last_7d_amount, 0) + nvl(new.order_coupon_reduce_amount, 0) -
       nvl(7d.order_coupon_reduce_amount, 0),
       nvl(old.order_last_7d_original_amount, 0) + nvl(new.order_original_amount, 0) - nvl(7d.order_original_amount, 0),
       nvl(old.order_last_7d_final_amount, 0) + nvl(new.order_final_amount, 0) - nvl(7d.order_final_amount, 0),
       nvl(old.order_last_30d_count, 0) + nvl(new.order_count, 0) - nvl(30d.order_count, 0),
       nvl(old.order_last_30d_num, 0) + nvl(new.order_num, 0) - nvl(30d.order_num, 0),
       nvl(old.order_activity_last_30d_count, 0) + nvl(new.order_activity_count, 0) - nvl(30d.order_activity_count, 0),
       nvl(old.order_coupon_last_30d_count, 0) + nvl(new.order_coupon_count, 0) - nvl(30d.order_coupon_count, 0),
       nvl(old.order_activity_reduce_last_30d_amount, 0) + nvl(new.order_activity_reduce_amount, 0) -
       nvl(30d.order_activity_reduce_amount, 0),
       nvl(old.order_coupon_reduce_last_30d_amount, 0) + nvl(new.order_coupon_reduce_amount, 0) -
       nvl(30d.order_coupon_reduce_amount, 0),
       nvl(old.order_last_30d_original_amount, 0) + nvl(new.order_original_amount, 0) -
       nvl(30d.order_original_amount, 0),
       nvl(old.order_last_30d_final_amount, 0) + nvl(new.order_final_amount, 0) - nvl(30d.order_final_amount, 0),
       nvl(old.order_count, 0) + nvl(new.order_count, 0),
       nvl(old.order_num, 0) + nvl(new.order_num, 0),
       nvl(old.order_activity_count, 0) + nvl(new.order_activity_count, 0),
       nvl(old.order_coupon_count, 0) + nvl(new.order_coupon_count, 0),
       nvl(old.order_activity_reduce_amount, 0) + nvl(new.order_activity_reduce_amount, 0),
       nvl(old.order_coupon_reduce_amount, 0) + nvl(new.order_coupon_reduce_amount, 0),
       nvl(old.order_original_amount, 0) + nvl(new.order_original_amount, 0),
       nvl(old.order_final_amount, 0) + nvl(new.order_final_amount, 0)
from old
         full outer join new on old.sku_id = new.sku_id
         left join 7d on old.sku_id = 7d.sku_id
         left join 30d on old.sku_id = 30d.sku_id;

--访客主题首日导入
select mid_id,
       min(dt),
       max(dt),
       sum(if(dt = '2020-06-14', visit_count, 0)),
       sum(if(dt = '2020-06-14' and visit_count > 0, 1, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', visit_count, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14' and visit_count > 0, visit_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', visit_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14' and visit_count > 0, visit_count, 0)),
       sum(visit_count),
       sum(if(visit_count > 0, 1, 0))
from dws_visitor_action_daycount dvad
group by mid_id;

--访客主题每日导入
with new as
         (
             select *
             from dws_visitor_action_daycount dvad
             where dt = '2020-06-15'
         ),
     old as
         (
             select *
             from dwt_visitor_topic dvt
             where dt = '2020-06-14'
         )
select nvl(new.mid_id, old.mid_id),
       nvl(old.visit_date_first, '2020-06-15'),
       if(new.mid_id is not null, '2020-06-15', old.visit_date_last)

from new
         full outer join old
                         on new.mid_id = old.mid_id;
--维度信息
select mid_id,
       brand,
       model,
       split(concat_ws(",", collect_set(concat_ws(",", channel))), ','),
       split(concat_ws(",", collect_set(concat_ws(",", os))), ','),
       split(concat_ws(",", collect_set(concat_ws(",", area_code))), ','),
       split(concat_ws(",", collect_set(concat_ws(",", version_code))), ',')
from dws_visitor_action_daycount dvad
group by mid_id, brand, model;


--首日
select coupon_id,
       sum(if(dt = '2020-06-14', order_count, 0)),
       sum(if(dt = '2020-06-14', order_reduce_amount, 0)),
       sum(if(dt = '2020-06-14', order_original_amount, 0)),
       sum(if(dt = '2020-06-14', order_final_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_count, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_original_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -6) and '2020-06-14', order_final_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_count, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_reduce_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_original_amount, 0)),
       sum(if(dt between date_add('2020-06-14', -29) and '2020-06-14', order_final_amount, 0)),
       sum(order_count),
       sum(order_reduce_amount),
       sum(order_original_amount),
       sum(order_final_amount)
from dws_coupon_info_daycount dcid
group by coupon_id;
--每日
with old as
         (
             select *
             from dwt_coupon_topic dct
             where dt = '2020-06-14'
         ),
     new as
         (
             select *
             from dws_coupon_info_daycount dcid
             where dt = '2020-06-15'
         ),
     7d as
         (
             select *
             from dws_coupon_info_daycount dcid
             where dt = date_add('2020-06-15', -7)
         ),
     30d as
         (
             select *
             from dws_coupon_info_daycount dcid
             where dt = date_add('2020-06-15', -30)
         )
select nvl(new.order_count, 0),
       nvl(new.order_reduce_amount, 0),
       nvl(new.order_original_amount, 0),
       nvl(new.order_final_amount, 0),
       nvl(old.order_last_7d_count, 0) + nvl(new.order_count, 0) - nvl(7d.order_count, 0),
       nvl(old.order_last_7d_reduce_amount, 0) + nvl(new.order_reduce_amount, 0) - nvl(7d.order_reduce_amount, 0),
       nvl(old.order_last_7d_original_amount, 0) + nvl(new.order_original_amount, 0) - nvl(7d.order_original_amount, 0),
       nvl(old.order_last_7d_final_amount, 0) + nvl(new.order_final_amount, 0) - nvl(7d.order_final_amount, 0),
       nvl(old.order_last_30d_count, 0) + nvl(new.order_count, 0) - nvl(30d.order_count, 0),
       nvl(old.order_last_30d_reduce_amount, 0) + nvl(new.order_reduce_amount, 0) - nvl(30d.order_reduce_amount, 0),
       nvl(old.order_last_30d_original_amount, 0) + nvl(new.order_original_amount, 0) -
       nvl(30d.order_original_amount, 0),
       nvl(old.order_last_30d_final_amount, 0) + nvl(new.order_final_amount, 0) - nvl(30d.order_final_amount, 0),
       nvl(old.order_count, 0) + nvl(new.order_count, 0),
       nvl(old.order_reduce_amount, 0) + nvl(new.order_reduce_amount, 0),
       nvl(old.order_original_amount, 0) + nvl(new.order_original_amount, 0),
       nvl(old.order_final_amount, 0) + nvl(new.order_final_amount, 0)
from old
         full outer join new on old.coupon_id = new.coupon_id
         left join 7d on old.coupon_id = 7d.coupon_id
         left join 30d on old.coupon_id = 30d.coupon_id;

--近30日发布的优惠券和补贴率
--进30日发布的优惠券
with cu_info as
         (
             select id                                    coupon_id,
                    coupon_name,
                    date_format(start_time, 'yyyy-MM-dd') start_date,
                    case coupon_type
                        when '3201' then concat('立减', benefit_amount, '元')
                        when '3202' then '打' + benefit_discount + '折'
                        when '3203' then '满' + condition_amount + '减' + benefit_amount
                        when '3204' then '满' + condition_num + '件打' + benefit_discount + '折'
                        end                               rule_name
             from dim_coupon_info dci
             where dt = '2020-06-14'
--               and date_format(start_time, 'yyyy-MM-dd') >= date_add('2020-06-14', -29)
         ),
--近30日统计值
     30d_stats as
         (
             select coupon_id,
                    get_last_30d_count                                            get_count,
                    order_last_30d_count                                          order_count,
                    expire_last_30d_count                                         expire_count,
                    order_last_30d_original_amount                                order_original_amount,
                    order_last_30d_final_amount                                   order_final_amount,
                    order_last_30d_reduce_amount                                  reduce_amount,
                    order_last_30d_reduce_amount / order_last_30d_original_amount reduce_rate
             from dwt_coupon_topic dct
             where dt = '2020-06-14'
         )
select '2020-06-14',
       cu_info.`coupon_id`,
       `coupon_name`,
       `start_date`,
       `rule_name`,
       `get_count`,
       `order_count`,
       `expire_count`,
       `order_original_amount`,
       `order_final_amount`,
       `reduce_amount`,
       `reduce_rate`
from cu_info
         left join 30d_stats
                   on cu_info.coupon_id = 30d_stats.coupon_id;

--近30日活动参加和补贴率
--近30日的活动
with ai_tmp as
         (
             select activity_rule_id,
                    activity_id,
                    activity_name,
                    date_format(start_time, 'yyyy-MM-dd') start_date
             from dim_activity_rule_info dari
             where dt = '2020-06-14'
               and date_format(start_time, 'yyyy-MM-dd') >= date_add('2020-06-14', -29)
         ),
--近30日统计情况
     at_tmp as
         (
             select activity_rule_id,
                    order_count,
                    order_original_amount,
                    order_final_amount,
                    order_reduce_amount
             from dwt_activity_topic dat
             where dt = '2020-06-14'
         )
select '2020-06-14',
       activity_id,
       activity_name,
       start_date,
       sum(order_count),
       sum(order_original_amount),
       sum(order_final_amount),
       sum(order_reduce_amount),
       sum(order_reduce_amount) / sum(order_original_amount)
from ai_tmp
         left join at_tmp
                   on ai_tmp.activity_rule_id = at_tmp.activity_rule_id
group by activity_id, activity_name, start_date;

--统计spu的count和amount
--维度信息表
with dim as
         (
             select id,
                    spu_id,
                    spu_name,
                    tm_id,
                    tm_name,
                    `category3_id`,
                    `category3_name`,
                    `category2_id`,
                    `category2_name`,
                    `category1_id`,
                    `category1_name`
             from dim_sku_info dsi
             where dt = '2020-06-14'
         ),
--订单统计
     sku_tmp as
         (
             select sku_id,
                    order_count,
                    order_final_amount
             from dwt_sku_topic dst
         )
insert
overwrite
table
ads_order_spu_stats
select *
from ads_order_spu_stats
union
select '2020-06-14' dt,
       spu_id,
       spu_name,
       `tm_id`,
       `tm_name`,
       `category3_id`,
       `category3_name`,
       `category2_id`,
       `category2_name`,
       `category1_id`,
       `category1_name`,
       sum(order_count),
       sum(order_final_amount)
from dim
         left join sku_tmp
                   on dim.id = sku_tmp.sku_id
group by spu_id, spu_name, `tm_id`, `tm_name`, `category3_id`, `category3_name`, `category2_id`, `category2_name`,
         `category1_id`, `category1_name`;

--30d复购率
--先求近30天每个人买每个品牌的下单数
from (
         select user_id,
                tm_id,
                tm_name,
                count(distinct order_id) order_count
         from dwd_order_detail dod
                  join dim_sku_info dsi
                       on dod.sku_id = dsi.id
         where dod.dt between date_add('2020-06-14', -29) and '2020-06-14'
           and dsi.dt = '2020-06-14'
         group by user_id, tm_id, tm_name
     ) t1
--再求复购率
select '2020-06-14' dt,
       tm_id,
       tm_name,
       count(if(order_count >= 2, user_id, null)) / count(if(order_count >= 1, user_id, null))
group by tm_id, tm_name;

--订单统计
select '2020-06-14',
       sum(order_count),
       sum(order_final_amount),
       count(user_id)
from dws_user_action_daycount duad
where dt = '2020-06-14';

--各地区订单统计
select `dt`,
       `province_id`,
       `province_name`,
       `area_code`,
       `iso_code`,
       `iso_3166_2`       iso_code_3166_2,
       order_count,
       order_final_amount order_amount
from dws_area_stats_daycount dasd
         join dim_base_province dbp
              on dasd.province_id = dbp.id
where dt = '2020-06-14';

--用户统计
select '2020-06-14',
       count(if(login_date_first = '2020-06-14', user_id, null)),
       count(if(order_date_first = '2020-06-14', user_id, null)),
       sum(order_last_1d_final_amount),
       count(if(order_last_1d_count > 0, user_id, null)),
       count(if(login_date_last = '2020-06-14' and order_last_1d_count = 0, user_id, null))
from dwt_user_topic dut
where dt = '2020-06-14';

--统计流失用户
select '2020-06-14',
       count(user_id) user_churn_count
from dwt_user_topic dut
where dt = '2020-06-14'
  and date_format(login_date_last, 'yyyy-MM-dd') = date_add('2020-06-14', -7);
--回流用户
from (
         select user_id
         from dwt_user_topic dut
         where dt = '2020-06-14'
           and date_format(login_date_last, 'yyyy-MM-dd') = '2020-06-14'
     ) t1
         join
     (
         select user_id
         from dwt_user_topic dut
         where dt = '2020-06-13'
           and date_format(login_date_last, 'yyyy-MM-dd') <= date_add('2020-06-14', -8)
     ) t2
     on t1.user_id = t2.user_id
select '2020-06-14',
       count(t1.user_id);

--用户行为漏斗分析
with view_cnt as
         (
             select count(distinct `if`(page_id = 'home', mid_id, null))        home_count,
                    count(distinct `if`(page_id = 'good_detail', mid_id, null)) good_detail_count
             from dwd_page_log dpl
             where dt = '2020-06-14'
         ),
     cnt as
         (
             select count(distinct if(cart_count > 0, user_id, null))    cart_count,
                    count(distinct if(order_count > 0, user_id, null))   order_count,
                    count(distinct if(payment_count > 0, user_id, null)) payment_count
             from dws_user_action_daycount duad
             where dt = '2020-06-14'
         )
select '2020-06-14',
       home_count,
       good_detail_count,
       cart_count,
       order_count,
       payment_count
from view_cnt
         join cnt;

--用户留存率
select '2020-06-14',
       login_date_first,
       datediff('2020-06-14', login_date_first),
       count(if(login_date_last = '2020-06-14', user_id, null)),
       count(user_id),
       count(if(login_date_last = '2020-06-14', user_id, null)) / count(user_id)
from dwt_user_topic dut
where dt = '2020-06-14'
  and login_date_first between date_add('2020-06-14', -7) and date_add('2020-06-14', -1)
group by login_date_first
order by login_date_first;

--七日连续登录3日
from (
         from (
                  select user_id,
                         dt,
                         rank() over (partition by user_id order by dt) day
                  from dws_user_action_daycount
                  where dt between date_add('2020-06-14', -6) and '2020-06-14'
              ) t1
         select user_id, count(user_id) cnt
         group by user_id, date_sub(dt, day)
     ) t2
select '2020-06-14',
       count(distinct user_id)
where cnt >= 3;

from (
         from (
                  select mid_id,
                         channel,
                         is_new,
                         last_page_id,
                         page_id,
                         during_time,
                         ts,
                         `if`(last_page_id is null, ts, null),
                         concat(mid_id, '-',
                                last_value(`if`(last_page_id is null, ts, null), true)
                                           over (partition by mid_id )) session_id
                  from dwd_page_log dpl
                  where dt = '2020-06-14'
              ) t1
         select mid_id,
                channel,
                is_new,
                session_id,
                count(1)         cnt,
                sum(during_time) session_total_time
         group by is_new, mid_id, session_id, channel
     ) t2
select '2020-06-14'                                             dt,
       is_new,
       channel,
       count(distinct mid_id)                                   uv_count,
       sum(session_total_time) / 1000                           duration_sec,
       avg(session_total_time) / 1000                           avg_duration_sec,
       sum(cnt)                                                 page_count,
       avg(cnt)                                                 avg_page_count,
       count(session_id)                                        sv_count,
       count(if(cnt = 1, session_id, null))                     bounce_count,
       count(if(cnt = 1, session_id, null)) / count(session_id) bounce_rate
group by is_new, channel
order by is_new, channel;

--路径分析
from (
         from (
                  select mid_id,
                         channel,
                         is_new,
                         last_page_id,
                         page_id,
                         during_time,
                         ts,
                         `if`(last_page_id is null, ts, null),
                         concat(mid_id, '-',
                                last_value(`if`(last_page_id is null, ts, null), true)
                                           over (partition by mid_id )) session_id
                  from dwd_page_log dpl
                  where dt = '2020-06-14'
              ) t1
         select mid_id,
                page_id                                                           start_page,
                lead(page_id, 1, null) over (partition by session_id order by ts) end_page,
                row_number() over (partition by session_id order by ts)           step
     ) t2
select '2020-06-14',
       concat('step-', step, ': ', start_page)   source,
       concat('step-', step + 1, ': ', end_page) target,
       count(mid_id)
group by concat('step-', step, ': ', start_page), concat('step-', step + 1, ': ', end_page);


--每分钟在线统计
from (
         from (
                  select mid_id,
                         last_page_id,
                         ts                                             page_start_time,
                         ts + during_time                               page_end_time,
                         concat(mid_id, '-',
                                last_value(`if`(last_page_id is null, ts, null), true)
                                           over (partition by mid_id )) session_id
                  from dwd_page_log dpl
                  where dt = '2020-06-14'
              ) t1
         select mid_id,
                session_id,
                min(page_start_time) session_start_time,
                max(page_end_time)   session_end_time
         group by mid_id, session_id) t2
         lateral view posexplode(split(repeat('a,', int(session_end_time / 60000) - int(session_start_time / 60000)),
                                       ',')) tbl as pos, val
select '2020-06-14',
       date_format(timestamp(session_start_time + pos * 60000), 'yyyy-MM-dd HH:mm') mins,
       count(distinct mid_id)
group by date_format(timestamp(session_start_time + pos * 60000), 'yyyy-MM-dd HH:mm');



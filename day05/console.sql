--每日统计
with login_tmp as
         (
             select user_id,
                    count(if(last_page_id is null, 1, null)) login_count
             from dwd_page_log
             where dt = '2020-06-15'
               and user_id is not null
             group by user_id
         ),
     cf_tmp as
         (
             select user_id,
                    count(if(action_id = 'cart_add', 1, null))  cart_count,
                    count(if(action_id = 'favor_add', 1, null)) favor_count
             from dwd_action_log
             where dt = '2020-06-15'
               and user_id is not null
             group by user_id
         ),
     oi_tmp as
         (
             select user_id,
                    count(id)                                       order_count,
                    count(if(activity_reduce_amount > 0, id, null)) order_activity_count,
                    sum(activity_reduce_amount)                     order_activity_reduce_amount,
                    count(if(coupon_reduce_amount > 0, id, null))   order_coupon_count,
                    sum(coupon_reduce_amount)                       order_coupon_reduce_amount,
                    sum(original_amount)                            order_original_amount,
                    sum(final_amount)                               order_final_amount
             from dwd_order_info
             where dt = '2020-06-15'
             group by user_id
         ),
     pi_tmp as
         (
             select user_id,
                    count(id)           payment_count,
                    sum(payment_amount) payment_amount
             from dwd_payment_info
             where dt = '2020-06-15'
             group by user_id
         ),
     ori_tmp as
         (
             select user_id,
                    count(id)          refund_order_count,
                    sum(refund_num)    refund_order_num,
                    sum(refund_amount) refund_order_amount
             from dwd_order_refund_info
             where dt = '2020-06-15'
             group by user_id
         ),
     orp_tmp as
         (
             select user_id,
                    count(id)          refund_payment_count,
                    sum(refund_num)    refund_payment_num,
                    sum(refund_amount) refund_payment_amount
             from (
                      select order_id,
                             refund_num
                      from dwd_order_refund_info
                      where dt = '2020-06-15'
                  ) tmp1
                      right join
                  (
                      select id,
                             user_id,
                             order_id,
                             refund_amount
                      from dwd_refund_payment
                      where dt = '2020-06-15'
                  ) tmp2
                  on tmp2.order_id = tmp1.order_id
             group by user_id
         ),
     ci_tmp as
         (
             select user_id,
                    count(if(appraise = '1201', 1, null)) appraise_good_count,
                    count(if(appraise = '1202', 1, null)) appraise_mid_count,
                    count(if(appraise = '1203', 1, null)) appraise_bad_count,
                    count(if(appraise = '1204', 1, null)) appraise_default_count
             from dwd_comment_info
             where dt = '2020-06-15'
             group by user_id
         ),
     od_tmp as
         (
             select user_id,
                    collect_list(named_struct(
                            'sku_id', sku_id,
                            'sku_num', sku_num,
                            'order_count', order_count,
                            'activity_reduct_amount', activity_reduct_amount,
                            'coupon_reduce_amount', coupon_reduce_amount,
                            'original_amount', original_amount,
                            'final_amount', final_amount
                        ))
             from (
                      select user_id,
                             sku_id,
                             sum(sku_num)               sku_num,
                             count(order_id)            order_count,
                             sum(split_activity_amount) activity_reduct_amount,
                             sum(split_coupon_amount)   coupon_reduce_amount,
                             sum(original_amount)       original_amount,
                             sum(split_final_amount)    final_amount
                      from dwd_order_detail
                      where dt = '2020-06-15'
                      group by user_id, sku_id
                  )
             group by user_id
         ),
     cu_tmp as
         (
             select user_id,
                    count(if(date_format(get_time, 'yyyy-MM-dd') = '2020-06-15', 1, null))   coupon_get_count,
                    count(if(date_format(using_time, 'yyyy-MM-dd') = '2020-06-15', 1, null)) coupon_using_count,
                    count(if(used_time is not null, 1, null))                                coupon_used_count
             from dwd_coupon_use
             where dt = '2020-06-15'
                or dt = '9999-99-99'
             group by user_id
         )
from (select user_id,
             login_count,
             0 cart_count,
             0 favor_count,
             0 `order_count`,
             0 `order_activity_count`,
             0 `order_activity_reduce_amount`,
             0 `order_coupon_count`,
             0 `order_coupon_reduce_amount`,
             0 `order_original_amount`,
             0 `order_final_amount`,
             0 `payment_count`,
             0 `payment_amount`,
             0 `refund_order_count`,
             0 `refund_order_num`,
             0 `refund_order_amount`,
             0 `refund_payment_count`,
             0 `refund_payment_num`,
             0 `refund_payment_amount`,
             0 `coupon_get_count`,
             0 `coupon_using_count`,
             0 `coupon_used_count`,
             0 `appraise_good_count`,
             0 `appraise_mid_count`,
             0 `appraise_bad_count`,
             0 `appraise_default_count`,
             0 `order_detail_stats`
      from login_tmp
      union all
      select user_id,
             0 login_count,
             cart_count,
             favor_count,
             0 `order_count`,
             0 `order_activity_count`,
             0 `order_activity_reduce_amount`,
             0 `order_coupon_count`,
             0 `order_coupon_reduce_amount`,
             0 `order_original_amount`,
             0 `order_final_amount`,
             0 `payment_count`,
             0 `payment_amount`,
             0 `refund_order_count`,
             0 `refund_order_num`,
             0 `refund_order_amount`,
             0 `refund_payment_count`,
             0 `refund_payment_num`,
             0 `refund_payment_amount`,
             0 `coupon_get_count`,
             0 `coupon_using_count`,
             0 `coupon_used_count`,
             0 `appraise_good_count`,
             0 `appraise_mid_count`,
             0 `appraise_bad_count`,
             0 `appraise_default_count`,
             0 `order_detail_stats`
      from cf_tmp
      union all
      select user_id,
             0 login_count,
             0 cart_count,
             0 favor_count,
             `order_count`,
             `order_activity_count`,
             `order_activity_reduce_amount`,
             `order_coupon_count`,
             `order_coupon_reduce_amount`,
             `order_original_amount`,
             `order_final_amount`,
             0 `payment_count`,
             0 `payment_amount`,
             0 `refund_order_count`,
             0 `refund_order_num`,
             0 `refund_order_amount`,
             0 `refund_payment_count`,
             0 `refund_payment_num`,
             0 `refund_payment_amount`,
             0 `coupon_get_count`,
             0 `coupon_using_count`,
             0 `coupon_used_count`,
             0 `appraise_good_count`,
             0 `appraise_mid_count`,
             0 `appraise_bad_count`,
             0 `appraise_default_count`,
             0 `order_detail_stats`
      from oi_tmp) t1
select user_id,
       sum(order_count),
       sum(order_activity_count),
       sum(order_activity_reduce_amount),
       sum(order_coupon_count),
       sum(order_coupon_reduce_amount),
       sum(order_original_amount),
       sum(order_final_amount),
       sum(payment_count),
       sum(payment_amount),
       sum(refund_order_count),
       sum(refund_order_num),
       sum(refund_order_amount),
       sum(refund_payment_count),
       sum(refund_payment_num),
       sum(refund_payment_amount),
       sum(coupon_get_count),
       sum(coupon_using_count),
       sum(coupon_used_count),
       sum(appraise_good_count),
       sum(appraise_mid_count),
       sum(appraise_bad_count),
       sum(appraise_default_count),
       sum(order_detail_stats)
group by user_id;
--首日导入
with ci_tmp as
         (
             select dt,
                    user_id,
                    count(if(appraise = '1201', 1, null)) appraise_good_count,
                    count(if(appraise = '1202', 1, null)) appraise_mid_count,
                    count(if(appraise = '1203', 1, null)) appraise_bad_count,
                    count(if(appraise = '1204', 1, null)) appraise_default_count
             from dwd_comment_info
             group by dt, user_id
         ),
     login_tmp as
         (
             select user_id,
                    count(if(last_page_id is null, 1, null)) login_count
             from dwd_page_log
             where dt = '2020-06-14'
               and user_id is not null
             group by user_id
         ),
     cf_tmp as
         (
             select user_id,
                    count(if(action_id = 'cart_add', 1, null))  cart_count,
                    count(if(action_id = 'favor_add', 1, null)) favor_count
             from dwd_action_log
             where dt = '2020-06-14'
               and user_id is not null
             group by user_id
         ),
     oi_tmp as
         (
             select dt,
                    user_id,
                    count(id)                                       order_count,
                    count(if(activity_reduce_amount > 0, id, null)) order_activity_count,
                    sum(activity_reduce_amount)                     order_activity_reduce_amount,
                    count(if(coupon_reduce_amount > 0, id, null))   order_coupon_count,
                    sum(coupon_reduce_amount)                       order_coupon_reduce_amount,
                    sum(original_amount)                            order_original_amount,
                    sum(final_amount)                               order_final_amount
             from dwd_order_info
             group by dt, user_id
         ),
     cu_tmp as
         (
             --先求各个日期的领用数量
             with t1 as
                      (
                          select user_id,
                                 date_format(get_time, 'yyyy-MM-dd')      dt,
                                 count(if(get_time is not null, 1, null)) coupon_get_count
                          from dwd_coupon_use
                          where get_time is not null
                          group by user_id, date_format(get_time, 'yyyy-MM-dd')
                      ),
                  t2 as
                      (
                          select user_id,
                                 date_format(using_time, 'yyyy-MM-dd')      dt,
                                 count(if(using_time is not null, 1, null)) coupon_using_count
                          from dwd_coupon_use
                          where using_time is not null
                          group by user_id, date_format(using_time, 'yyyy-MM-dd')
                      ),
                  t3 as
                      (
                          select user_id,
                                 date_format(used_time, 'yyyy-MM-dd')      dt,
                                 count(if(used_time is not null, 1, null)) coupon_used_count
                          from dwd_coupon_use
                          where used_time is not null
                          group by user_id, date_format(used_time, 'yyyy-MM-dd')
                      )
             from (select user_id,
                          dt,
                          coupon_get_count,
                          0 coupon_using_count,
                          0 coupon_used_count
                   from t1
                   union all
                   select user_id,
                          dt,
                          0 coupon_get_count,
                          coupon_using_count,
                          0 coupon_used_count
                   from t2
                   union all
                   select user_id,
                          dt,
                          0 coupon_get_count,
                          0 coupon_using_count,
                          coupon_used_count
                   from t3) t4
             select user_id,
                    dt,
                    sum(coupon_get_count)   coupon_get_count,
                    sum(coupon_using_count) coupon_using_count,
                    sum(coupon_used_count)  coupon_used_count
             group by user_id, dt
         )


drop table if exists ods_log;
CREATE EXTERNAL TABLE ods_log
(
    `line` string
)
    PARTITIONED BY (`dt` string) -- 按照时间创建分区
    LOCATION '/warehouse/gmall/ods/ods_log'; -- 指定数据在hdfs上的存储位置

DROP TABLE IF EXISTS ods_activity_info;
CREATE EXTERNAL TABLE ods_activity_info
(
    `id`            STRING COMMENT '编号',
    `activity_name` STRING COMMENT '活动名称',
    `activity_type` STRING COMMENT '活动类型',
    `start_time`    STRING COMMENT '开始时间',
    `end_time`      STRING COMMENT '结束时间',
    `create_time`   STRING COMMENT '创建时间'
) COMMENT '活动信息表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_activity_info/';

DROP TABLE IF EXISTS ods_activity_rule;
CREATE EXTERNAL TABLE ods_activity_rule
(
    `id`               STRING COMMENT '编号',
    `activity_id`      STRING COMMENT '活动ID',
    `activity_type`    STRING COMMENT '活动类型',
    `condition_amount` DECIMAL(16, 2) COMMENT '满减金额',
    `condition_num`    BIGINT COMMENT '满减件数',
    `benefit_amount`   DECIMAL(16, 2) COMMENT '优惠金额',
    `benefit_discount` DECIMAL(16, 2) COMMENT '优惠折扣',
    `benefit_level`    STRING COMMENT '优惠级别'
) COMMENT '活动规则表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_activity_rule/';

DROP TABLE IF EXISTS ods_base_category1;
CREATE EXTERNAL TABLE ods_base_category1
(
    `id`   STRING COMMENT 'id',
    `name` STRING COMMENT '名称'
) COMMENT '商品一级分类表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_category1/';

DROP TABLE IF EXISTS ods_base_category2;
CREATE EXTERNAL TABLE ods_base_category2
(
    `id`           STRING COMMENT ' id',
    `name`         STRING COMMENT '名称',
    `category1_id` STRING COMMENT '一级品类id'
) COMMENT '商品二级分类表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_category2/';

DROP TABLE IF EXISTS ods_base_category3;
CREATE EXTERNAL TABLE ods_base_category3
(
    `id`           STRING COMMENT ' id',
    `name`         STRING COMMENT '名称',
    `category2_id` STRING COMMENT '二级品类id'
) COMMENT '商品三级分类表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_category3/';

DROP TABLE IF EXISTS ods_base_dic;
CREATE EXTERNAL TABLE ods_base_dic
(
    `dic_code`     STRING COMMENT '编号',
    `dic_name`     STRING COMMENT '编码名称',
    `parent_code`  STRING COMMENT '父编码',
    `create_time`  STRING COMMENT '创建日期',
    `operate_time` STRING COMMENT '操作日期'
) COMMENT '编码字典表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_dic/';

DROP TABLE IF EXISTS ods_base_province;
CREATE EXTERNAL TABLE ods_base_province
(
    `id`         STRING COMMENT '编号',
    `name`       STRING COMMENT '省份名称',
    `region_id`  STRING COMMENT '地区ID',
    `area_code`  STRING COMMENT '地区编码',
    `iso_code`   STRING COMMENT 'ISO-3166编码，供可视化使用',
    `iso_3166_2` STRING COMMENT 'IOS-3166-2编码，供可视化使用'
) COMMENT '省份表'
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_province/';

DROP TABLE IF EXISTS ods_base_region;
CREATE EXTERNAL TABLE ods_base_region
(
    `id`          STRING COMMENT '编号',
    `region_name` STRING COMMENT '地区名称'
) COMMENT '地区表'
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_region/';

DROP TABLE IF EXISTS ods_base_trademark;
CREATE EXTERNAL TABLE ods_base_trademark
(
    `id`      STRING COMMENT '编号',
    `tm_name` STRING COMMENT '品牌名称'
) COMMENT '品牌表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_base_trademark/';

DROP TABLE IF EXISTS ods_cart_info;
CREATE EXTERNAL TABLE ods_cart_info
(
    `id`           STRING COMMENT '编号',
    `user_id`      STRING COMMENT '用户id',
    `sku_id`       STRING COMMENT 'skuid',
    `cart_price`   DECIMAL(16, 2) COMMENT '放入购物车时价格',
    `sku_num`      BIGINT COMMENT '数量',
    `sku_name`     STRING COMMENT 'sku名称 (冗余)',
    `create_time`  STRING COMMENT '创建时间',
    `operate_time` STRING COMMENT '修改时间',
    `is_ordered`   STRING COMMENT '是否已经下单',
    `order_time`   STRING COMMENT '下单时间',
    `source_type`  STRING COMMENT '来源类型',
    `source_id`    STRING COMMENT '来源编号'
) COMMENT '加购表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_cart_info/';

DROP TABLE IF EXISTS ods_comment_info;
CREATE EXTERNAL TABLE ods_comment_info
(
    `id`          STRING COMMENT '编号',
    `user_id`     STRING COMMENT '用户ID',
    `sku_id`      STRING COMMENT '商品sku',
    `spu_id`      STRING COMMENT '商品spu',
    `order_id`    STRING COMMENT '订单ID',
    `appraise`    STRING COMMENT '评价',
    `create_time` STRING COMMENT '评价时间'
) COMMENT '商品评论表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_comment_info/';

DROP TABLE IF EXISTS ods_coupon_info;
CREATE EXTERNAL TABLE ods_coupon_info
(
    `id`               STRING COMMENT '购物券编号',
    `coupon_name`      STRING COMMENT '购物券名称',
    `coupon_type`      STRING COMMENT '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券',
    `condition_amount` DECIMAL(16, 2) COMMENT '满额数',
    `condition_num`    BIGINT COMMENT '满件数',
    `activity_id`      STRING COMMENT '活动编号',
    `benefit_amount`   DECIMAL(16, 2) COMMENT '减金额',
    `benefit_discount` DECIMAL(16, 2) COMMENT '折扣',
    `create_time`      STRING COMMENT '创建时间',
    `range_type`       STRING COMMENT '范围类型 1、商品 2、品类 3、品牌',
    `limit_num`        BIGINT COMMENT '最多领用次数',
    `taken_count`      BIGINT COMMENT '已领用次数',
    `start_time`       STRING COMMENT '开始领取时间',
    `end_time`         STRING COMMENT '结束领取时间',
    `operate_time`     STRING COMMENT '修改时间',
    `expire_time`      STRING COMMENT '过期时间'
) COMMENT '优惠券表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_coupon_info/';

DROP TABLE IF EXISTS ods_coupon_use;
CREATE EXTERNAL TABLE ods_coupon_use
(
    `id`            STRING COMMENT '编号',
    `coupon_id`     STRING COMMENT '优惠券ID',
    `user_id`       STRING COMMENT 'skuid',
    `order_id`      STRING COMMENT 'spuid',
    `coupon_status` STRING COMMENT '优惠券状态',
    `get_time`      STRING COMMENT '领取时间',
    `using_time`    STRING COMMENT '使用时间(下单)',
    `used_time`     STRING COMMENT '使用时间(支付)',
    `expire_time`   STRING COMMENT '过期时间'
) COMMENT '优惠券领用表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_coupon_use/';

DROP TABLE IF EXISTS ods_favor_info;
CREATE EXTERNAL TABLE ods_favor_info
(
    `id`          STRING COMMENT '编号',
    `user_id`     STRING COMMENT '用户id',
    `sku_id`      STRING COMMENT 'skuid',
    `spu_id`      STRING COMMENT 'spuid',
    `is_cancel`   STRING COMMENT '是否取消',
    `create_time` STRING COMMENT '收藏时间',
    `cancel_time` STRING COMMENT '取消时间'
) COMMENT '商品收藏表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_favor_info/';

DROP TABLE IF EXISTS ods_order_detail;
CREATE EXTERNAL TABLE ods_order_detail
(
    `id`                    STRING COMMENT '编号',
    `order_id`              STRING COMMENT '订单号',
    `sku_id`                STRING COMMENT '商品id',
    `sku_name`              STRING COMMENT '商品名称',
    `order_price`           DECIMAL(16, 2) COMMENT '商品价格',
    `sku_num`               BIGINT COMMENT '商品数量',
    `create_time`           STRING COMMENT '创建时间',
    `source_type`           STRING COMMENT '来源类型',
    `source_id`             STRING COMMENT '来源编号',
    `split_final_amount`    DECIMAL(16, 2) COMMENT '分摊最终金额',
    `split_activity_amount` DECIMAL(16, 2) COMMENT '分摊活动优惠',
    `split_coupon_amount`   DECIMAL(16, 2) COMMENT '分摊优惠券优惠'
) COMMENT '订单详情表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_detail/';

DROP TABLE IF EXISTS ods_order_detail_activity;
CREATE EXTERNAL TABLE ods_order_detail_activity
(
    `id`               STRING COMMENT '编号',
    `order_id`         STRING COMMENT '订单号',
    `order_detail_id`  STRING COMMENT '订单明细id',
    `activity_id`      STRING COMMENT '活动id',
    `activity_rule_id` STRING COMMENT '活动规则id',
    `sku_id`           BIGINT COMMENT '商品id',
    `create_time`      STRING COMMENT '创建时间'
) COMMENT '订单详情活动关联表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_detail_activity/';

DROP TABLE IF EXISTS ods_order_detail_coupon;
CREATE EXTERNAL TABLE ods_order_detail_coupon
(
    `id`              STRING COMMENT '编号',
    `order_id`        STRING COMMENT '订单号',
    `order_detail_id` STRING COMMENT '订单明细id',
    `coupon_id`       STRING COMMENT '优惠券id',
    `coupon_use_id`   STRING COMMENT '优惠券领用记录id',
    `sku_id`          STRING COMMENT '商品id',
    `create_time`     STRING COMMENT '创建时间'
) COMMENT '订单详情活动关联表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_detail_coupon/';

DROP TABLE IF EXISTS ods_order_info;
CREATE EXTERNAL TABLE ods_order_info
(
    `id`                     STRING COMMENT '订单号',
    `final_amount`           DECIMAL(16, 2) COMMENT '订单最终金额',
    `order_status`           STRING COMMENT '订单状态',
    `user_id`                STRING COMMENT '用户id',
    `payment_way`            STRING COMMENT '支付方式',
    `delivery_address`       STRING COMMENT '送货地址',
    `out_trade_no`           STRING COMMENT '支付流水号',
    `create_time`            STRING COMMENT '创建时间',
    `operate_time`           STRING COMMENT '操作时间',
    `expire_time`            STRING COMMENT '过期时间',
    `tracking_no`            STRING COMMENT '物流单编号',
    `province_id`            STRING COMMENT '省份ID',
    `activity_reduce_amount` DECIMAL(16, 2) COMMENT '活动减免金额',
    `coupon_reduce_amount`   DECIMAL(16, 2) COMMENT '优惠券减免金额',
    `original_amount`        DECIMAL(16, 2) COMMENT '订单原价金额',
    `feight_fee`             DECIMAL(16, 2) COMMENT '运费',
    `feight_fee_reduce`      DECIMAL(16, 2) COMMENT '运费减免'
) COMMENT '订单表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_info/';

DROP TABLE IF EXISTS ods_order_refund_info;
CREATE EXTERNAL TABLE ods_order_refund_info
(
    `id`                 STRING COMMENT '编号',
    `user_id`            STRING COMMENT '用户ID',
    `order_id`           STRING COMMENT '订单ID',
    `sku_id`             STRING COMMENT '商品ID',
    `refund_type`        STRING COMMENT '退单类型',
    `refund_num`         BIGINT COMMENT '退单件数',
    `refund_amount`      DECIMAL(16, 2) COMMENT '退单金额',
    `refund_reason_type` STRING COMMENT '退单原因类型',
    `refund_status`      STRING COMMENT '退单状态',--退单状态应包含买家申请、卖家审核、卖家收货、退款完成等状态。此处未涉及到，故该表按增量处理
    `create_time`        STRING COMMENT '退单时间'
) COMMENT '退单表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_refund_info/';

DROP TABLE IF EXISTS ods_order_status_log;
CREATE EXTERNAL TABLE ods_order_status_log
(
    `id`           STRING COMMENT '编号',
    `order_id`     STRING COMMENT '订单ID',
    `order_status` STRING COMMENT '订单状态',
    `operate_time` STRING COMMENT '修改时间'
) COMMENT '订单状态表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_order_status_log/';

DROP TABLE IF EXISTS ods_payment_info;
CREATE EXTERNAL TABLE ods_payment_info
(
    `id`             STRING COMMENT '编号',
    `out_trade_no`   STRING COMMENT '对外业务编号',
    `order_id`       STRING COMMENT '订单编号',
    `user_id`        STRING COMMENT '用户编号',
    `payment_type`   STRING COMMENT '支付类型',
    `trade_no`       STRING COMMENT '交易编号',
    `payment_amount` DECIMAL(16, 2) COMMENT '支付金额',
    `subject`        STRING COMMENT '交易内容',
    `payment_status` STRING COMMENT '支付状态',
    `create_time`    STRING COMMENT '创建时间',
    `callback_time`  STRING COMMENT '回调时间'
) COMMENT '支付流水表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_payment_info/';

DROP TABLE IF EXISTS ods_refund_payment;
CREATE EXTERNAL TABLE ods_refund_payment
(
    `id`            STRING COMMENT '编号',
    `out_trade_no`  STRING COMMENT '对外业务编号',
    `order_id`      STRING COMMENT '订单编号',
    `sku_id`        STRING COMMENT 'SKU编号',
    `payment_type`  STRING COMMENT '支付类型',
    `trade_no`      STRING COMMENT '交易编号',
    `refund_amount` DECIMAL(16, 2) COMMENT '支付金额',
    `subject`       STRING COMMENT '交易内容',
    `refund_status` STRING COMMENT '支付状态',
    `create_time`   STRING COMMENT '创建时间',
    `callback_time` STRING COMMENT '回调时间'
) COMMENT '支付流水表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_refund_payment/';

DROP TABLE IF EXISTS ods_sku_attr_value;
CREATE EXTERNAL TABLE ods_sku_attr_value
(
    `id`         STRING COMMENT '编号',
    `attr_id`    STRING COMMENT '平台属性ID',
    `value_id`   STRING COMMENT '平台属性值ID',
    `sku_id`     STRING COMMENT '商品ID',
    `attr_name`  STRING COMMENT '平台属性名称',
    `value_name` STRING COMMENT '平台属性值名称'
) COMMENT 'sku平台属性表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_sku_attr_value/';

DROP TABLE IF EXISTS ods_sku_info;
CREATE EXTERNAL TABLE ods_sku_info
(
    `id`           STRING COMMENT 'skuId',
    `spu_id`       STRING COMMENT 'spuid',
    `price`        DECIMAL(16, 2) COMMENT '价格',
    `sku_name`     STRING COMMENT '商品名称',
    `sku_desc`     STRING COMMENT '商品描述',
    `weight`       DECIMAL(16, 2) COMMENT '重量',
    `tm_id`        STRING COMMENT '品牌id',
    `category3_id` STRING COMMENT '品类id',
    `is_sale`      STRING COMMENT '是否在售',
    `create_time`  STRING COMMENT '创建时间'
) COMMENT 'SKU商品表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_sku_info/';

DROP TABLE IF EXISTS ods_sku_sale_attr_value;
CREATE EXTERNAL TABLE ods_sku_sale_attr_value
(
    `id`                   STRING COMMENT '编号',
    `sku_id`               STRING COMMENT 'sku_id',
    `spu_id`               STRING COMMENT 'spu_id',
    `sale_attr_value_id`   STRING COMMENT '销售属性值id',
    `sale_attr_id`         STRING COMMENT '销售属性id',
    `sale_attr_name`       STRING COMMENT '销售属性名称',
    `sale_attr_value_name` STRING COMMENT '销售属性值名称'
) COMMENT 'sku销售属性名称'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_sku_sale_attr_value/';

DROP TABLE IF EXISTS ods_spu_info;
CREATE EXTERNAL TABLE ods_spu_info
(
    `id`           STRING COMMENT 'spuid',
    `spu_name`     STRING COMMENT 'spu名称',
    `category3_id` STRING COMMENT '品类id',
    `tm_id`        STRING COMMENT '品牌id'
) COMMENT 'SPU商品表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_spu_info/';

DROP TABLE IF EXISTS ods_user_info;
CREATE EXTERNAL TABLE ods_user_info
(
    `id`           STRING COMMENT '用户id',
    `login_name`   STRING COMMENT '用户名称',
    `nick_name`    STRING COMMENT '用户昵称',
    `name`         STRING COMMENT '用户姓名',
    `phone_num`    STRING COMMENT '手机号码',
    `email`        STRING COMMENT '邮箱',
    `user_level`   STRING COMMENT '用户等级',
    `birthday`     STRING COMMENT '生日',
    `gender`       STRING COMMENT '性别',
    `create_time`  STRING COMMENT '创建时间',
    `operate_time` STRING COMMENT '操作时间'
) COMMENT '用户表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/ods/ods_user_info/';

DROP TABLE IF EXISTS dim_sku_info;
CREATE EXTERNAL TABLE dim_sku_info
(
    `id`                   STRING COMMENT '商品id',
    `price`                DECIMAL(16, 2) COMMENT '商品价格',
    `sku_name`             STRING COMMENT '商品名称',
    `sku_desc`             STRING COMMENT '商品描述',
    `weight`               DECIMAL(16, 2) COMMENT '重量',
    `is_sale`              BOOLEAN COMMENT '是否在售',
    `spu_id`               STRING COMMENT 'spu编号',
    `spu_name`             STRING COMMENT 'spu名称',
    `category3_id`         STRING COMMENT '三级分类id',
    `category3_name`       STRING COMMENT '三级分类名称',
    `category2_id`         STRING COMMENT '二级分类id',
    `category2_name`       STRING COMMENT '二级分类名称',
    `category1_id`         STRING COMMENT '一级分类id',
    `category1_name`       STRING COMMENT '一级分类名称',
    `tm_id`                STRING COMMENT '品牌id',
    `tm_name`              STRING COMMENT '品牌名称',
    `sku_attr_values`      ARRAY<STRUCT<attr_id :STRING,value_id :STRING,attr_name :STRING,value_name
                                        :STRING>> COMMENT '平台属性',
    `sku_sale_attr_values` ARRAY<STRUCT<sale_attr_id :STRING,sale_attr_value_id :STRING,sale_attr_name :STRING,sale_attr_value_name
                                        :STRING>> COMMENT '销售属性',
    `create_time`          STRING COMMENT '创建时间'
) COMMENT '商品维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_sku_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dim_coupon_info;
CREATE EXTERNAL TABLE dim_coupon_info
(
    `id`               STRING COMMENT '购物券编号',
    `coupon_name`      STRING COMMENT '购物券名称',
    `coupon_type`      STRING COMMENT '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券',
    `condition_amount` DECIMAL(16, 2) COMMENT '满额数',
    `condition_num`    BIGINT COMMENT '满件数',
    `activity_id`      STRING COMMENT '活动编号',
    `benefit_amount`   DECIMAL(16, 2) COMMENT '减金额',
    `benefit_discount` DECIMAL(16, 2) COMMENT '折扣',
    `create_time`      STRING COMMENT '创建时间',
    `range_type`       STRING COMMENT '范围类型 1、商品 2、品类 3、品牌',
    `limit_num`        BIGINT COMMENT '最多领取次数',
    `taken_count`      BIGINT COMMENT '已领取次数',
    `start_time`       STRING COMMENT '可以领取的开始日期',
    `end_time`         STRING COMMENT '可以领取的结束日期',
    `operate_time`     STRING COMMENT '修改时间',
    `expire_time`      STRING COMMENT '过期时间'
) COMMENT '优惠券维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_coupon_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dim_activity_rule_info;
CREATE EXTERNAL TABLE dim_activity_rule_info
(
    `activity_rule_id` STRING COMMENT '活动规则ID',
    `activity_id`      STRING COMMENT '活动ID',
    `activity_name`    STRING COMMENT '活动名称',
    `activity_type`    STRING COMMENT '活动类型',
    `start_time`       STRING COMMENT '开始时间',
    `end_time`         STRING COMMENT '结束时间',
    `create_time`      STRING COMMENT '创建时间',
    `condition_amount` DECIMAL(16, 2) COMMENT '满减金额',
    `condition_num`    BIGINT COMMENT '满减件数',
    `benefit_amount`   DECIMAL(16, 2) COMMENT '优惠金额',
    `benefit_discount` DECIMAL(16, 2) COMMENT '优惠折扣',
    `benefit_level`    STRING COMMENT '优惠级别'
) COMMENT '活动信息表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_activity_rule_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dim_base_province;
CREATE EXTERNAL TABLE dim_base_province
(
    `id`            STRING COMMENT 'id',
    `province_name` STRING COMMENT '省市名称',
    `area_code`     STRING COMMENT '地区编码',
    `iso_code`      STRING COMMENT 'ISO-3166编码，供可视化使用',
    `iso_3166_2`    STRING COMMENT 'IOS-3166-2编码，供可视化使用',
    `region_id`     STRING COMMENT '地区id',
    `region_name`   STRING COMMENT '地区名称'
) COMMENT '地区维度表'
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_base_province/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dim_date_info;
CREATE EXTERNAL TABLE dim_date_info
(
    `date_id`    STRING COMMENT '日',
    `week_id`    STRING COMMENT '周ID',
    `week_day`   STRING COMMENT '周几',
    `day`        STRING COMMENT '每月的第几天',
    `month`      STRING COMMENT '第几月',
    `quarter`    STRING COMMENT '第几季度',
    `year`       STRING COMMENT '年',
    `is_workday` STRING COMMENT '是否是工作日',
    `holiday_id` STRING COMMENT '节假日'
) COMMENT '时间维度表'
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_date_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS tmp_dim_date_info;
CREATE EXTERNAL TABLE tmp_dim_date_info
(
    `date_id`    STRING COMMENT '日',
    `week_id`    STRING COMMENT '周ID',
    `week_day`   STRING COMMENT '周几',
    `day`        STRING COMMENT '每月的第几天',
    `month`      STRING COMMENT '第几月',
    `quarter`    STRING COMMENT '第几季度',
    `year`       STRING COMMENT '年',
    `is_workday` STRING COMMENT '是否是工作日',
    `holiday_id` STRING COMMENT '节假日'
) COMMENT '时间维度表'
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    LOCATION '/warehouse/gmall/tmp/tmp_dim_date_info/';


DROP TABLE IF EXISTS dim_user_info;
CREATE EXTERNAL TABLE dim_user_info
(
    `id`           STRING COMMENT '用户id',
    `login_name`   STRING COMMENT '用户名称',
    `nick_name`    STRING COMMENT '用户昵称',
    `name`         STRING COMMENT '用户姓名',
    `phone_num`    STRING COMMENT '手机号码',
    `email`        STRING COMMENT '邮箱',
    `user_level`   STRING COMMENT '用户等级',
    `birthday`     STRING COMMENT '生日',
    `gender`       STRING COMMENT '性别',
    `create_time`  STRING COMMENT '创建时间',
    `operate_time` STRING COMMENT '操作时间',
    `start_date`   STRING COMMENT '开始日期',
    `end_date`     STRING COMMENT '结束日期'
) COMMENT '用户表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_user_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_start_log;
CREATE EXTERNAL TABLE dwd_start_log
(
    `area_code`       STRING COMMENT '地区编码',
    `brand`           STRING COMMENT '手机品牌',
    `channel`         STRING COMMENT '渠道',
    `is_new`          STRING COMMENT '是否首次启动',
    `model`           STRING COMMENT '手机型号',
    `mid_id`          STRING COMMENT '设备id',
    `os`              STRING COMMENT '操作系统',
    `user_id`         STRING COMMENT '会员id',
    `version_code`    STRING COMMENT 'app版本号',
    `entry`           STRING COMMENT 'icon手机图标 notice 通知 install 安装后启动',
    `loading_time`    BIGINT COMMENT '启动加载时间',
    `open_ad_id`      STRING COMMENT '广告页ID ',
    `open_ad_ms`      BIGINT COMMENT '广告总共播放时间',
    `open_ad_skip_ms` BIGINT COMMENT '用户跳过广告时点',
    `ts`              BIGINT COMMENT '时间'
) COMMENT '启动日志表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_start_log'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_page_log;
CREATE EXTERNAL TABLE dwd_page_log
(
    `area_code`      STRING COMMENT '地区编码',
    `brand`          STRING COMMENT '手机品牌',
    `channel`        STRING COMMENT '渠道',
    `is_new`         STRING COMMENT '是否首次启动',
    `model`          STRING COMMENT '手机型号',
    `mid_id`         STRING COMMENT '设备id',
    `os`             STRING COMMENT '操作系统',
    `user_id`        STRING COMMENT '会员id',
    `version_code`   STRING COMMENT 'app版本号',
    `during_time`    BIGINT COMMENT '持续时间毫秒',
    `page_item`      STRING COMMENT '目标id ',
    `page_item_type` STRING COMMENT '目标类型',
    `last_page_id`   STRING COMMENT '上页类型',
    `page_id`        STRING COMMENT '页面ID ',
    `source_type`    STRING COMMENT '来源类型',
    `ts`             bigint
) COMMENT '页面日志表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_page_log'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_action_log;
CREATE EXTERNAL TABLE dwd_action_log
(
    `area_code`      STRING COMMENT '地区编码',
    `brand`          STRING COMMENT '手机品牌',
    `channel`        STRING COMMENT '渠道',
    `is_new`         STRING COMMENT '是否首次启动',
    `model`          STRING COMMENT '手机型号',
    `mid_id`         STRING COMMENT '设备id',
    `os`             STRING COMMENT '操作系统',
    `user_id`        STRING COMMENT '会员id',
    `version_code`   STRING COMMENT 'app版本号',
    `during_time`    BIGINT COMMENT '持续时间毫秒',
    `page_item`      STRING COMMENT '目标id ',
    `page_item_type` STRING COMMENT '目标类型',
    `last_page_id`   STRING COMMENT '上页类型',
    `page_id`        STRING COMMENT '页面id ',
    `source_type`    STRING COMMENT '来源类型',
    `action_id`      STRING COMMENT '动作id',
    `item`           STRING COMMENT '目标id ',
    `item_type`      STRING COMMENT '目标类型',
    `ts`             BIGINT COMMENT '时间'
) COMMENT '动作日志表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_action_log'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_display_log;
CREATE EXTERNAL TABLE dwd_display_log
(
    `area_code`      STRING COMMENT '地区编码',
    `brand`          STRING COMMENT '手机品牌',
    `channel`        STRING COMMENT '渠道',
    `is_new`         STRING COMMENT '是否首次启动',
    `model`          STRING COMMENT '手机型号',
    `mid_id`         STRING COMMENT '设备id',
    `os`             STRING COMMENT '操作系统',
    `user_id`        STRING COMMENT '会员id',
    `version_code`   STRING COMMENT 'app版本号',
    `during_time`    BIGINT COMMENT 'app版本号',
    `page_item`      STRING COMMENT '目标id ',
    `page_item_type` STRING COMMENT '目标类型',
    `last_page_id`   STRING COMMENT '上页类型',
    `page_id`        STRING COMMENT '页面ID ',
    `source_type`    STRING COMMENT '来源类型',
    `ts`             BIGINT COMMENT 'app版本号',
    `display_type`   STRING COMMENT '曝光类型',
    `item`           STRING COMMENT '曝光对象id ',
    `item_type`      STRING COMMENT 'app版本号',
    `order`          BIGINT COMMENT '曝光顺序',
    `pos_id`         BIGINT COMMENT '曝光位置'
) COMMENT '曝光日志表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_display_log'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_error_log;
CREATE EXTERNAL TABLE dwd_error_log
(
    `area_code`       STRING COMMENT '地区编码',
    `brand`           STRING COMMENT '手机品牌',
    `channel`         STRING COMMENT '渠道',
    `is_new`          STRING COMMENT '是否首次启动',
    `model`           STRING COMMENT '手机型号',
    `mid_id`          STRING COMMENT '设备id',
    `os`              STRING COMMENT '操作系统',
    `user_id`         STRING COMMENT '会员id',
    `version_code`    STRING COMMENT 'app版本号',
    `page_item`       STRING COMMENT '目标id ',
    `page_item_type`  STRING COMMENT '目标类型',
    `last_page_id`    STRING COMMENT '上页类型',
    `page_id`         STRING COMMENT '页面ID ',
    `source_type`     STRING COMMENT '来源类型',
    `entry`           STRING COMMENT ' icon手机图标  notice 通知 install 安装后启动',
    `loading_time`    STRING COMMENT '启动加载时间',
    `open_ad_id`      STRING COMMENT '广告页ID ',
    `open_ad_ms`      STRING COMMENT '广告总共播放时间',
    `open_ad_skip_ms` STRING COMMENT '用户跳过广告时点',
    `actions`         STRING COMMENT '动作',
    `displays`        STRING COMMENT '曝光',
    `ts`              STRING COMMENT '时间',
    `error_code`      STRING COMMENT '错误码',
    `msg`             STRING COMMENT '错误信息'
) COMMENT '错误日志表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_error_log'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_comment_info;
CREATE EXTERNAL TABLE dwd_comment_info
(
    `id`          STRING COMMENT '编号',
    `user_id`     STRING COMMENT '用户ID',
    `sku_id`      STRING COMMENT '商品sku',
    `spu_id`      STRING COMMENT '商品spu',
    `order_id`    STRING COMMENT '订单ID',
    `appraise`    STRING COMMENT '评价(好评、中评、差评、默认评价)',
    `create_time` STRING COMMENT '评价时间'
) COMMENT '评价事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_comment_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_order_detail;
CREATE EXTERNAL TABLE dwd_order_detail
(
    `id`                    STRING COMMENT '订单编号',
    `order_id`              STRING COMMENT '订单号',
    `user_id`               STRING COMMENT '用户id',
    `sku_id`                STRING COMMENT 'sku商品id',
    `province_id`           STRING COMMENT '省份ID',
    `activity_id`           STRING COMMENT '活动ID',
    `activity_rule_id`      STRING COMMENT '活动规则ID',
    `coupon_id`             STRING COMMENT '优惠券ID',
    `create_time`           STRING COMMENT '创建时间',
    `source_type`           STRING COMMENT '来源类型',
    `source_id`             STRING COMMENT '来源编号',
    `sku_num`               BIGINT COMMENT '商品数量',
    `original_amount`       DECIMAL(16, 2) COMMENT '原始价格',
    `split_activity_amount` DECIMAL(16, 2) COMMENT '活动优惠分摊',
    `split_coupon_amount`   DECIMAL(16, 2) COMMENT '优惠券优惠分摊',
    `split_final_amount`    DECIMAL(16, 2) COMMENT '最终价格分摊'
) COMMENT '订单明细事实表表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_order_detail/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_order_refund_info;
CREATE EXTERNAL TABLE dwd_order_refund_info
(
    `id`                 STRING COMMENT '编号',
    `user_id`            STRING COMMENT '用户ID',
    `order_id`           STRING COMMENT '订单ID',
    `sku_id`             STRING COMMENT '商品ID',
    `province_id`        STRING COMMENT '地区ID',
    `refund_type`        STRING COMMENT '退单类型',
    `refund_num`         BIGINT COMMENT '退单件数',
    `refund_amount`      DECIMAL(16, 2) COMMENT '退单金额',
    `refund_reason_type` STRING COMMENT '退单原因类型',
    `create_time`        STRING COMMENT '退单时间'
) COMMENT '退单事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_order_refund_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_cart_info;
CREATE EXTERNAL TABLE dwd_cart_info
(
    `id`           STRING COMMENT '编号',
    `user_id`      STRING COMMENT '用户ID',
    `sku_id`       STRING COMMENT '商品ID',
    `source_type`  STRING COMMENT '来源类型',
    `source_id`    STRING COMMENT '来源编号',
    `cart_price`   DECIMAL(16, 2) COMMENT '加入购物车时的价格',
    `is_ordered`   STRING COMMENT '是否已下单',
    `create_time`  STRING COMMENT '创建时间',
    `operate_time` STRING COMMENT '修改时间',
    `order_time`   STRING COMMENT '下单时间',
    `sku_num`      BIGINT COMMENT '加购数量'
) COMMENT '加购事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_cart_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_favor_info;
CREATE EXTERNAL TABLE dwd_favor_info
(
    `id`          STRING COMMENT '编号',
    `user_id`     STRING COMMENT '用户id',
    `sku_id`      STRING COMMENT 'skuid',
    `spu_id`      STRING COMMENT 'spuid',
    `is_cancel`   STRING COMMENT '是否取消',
    `create_time` STRING COMMENT '收藏时间',
    `cancel_time` STRING COMMENT '取消时间'
) COMMENT '收藏事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_favor_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_coupon_use;
CREATE EXTERNAL TABLE dwd_coupon_use
(
    `id`            STRING COMMENT '编号',
    `coupon_id`     STRING COMMENT '优惠券ID',
    `user_id`       STRING COMMENT 'userid',
    `order_id`      STRING COMMENT '订单id',
    `coupon_status` STRING COMMENT '优惠券状态',
    `get_time`      STRING COMMENT '领取时间',
    `using_time`    STRING COMMENT '使用时间(下单)',
    `used_time`     STRING COMMENT '使用时间(支付)',
    `expire_time`   STRING COMMENT '过期时间'
) COMMENT '优惠券领用事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_coupon_use/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_payment_info;
CREATE EXTERNAL TABLE dwd_payment_info
(
    `id`             STRING COMMENT '编号',
    `order_id`       STRING COMMENT '订单编号',
    `user_id`        STRING COMMENT '用户编号',
    `province_id`    STRING COMMENT '地区ID',
    `trade_no`       STRING COMMENT '交易编号',
    `out_trade_no`   STRING COMMENT '对外交易编号',
    `payment_type`   STRING COMMENT '支付类型',
    `payment_amount` DECIMAL(16, 2) COMMENT '支付金额',
    `payment_status` STRING COMMENT '支付状态',
    `create_time`    STRING COMMENT '创建时间',--调用第三方支付接口的时间
    `callback_time`  STRING COMMENT '完成时间'--支付完成时间，即支付成功回调时间
) COMMENT '支付事实表表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_payment_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwd_refund_payment;
CREATE EXTERNAL TABLE dwd_refund_payment
(
    `id`            STRING COMMENT '编号',
    `user_id`       STRING COMMENT '用户ID',
    `order_id`      STRING COMMENT '订单编号',
    `sku_id`        STRING COMMENT 'SKU编号',
    `province_id`   STRING COMMENT '地区ID',
    `trade_no`      STRING COMMENT '交易编号',
    `out_trade_no`  STRING COMMENT '对外交易编号',
    `payment_type`  STRING COMMENT '支付类型',
    `refund_amount` DECIMAL(16, 2) COMMENT '退款金额',
    `refund_status` STRING COMMENT '退款状态',
    `create_time`   STRING COMMENT '创建时间',--调用第三方支付接口的时间
    `callback_time` STRING COMMENT '回调时间'--支付接口回调时间，即支付成功时间
) COMMENT '退款事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_refund_payment/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwd_order_info;
CREATE EXTERNAL TABLE dwd_order_info
(
    `id`                     STRING COMMENT '编号',
    `order_status`           STRING COMMENT '订单状态',
    `user_id`                STRING COMMENT '用户ID',
    `province_id`            STRING COMMENT '地区ID',
    `payment_way`            STRING COMMENT '支付方式',
    `delivery_address`       STRING COMMENT '邮寄地址',
    `out_trade_no`           STRING COMMENT '对外交易编号',
    `tracking_no`            STRING COMMENT '物流单号',
    `create_time`            STRING COMMENT '创建时间(未支付状态)',
    `payment_time`           STRING COMMENT '支付时间(已支付状态)',
    `cancel_time`            STRING COMMENT '取消时间(已取消状态)',
    `finish_time`            STRING COMMENT '完成时间(已完成状态)',
    `refund_time`            STRING COMMENT '退款时间(退款中状态)',
    `refund_finish_time`     STRING COMMENT '退款完成时间(退款完成状态)',
    `expire_time`            STRING COMMENT '过期时间',
    `feight_fee`             DECIMAL(16, 2) COMMENT '运费',
    `feight_fee_reduce`      DECIMAL(16, 2) COMMENT '运费减免',
    `activity_reduce_amount` DECIMAL(16, 2) COMMENT '活动减免',
    `coupon_reduce_amount`   DECIMAL(16, 2) COMMENT '优惠券减免',
    `original_amount`        DECIMAL(16, 2) COMMENT '订单原始价格',
    `final_amount`           DECIMAL(16, 2) COMMENT '订单最终价格'
) COMMENT '订单事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwd/dwd_order_info/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dws_user_action_daycount;
CREATE EXTERNAL TABLE dws_user_action_daycount
(
    `user_id`                      STRING COMMENT '用户id',
    `login_count`                  BIGINT COMMENT '登录次数',
    `cart_count`                   BIGINT COMMENT '加入购物车次数',
    `favor_count`                  BIGINT COMMENT '收藏次数',
    `order_count`                  BIGINT COMMENT '下单次数',
    `order_activity_count`         BIGINT COMMENT '订单参与活动次数',
    `order_activity_reduce_amount` DECIMAL(16, 2) COMMENT '订单减免金额(活动)',
    `order_coupon_count`           BIGINT COMMENT '订单用券次数',
    `order_coupon_reduce_amount`   DECIMAL(16, 2) COMMENT '订单减免金额(优惠券)',
    `order_original_amount`        DECIMAL(16, 2) COMMENT '订单单原始金额',
    `order_final_amount`           DECIMAL(16, 2) COMMENT '订单总金额',
    `payment_count`                BIGINT COMMENT '支付次数',
    `payment_amount`               DECIMAL(16, 2) COMMENT '支付金额',
    `refund_order_count`           BIGINT COMMENT '退单次数',
    `refund_order_num`             BIGINT COMMENT '退单件数',
    `refund_order_amount`          DECIMAL(16, 2) COMMENT '退单金额',
    `refund_payment_count`         BIGINT COMMENT '退款次数',
    `refund_payment_num`           BIGINT COMMENT '退款件数',
    `refund_payment_amount`        DECIMAL(16, 2) COMMENT '退款金额',
    `coupon_get_count`             BIGINT COMMENT '优惠券领取次数',
    `coupon_using_count`           BIGINT COMMENT '优惠券使用(下单)次数',
    `coupon_used_count`            BIGINT COMMENT '优惠券使用(支付)次数',
    `appraise_good_count`          BIGINT COMMENT '好评数',
    `appraise_mid_count`           BIGINT COMMENT '中评数',
    `appraise_bad_count`           BIGINT COMMENT '差评数',
    `appraise_default_count`       BIGINT COMMENT '默认评价数',
    `order_detail_stats`           array<struct<sku_id :string,sku_num :bigint,order_count :bigint,activity_reduce_amount
                                                :decimal(16, 2),coupon_reduce_amount :decimal(16, 2),original_amount
                                                :decimal(16, 2),final_amount :decimal(16, 2)>> COMMENT '下单明细统计'
) COMMENT '每日用户行为'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_user_action_daycount/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dws_sku_action_daycount;
CREATE EXTERNAL TABLE dws_sku_action_daycount
(
    `sku_id`                       STRING COMMENT 'sku_id',
    `order_count`                  BIGINT COMMENT '被下单次数',
    `order_num`                    BIGINT COMMENT '被下单件数',
    `order_activity_count`         BIGINT COMMENT '参与活动被下单次数',
    `order_coupon_count`           BIGINT COMMENT '使用优惠券被下单次数',
    `order_activity_reduce_amount` DECIMAL(16, 2) COMMENT '优惠金额(活动)',
    `order_coupon_reduce_amount`   DECIMAL(16, 2) COMMENT '优惠金额(优惠券)',
    `order_original_amount`        DECIMAL(16, 2) COMMENT '被下单原价金额',
    `order_final_amount`           DECIMAL(16, 2) COMMENT '被下单最终金额',
    `payment_count`                BIGINT COMMENT '被支付次数',
    `payment_num`                  BIGINT COMMENT '被支付件数',
    `payment_amount`               DECIMAL(16, 2) COMMENT '被支付金额',
    `refund_order_count`           BIGINT COMMENT '被退单次数',
    `refund_order_num`             BIGINT COMMENT '被退单件数',
    `refund_order_amount`          DECIMAL(16, 2) COMMENT '被退单金额',
    `refund_payment_count`         BIGINT COMMENT '被退款次数',
    `refund_payment_num`           BIGINT COMMENT '被退款件数',
    `refund_payment_amount`        DECIMAL(16, 2) COMMENT '被退款金额',
    `cart_count`                   BIGINT COMMENT '被加入购物车次数',
    `favor_count`                  BIGINT COMMENT '被收藏次数',
    `appraise_good_count`          BIGINT COMMENT '好评数',
    `appraise_mid_count`           BIGINT COMMENT '中评数',
    `appraise_bad_count`           BIGINT COMMENT '差评数',
    `appraise_default_count`       BIGINT COMMENT '默认评价数'
) COMMENT '每日商品行为'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_sku_action_daycount/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dws_coupon_info_daycount;
CREATE EXTERNAL TABLE dws_coupon_info_daycount
(
    `coupon_id`             STRING COMMENT '优惠券ID',
    `get_count`             BIGINT COMMENT '领取次数',
    `order_count`           BIGINT COMMENT '使用(下单)次数',
    `order_reduce_amount`   DECIMAL(16, 2) COMMENT '使用某券的订单优惠金额',
    `order_original_amount` DECIMAL(16, 2) COMMENT '使用某券的订单原价金额',
    `order_final_amount`    DECIMAL(16, 2) COMMENT '使用某券的订单总价金额',
    `payment_count`         BIGINT COMMENT '使用(支付)次数',
    `payment_reduce_amount` DECIMAL(16, 2) COMMENT '使用某券的支付优惠金额',
    `payment_amount`        DECIMAL(16, 2) COMMENT '使用某券支付的总金额',
    `expire_count`          BIGINT COMMENT '过期次数'
) COMMENT '每日活动统计'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_coupon_info_daycount/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dws_activity_info_daycount;
CREATE EXTERNAL TABLE dws_activity_info_daycount
(
    `activity_rule_id`      STRING COMMENT '活动规则ID',
    `activity_id`           STRING COMMENT '活动ID',
    `order_count`           BIGINT COMMENT '参与某活动某规则下单次数',--注意：针对的是某个活动的某个具体规则
    `order_reduce_amount`   DECIMAL(16, 2) COMMENT '参与某活动某规则下单减免金额',
    `order_original_amount` DECIMAL(16, 2) COMMENT '参与某活动某规则下单原始金额',--只统计参与活动的订单明细,未参与活动的订单明细不统计。
    `order_final_amount`    DECIMAL(16, 2) COMMENT '参与某活动某规则下单最终金额',
    `payment_count`         BIGINT COMMENT '参与某活动某规则支付次数',
    `payment_reduce_amount` DECIMAL(16, 2) COMMENT '参与某活动某规则支付减免金额',
    `payment_amount`        DECIMAL(16, 2) COMMENT '参与某活动某规则支付金额'
) COMMENT '每日活动统计'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_activity_info_daycount/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dws_area_stats_daycount;
CREATE EXTERNAL TABLE dws_area_stats_daycount
(
    `province_id`           STRING COMMENT '地区编号',
    `visit_count`           BIGINT COMMENT '访客访问次数',
    `login_count`           BIGINT COMMENT '用户访问次数',
    `visitor_count`         BIGINT COMMENT '访客人数',
    `user_count`            BIGINT COMMENT '用户人数',
    `order_count`           BIGINT COMMENT '下单次数',
    `order_original_amount` DECIMAL(16, 2) COMMENT '下单原始金额',
    `order_final_amount`    DECIMAL(16, 2) COMMENT '下单最终金额',
    `payment_count`         BIGINT COMMENT '支付次数',
    `payment_amount`        DECIMAL(16, 2) COMMENT '支付金额',
    `refund_order_count`    BIGINT COMMENT '退单次数',
    `refund_order_amount`   DECIMAL(16, 2) COMMENT '退单金额',
    `refund_payment_count`  BIGINT COMMENT '退款次数',
    `refund_payment_amount` DECIMAL(16, 2) COMMENT '退款金额'
) COMMENT '每日地区统计表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_area_stats_daycount/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dws_visitor_action_daycount;
CREATE EXTERNAL TABLE dws_visitor_action_daycount
(
    `mid_id`       STRING COMMENT '设备id',
    `brand`        STRING COMMENT '设备品牌',
    `model`        STRING COMMENT '设备型号',
    `is_new`       STRING COMMENT '是否首次访问',
    `channel`      ARRAY<STRING> COMMENT '渠道',
    `os`           ARRAY<STRING> COMMENT '操作系统',
    `area_code`    ARRAY<STRING> COMMENT '地区ID',
    `version_code` ARRAY<STRING> COMMENT '应用版本',
    `visit_count`  BIGINT COMMENT '访问次数',
    `page_stats`   ARRAY<STRUCT<page_id:STRING,page_count:BIGINT,during_time:BIGINT>> COMMENT '页面访问统计'
) COMMENT '每日设备行为表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_visitor_action_daycount'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwt_user_topic;
CREATE EXTERNAL TABLE dwt_user_topic
(
    `user_id`                               STRING COMMENT '用户id',
    `login_date_first`                      STRING COMMENT '首次活跃日期',
    `login_date_last`                       STRING COMMENT '末次活跃日期',
    `login_date_1d_count`                   STRING COMMENT '最近1日登录次数',
    `login_last_1d_day_count`               BIGINT COMMENT '最近1日登录天数',
    `login_last_7d_count`                   BIGINT COMMENT '最近7日登录次数',
    `login_last_7d_day_count`               BIGINT COMMENT '最近7日登录天数',
    `login_last_30d_count`                  BIGINT COMMENT '最近30日登录次数',
    `login_last_30d_day_count`              BIGINT COMMENT '最近30日登录天数',
    `login_count`                           BIGINT COMMENT '累积登录次数',
    `login_day_count`                       BIGINT COMMENT '累积登录天数',
    `order_date_first`                      STRING COMMENT '首次下单时间',
    `order_date_last`                       STRING COMMENT '末次下单时间',
    `order_last_1d_count`                   BIGINT COMMENT '最近1日下单次数',
    `order_activity_last_1d_count`          BIGINT COMMENT '最近1日订单参与活动次数',
    `order_activity_reduce_last_1d_amount`  DECIMAL(16, 2) COMMENT '最近1日订单减免金额(活动)',
    `order_coupon_last_1d_count`            BIGINT COMMENT '最近1日下单用券次数',
    `order_coupon_reduce_last_1d_amount`    DECIMAL(16, 2) COMMENT '最近1日订单减免金额(优惠券)',
    `order_last_1d_original_amount`         DECIMAL(16, 2) COMMENT '最近1日原始下单金额',
    `order_last_1d_final_amount`            DECIMAL(16, 2) COMMENT '最近1日最终下单金额',
    `order_last_7d_count`                   BIGINT COMMENT '最近7日下单次数',
    `order_activity_last_7d_count`          BIGINT COMMENT '最近7日订单参与活动次数',
    `order_activity_reduce_last_7d_amount`  DECIMAL(16, 2) COMMENT '最近7日订单减免金额(活动)',
    `order_coupon_last_7d_count`            BIGINT COMMENT '最近7日下单用券次数',
    `order_coupon_reduce_last_7d_amount`    DECIMAL(16, 2) COMMENT '最近7日订单减免金额(优惠券)',
    `order_last_7d_original_amount`         DECIMAL(16, 2) COMMENT '最近7日原始下单金额',
    `order_last_7d_final_amount`            DECIMAL(16, 2) COMMENT '最近7日最终下单金额',
    `order_last_30d_count`                  BIGINT COMMENT '最近30日下单次数',
    `order_activity_last_30d_count`         BIGINT COMMENT '最近30日订单参与活动次数',
    `order_activity_reduce_last_30d_amount` DECIMAL(16, 2) COMMENT '最近30日订单减免金额(活动)',
    `order_coupon_last_30d_count`           BIGINT COMMENT '最近30日下单用券次数',
    `order_coupon_reduce_last_30d_amount`   DECIMAL(16, 2) COMMENT '最近30日订单减免金额(优惠券)',
    `order_last_30d_original_amount`        DECIMAL(16, 2) COMMENT '最近30日原始下单金额',
    `order_last_30d_final_amount`           DECIMAL(16, 2) COMMENT '最近30日最终下单金额',
    `order_count`                           BIGINT COMMENT '累积下单次数',
    `order_activity_count`                  BIGINT COMMENT '累积订单参与活动次数',
    `order_activity_reduce_amount`          DECIMAL(16, 2) COMMENT '累积订单减免金额(活动)',
    `order_coupon_count`                    BIGINT COMMENT '累积下单用券次数',
    `order_coupon_reduce_amount`            DECIMAL(16, 2) COMMENT '累积订单减免金额(优惠券)',
    `order_original_amount`                 DECIMAL(16, 2) COMMENT '累积原始下单金额',
    `order_final_amount`                    DECIMAL(16, 2) COMMENT '累积最终下单金额',
    `payment_date_first`                    STRING COMMENT '首次支付时间',
    `payment_date_last`                     STRING COMMENT '末次支付时间',
    `payment_last_1d_count`                 BIGINT COMMENT '最近1日支付次数',
    `payment_last_1d_amount`                DECIMAL(16, 2) COMMENT '最近1日支付金额',
    `payment_last_7d_count`                 BIGINT COMMENT '最近7日支付次数',
    `payment_last_7d_amount`                DECIMAL(16, 2) COMMENT '最近7日支付金额',
    `payment_last_30d_count`                BIGINT COMMENT '最近30日支付次数',
    `payment_last_30d_amount`               DECIMAL(16, 2) COMMENT '最近30日支付金额',
    `payment_count`                         BIGINT COMMENT '累积支付次数',
    `payment_amount`                        DECIMAL(16, 2) COMMENT '累积支付金额',
    `refund_order_last_1d_count`            BIGINT COMMENT '最近1日退单次数',
    `refund_order_last_1d_num`              BIGINT COMMENT '最近1日退单件数',
    `refund_order_last_1d_amount`           DECIMAL(16, 2) COMMENT '最近1日退单金额',
    `refund_order_last_7d_count`            BIGINT COMMENT '最近7日退单次数',
    `refund_order_last_7d_num`              BIGINT COMMENT '最近7日退单件数',
    `refund_order_last_7d_amount`           DECIMAL(16, 2) COMMENT '最近7日退单金额',
    `refund_order_last_30d_count`           BIGINT COMMENT '最近30日退单次数',
    `refund_order_last_30d_num`             BIGINT COMMENT '最近30日退单件数',
    `refund_order_last_30d_amount`          DECIMAL(16, 2) COMMENT '最近30日退单金额',
    `refund_order_count`                    BIGINT COMMENT '累积退单次数',
    `refund_order_num`                      BIGINT COMMENT '累积退单件数',
    `refund_order_amount`                   DECIMAL(16, 2) COMMENT '累积退单金额',
    `refund_payment_last_1d_count`          BIGINT COMMENT '最近1日退款次数',
    `refund_payment_last_1d_num`            BIGINT COMMENT '最近1日退款件数',
    `refund_payment_last_1d_amount`         DECIMAL(16, 2) COMMENT '最近1日退款金额',
    `refund_payment_last_7d_count`          BIGINT COMMENT '最近7日退款次数',
    `refund_payment_last_7d_num`            BIGINT COMMENT '最近7日退款件数',
    `refund_payment_last_7d_amount`         DECIMAL(16, 2) COMMENT '最近7日退款金额',
    `refund_payment_last_30d_count`         BIGINT COMMENT '最近30日退款次数',
    `refund_payment_last_30d_num`           BIGINT COMMENT '最近30日退款件数',
    `refund_payment_last_30d_amount`        DECIMAL(16, 2) COMMENT '最近30日退款金额',
    `refund_payment_count`                  BIGINT COMMENT '累积退款次数',
    `refund_payment_num`                    BIGINT COMMENT '累积退款件数',
    `refund_payment_amount`                 DECIMAL(16, 2) COMMENT '累积退款金额',
    `cart_last_1d_count`                    BIGINT COMMENT '最近1日加入购物车次数',
    `cart_last_7d_count`                    BIGINT COMMENT '最近7日加入购物车次数',
    `cart_last_30d_count`                   BIGINT COMMENT '最近30日加入购物车次数',
    `cart_count`                            BIGINT COMMENT '累积加入购物车次数',
    `favor_last_1d_count`                   BIGINT COMMENT '最近1日收藏次数',
    `favor_last_7d_count`                   BIGINT COMMENT '最近7日收藏次数',
    `favor_last_30d_count`                  BIGINT COMMENT '最近30日收藏次数',
    `favor_count`                           BIGINT COMMENT '累积收藏次数',
    `coupon_last_1d_get_count`              BIGINT COMMENT '最近1日领券次数',
    `coupon_last_1d_using_count`            BIGINT COMMENT '最近1日用券(下单)次数',
    `coupon_last_1d_used_count`             BIGINT COMMENT '最近1日用券(支付)次数',
    `coupon_last_7d_get_count`              BIGINT COMMENT '最近7日领券次数',
    `coupon_last_7d_using_count`            BIGINT COMMENT '最近7日用券(下单)次数',
    `coupon_last_7d_used_count`             BIGINT COMMENT '最近7日用券(支付)次数',
    `coupon_last_30d_get_count`             BIGINT COMMENT '最近30日领券次数',
    `coupon_last_30d_using_count`           BIGINT COMMENT '最近30日用券(下单)次数',
    `coupon_last_30d_used_count`            BIGINT COMMENT '最近30日用券(支付)次数',
    `coupon_get_count`                      BIGINT COMMENT '累积领券次数',
    `coupon_using_count`                    BIGINT COMMENT '累积用券(下单)次数',
    `coupon_used_count`                     BIGINT COMMENT '累积用券(支付)次数',
    `appraise_last_1d_good_count`           BIGINT COMMENT '最近1日好评次数',
    `appraise_last_1d_mid_count`            BIGINT COMMENT '最近1日中评次数',
    `appraise_last_1d_bad_count`            BIGINT COMMENT '最近1日差评次数',
    `appraise_last_1d_default_count`        BIGINT COMMENT '最近1日默认评价次数',
    `appraise_last_7d_good_count`           BIGINT COMMENT '最近7日好评次数',
    `appraise_last_7d_mid_count`            BIGINT COMMENT '最近7日中评次数',
    `appraise_last_7d_bad_count`            BIGINT COMMENT '最近7日差评次数',
    `appraise_last_7d_default_count`        BIGINT COMMENT '最近7日默认评价次数',
    `appraise_last_30d_good_count`          BIGINT COMMENT '最近30日好评次数',
    `appraise_last_30d_mid_count`           BIGINT COMMENT '最近30日中评次数',
    `appraise_last_30d_bad_count`           BIGINT COMMENT '最近30日差评次数',
    `appraise_last_30d_default_count`       BIGINT COMMENT '最近30日默认评价次数',
    `appraise_good_count`                   BIGINT COMMENT '累积好评次数',
    `appraise_mid_count`                    BIGINT COMMENT '累积中评次数',
    `appraise_bad_count`                    BIGINT COMMENT '累积差评次数',
    `appraise_default_count`                BIGINT COMMENT '累积默认评价次数'
) COMMENT '会员主题宽表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_user_topic/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwt_sku_topic;
CREATE EXTERNAL TABLE dwt_sku_topic
(
    `sku_id`                                STRING COMMENT 'sku_id',
    `order_last_1d_count`                   BIGINT COMMENT '最近1日被下单次数',
    `order_last_1d_num`                     BIGINT COMMENT '最近1日被下单件数',
    `order_activity_last_1d_count`          BIGINT COMMENT '最近1日参与活动被下单次数',
    `order_coupon_last_1d_count`            BIGINT COMMENT '最近1日使用优惠券被下单次数',
    `order_activity_reduce_last_1d_amount`  DECIMAL(16, 2) COMMENT '最近1日优惠金额(活动)',
    `order_coupon_reduce_last_1d_amount`    DECIMAL(16, 2) COMMENT '最近1日优惠金额(优惠券)',
    `order_last_1d_original_amount`         DECIMAL(16, 2) COMMENT '最近1日被下单原始金额',
    `order_last_1d_final_amount`            DECIMAL(16, 2) COMMENT '最近1日被下单最终金额',
    `order_last_7d_count`                   BIGINT COMMENT '最近7日被下单次数',
    `order_last_7d_num`                     BIGINT COMMENT '最近7日被下单件数',
    `order_activity_last_7d_count`          BIGINT COMMENT '最近7日参与活动被下单次数',
    `order_coupon_last_7d_count`            BIGINT COMMENT '最近7日使用优惠券被下单次数',
    `order_activity_reduce_last_7d_amount`  DECIMAL(16, 2) COMMENT '最近7日优惠金额(活动)',
    `order_coupon_reduce_last_7d_amount`    DECIMAL(16, 2) COMMENT '最近7日优惠金额(优惠券)',
    `order_last_7d_original_amount`         DECIMAL(16, 2) COMMENT '最近7日被下单原始金额',
    `order_last_7d_final_amount`            DECIMAL(16, 2) COMMENT '最近7日被下单最终金额',
    `order_last_30d_count`                  BIGINT COMMENT '最近30日被下单次数',
    `order_last_30d_num`                    BIGINT COMMENT '最近30日被下单件数',
    `order_activity_last_30d_count`         BIGINT COMMENT '最近30日参与活动被下单次数',
    `order_coupon_last_30d_count`           BIGINT COMMENT '最近30日使用优惠券被下单次数',
    `order_activity_reduce_last_30d_amount` DECIMAL(16, 2) COMMENT '最近30日优惠金额(活动)',
    `order_coupon_reduce_last_30d_amount`   DECIMAL(16, 2) COMMENT '最近30日优惠金额(优惠券)',
    `order_last_30d_original_amount`        DECIMAL(16, 2) COMMENT '最近30日被下单原始金额',
    `order_last_30d_final_amount`           DECIMAL(16, 2) COMMENT '最近30日被下单最终金额',
    `order_count`                           BIGINT COMMENT '累积被下单次数',
    `order_num`                             BIGINT COMMENT '累积被下单件数',
    `order_activity_count`                  BIGINT COMMENT '累积参与活动被下单次数',
    `order_coupon_count`                    BIGINT COMMENT '累积使用优惠券被下单次数',
    `order_activity_reduce_amount`          DECIMAL(16, 2) COMMENT '累积优惠金额(活动)',
    `order_coupon_reduce_amount`            DECIMAL(16, 2) COMMENT '累积优惠金额(优惠券)',
    `order_original_amount`                 DECIMAL(16, 2) COMMENT '累积被下单原始金额',
    `order_final_amount`                    DECIMAL(16, 2) COMMENT '累积被下单最终金额',
    `payment_last_1d_count`                 BIGINT COMMENT '最近1日被支付次数',
    `payment_last_1d_num`                   BIGINT COMMENT '最近1日被支付件数',
    `payment_last_1d_amount`                DECIMAL(16, 2) COMMENT '最近1日被支付金额',
    `payment_last_7d_count`                 BIGINT COMMENT '最近7日被支付次数',
    `payment_last_7d_num`                   BIGINT COMMENT '最近7日被支付件数',
    `payment_last_7d_amount`                DECIMAL(16, 2) COMMENT '最近7日被支付金额',
    `payment_last_30d_count`                BIGINT COMMENT '最近30日被支付次数',
    `payment_last_30d_num`                  BIGINT COMMENT '最近30日被支付件数',
    `payment_last_30d_amount`               DECIMAL(16, 2) COMMENT '最近30日被支付金额',
    `payment_count`                         BIGINT COMMENT '累积被支付次数',
    `payment_num`                           BIGINT COMMENT '累积被支付件数',
    `payment_amount`                        DECIMAL(16, 2) COMMENT '累积被支付金额',
    `refund_order_last_1d_count`            BIGINT COMMENT '最近1日退单次数',
    `refund_order_last_1d_num`              BIGINT COMMENT '最近1日退单件数',
    `refund_order_last_1d_amount`           DECIMAL(16, 2) COMMENT '最近1日退单金额',
    `refund_order_last_7d_count`            BIGINT COMMENT '最近7日退单次数',
    `refund_order_last_7d_num`              BIGINT COMMENT '最近7日退单件数',
    `refund_order_last_7d_amount`           DECIMAL(16, 2) COMMENT '最近7日退单金额',
    `refund_order_last_30d_count`           BIGINT COMMENT '最近30日退单次数',
    `refund_order_last_30d_num`             BIGINT COMMENT '最近30日退单件数',
    `refund_order_last_30d_amount`          DECIMAL(16, 2) COMMENT '最近30日退单金额',
    `refund_order_count`                    BIGINT COMMENT '累积退单次数',
    `refund_order_num`                      BIGINT COMMENT '累积退单件数',
    `refund_order_amount`                   DECIMAL(16, 2) COMMENT '累积退单金额',
    `refund_payment_last_1d_count`          BIGINT COMMENT '最近1日退款次数',
    `refund_payment_last_1d_num`            BIGINT COMMENT '最近1日退款件数',
    `refund_payment_last_1d_amount`         DECIMAL(16, 2) COMMENT '最近1日退款金额',
    `refund_payment_last_7d_count`          BIGINT COMMENT '最近7日退款次数',
    `refund_payment_last_7d_num`            BIGINT COMMENT '最近7日退款件数',
    `refund_payment_last_7d_amount`         DECIMAL(16, 2) COMMENT '最近7日退款金额',
    `refund_payment_last_30d_count`         BIGINT COMMENT '最近30日退款次数',
    `refund_payment_last_30d_num`           BIGINT COMMENT '最近30日退款件数',
    `refund_payment_last_30d_amount`        DECIMAL(16, 2) COMMENT '最近30日退款金额',
    `refund_payment_count`                  BIGINT COMMENT '累积退款次数',
    `refund_payment_num`                    BIGINT COMMENT '累积退款件数',
    `refund_payment_amount`                 DECIMAL(16, 2) COMMENT '累积退款金额',
    `cart_last_1d_count`                    BIGINT COMMENT '最近1日被加入购物车次数',
    `cart_last_7d_count`                    BIGINT COMMENT '最近7日被加入购物车次数',
    `cart_last_30d_count`                   BIGINT COMMENT '最近30日被加入购物车次数',
    `cart_count`                            BIGINT COMMENT '累积被加入购物车次数',
    `favor_last_1d_count`                   BIGINT COMMENT '最近1日被收藏次数',
    `favor_last_7d_count`                   BIGINT COMMENT '最近7日被收藏次数',
    `favor_last_30d_count`                  BIGINT COMMENT '最近30日被收藏次数',
    `favor_count`                           BIGINT COMMENT '累积被收藏次数',
    `appraise_last_1d_good_count`           BIGINT COMMENT '最近1日好评数',
    `appraise_last_1d_mid_count`            BIGINT COMMENT '最近1日中评数',
    `appraise_last_1d_bad_count`            BIGINT COMMENT '最近1日差评数',
    `appraise_last_1d_default_count`        BIGINT COMMENT '最近1日默认评价数',
    `appraise_last_7d_good_count`           BIGINT COMMENT '最近7日好评数',
    `appraise_last_7d_mid_count`            BIGINT COMMENT '最近7日中评数',
    `appraise_last_7d_bad_count`            BIGINT COMMENT '最近7日差评数',
    `appraise_last_7d_default_count`        BIGINT COMMENT '最近7日默认评价数',
    `appraise_last_30d_good_count`          BIGINT COMMENT '最近30日好评数',
    `appraise_last_30d_mid_count`           BIGINT COMMENT '最近30日中评数',
    `appraise_last_30d_bad_count`           BIGINT COMMENT '最近30日差评数',
    `appraise_last_30d_default_count`       BIGINT COMMENT '最近30日默认评价数',
    `appraise_good_count`                   BIGINT COMMENT '累积好评数',
    `appraise_mid_count`                    BIGINT COMMENT '累积中评数',
    `appraise_bad_count`                    BIGINT COMMENT '累积差评数',
    `appraise_default_count`                BIGINT COMMENT '累积默认评价数'
) COMMENT '商品主题宽表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_sku_topic/'
    TBLPROPERTIES ("orc.compress" = "snappy");


DROP TABLE IF EXISTS dwt_visitor_topic;
CREATE EXTERNAL TABLE dwt_visitor_topic
(
    `mid_id`                   STRING COMMENT '设备id',
    `brand`                    STRING COMMENT '手机品牌',
    `model`                    STRING COMMENT '手机型号',
    `channel`                  ARRAY<STRING> COMMENT '渠道',
    `os`                       ARRAY<STRING> COMMENT '操作系统',
    `area_code`                ARRAY<STRING> COMMENT '地区ID',
    `version_code`             ARRAY<STRING> COMMENT '应用版本',
    `visit_date_first`         STRING COMMENT '首次访问时间',
    `visit_date_last`          STRING COMMENT '末次访问时间',
    `visit_last_1d_count`      BIGINT COMMENT '最近1日访问次数',
    `visit_last_1d_day_count`  BIGINT COMMENT '最近1日访问天数',
    `visit_last_7d_count`      BIGINT COMMENT '最近7日访问次数',
    `visit_last_7d_day_count`  BIGINT COMMENT '最近7日访问天数',
    `visit_last_30d_count`     BIGINT COMMENT '最近30日访问次数',
    `visit_last_30d_day_count` BIGINT COMMENT '最近30日访问天数',
    `visit_count`              BIGINT COMMENT '累积访问次数',--用户行为日志历史数据无法获取，故该字段实为从数仓搭建日至今的累积值
    `visit_day_count`          BIGINT COMMENT '累积访问天数'--用户行为日志历史数据无法获取，故该字段实为从数仓搭建日至今的累积值
) COMMENT '设备主题宽表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_visitor_topic'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwt_coupon_topic;
CREATE EXTERNAL TABLE dwt_coupon_topic
(
    `coupon_id`                      STRING COMMENT '优惠券ID',
    `get_last_1d_count`              BIGINT COMMENT '最近1日领取次数',
    `get_last_7d_count`              BIGINT COMMENT '最近7日领取次数',
    `get_last_30d_count`             BIGINT COMMENT '最近30日领取次数',
    `get_count`                      BIGINT COMMENT '累积领取次数',
    `order_last_1d_count`            BIGINT COMMENT '最近1日使用某券下单次数',
    `order_last_1d_reduce_amount`    DECIMAL(16, 2) COMMENT '最近1日使用某券下单优惠金额',
    `order_last_1d_original_amount`  DECIMAL(16, 2) COMMENT '最近1日使用某券下单原始金额',
    `order_last_1d_final_amount`     DECIMAL(16, 2) COMMENT '最近1日使用某券下单最终金额',
    `order_last_7d_count`            BIGINT COMMENT '最近7日使用某券下单次数',
    `order_last_7d_reduce_amount`    DECIMAL(16, 2) COMMENT '最近7日使用某券下单优惠金额',
    `order_last_7d_original_amount`  DECIMAL(16, 2) COMMENT '最近7日使用某券下单原始金额',
    `order_last_7d_final_amount`     DECIMAL(16, 2) COMMENT '最近7日使用某券下单最终金额',
    `order_last_30d_count`           BIGINT COMMENT '最近30日使用某券下单次数',
    `order_last_30d_reduce_amount`   DECIMAL(16, 2) COMMENT '最近30日使用某券下单优惠金额',
    `order_last_30d_original_amount` DECIMAL(16, 2) COMMENT '最近30日使用某券下单原始金额',
    `order_last_30d_final_amount`    DECIMAL(16, 2) COMMENT '最近30日使用某券下单最终金额',
    `order_count`                    BIGINT COMMENT '累积使用(下单)次数',
    `order_reduce_amount`            DECIMAL(16, 2) COMMENT '使用某券累积下单优惠金额',
    `order_original_amount`          DECIMAL(16, 2) COMMENT '使用某券累积下单原始金额',
    `order_final_amount`             DECIMAL(16, 2) COMMENT '使用某券累积下单最终金额',
    `payment_last_1d_count`          BIGINT COMMENT '最近1日使用某券支付次数',
    `payment_last_1d_reduce_amount`  DECIMAL(16, 2) COMMENT '最近1日使用某券优惠金额',
    `payment_last_1d_amount`         DECIMAL(16, 2) COMMENT '最近1日使用某券支付金额',
    `payment_last_7d_count`          BIGINT COMMENT '最近7日使用某券支付次数',
    `payment_last_7d_reduce_amount`  DECIMAL(16, 2) COMMENT '最近7日使用某券优惠金额',
    `payment_last_7d_amount`         DECIMAL(16, 2) COMMENT '最近7日使用某券支付金额',
    `payment_last_30d_count`         BIGINT COMMENT '最近30日使用某券支付次数',
    `payment_last_30d_reduce_amount` DECIMAL(16, 2) COMMENT '最近30日使用某券优惠金额',
    `payment_last_30d_amount`        DECIMAL(16, 2) COMMENT '最近30日使用某券支付金额',
    `payment_count`                  BIGINT COMMENT '累积使用(支付)次数',
    `payment_reduce_amount`          DECIMAL(16, 2) COMMENT '使用某券累积优惠金额',
    `payment_amount`                 DECIMAL(16, 2) COMMENT '使用某券累积支付金额',
    `expire_last_1d_count`           BIGINT COMMENT '最近1日过期次数',
    `expire_last_7d_count`           BIGINT COMMENT '最近7日过期次数',
    `expire_last_30d_count`          BIGINT COMMENT '最近30日过期次数',
    `expire_count`                   BIGINT COMMENT '累积过期次数'
) comment '优惠券主题表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_coupon_topic/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwt_activity_topic;
CREATE EXTERNAL TABLE dwt_activity_topic
(
    `activity_rule_id`              STRING COMMENT '活动规则ID',
    `activity_id`                   STRING COMMENT '活动ID',
    `order_last_1d_count`           BIGINT COMMENT '最近1日参与某活动某规则下单次数',
    `order_last_1d_reduce_amount`   DECIMAL(16, 2) COMMENT '最近1日参与某活动某规则下单优惠金额',
    `order_last_1d_original_amount` DECIMAL(16, 2) COMMENT '最近1日参与某活动某规则下单原始金额',
    `order_last_1d_final_amount`    DECIMAL(16, 2) COMMENT '最近1日参与某活动某规则下单最终金额',
    `order_count`                   BIGINT COMMENT '参与某活动某规则累积下单次数',
    `order_reduce_amount`           DECIMAL(16, 2) COMMENT '参与某活动某规则累积下单优惠金额',
    `order_original_amount`         DECIMAL(16, 2) COMMENT '参与某活动某规则累积下单原始金额',
    `order_final_amount`            DECIMAL(16, 2) COMMENT '参与某活动某规则累积下单最终金额',
    `payment_last_1d_count`         BIGINT COMMENT '最近1日参与某活动某规则支付次数',
    `payment_last_1d_reduce_amount` DECIMAL(16, 2) COMMENT '最近1日参与某活动某规则支付优惠金额',
    `payment_last_1d_amount`        DECIMAL(16, 2) COMMENT '最近1日参与某活动某规则支付金额',
    `payment_count`                 BIGINT COMMENT '参与某活动某规则累积支付次数',
    `payment_reduce_amount`         DECIMAL(16, 2) COMMENT '参与某活动某规则累积支付优惠金额',
    `payment_amount`                DECIMAL(16, 2) COMMENT '参与某活动某规则累积支付金额'
) COMMENT '活动主题宽表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_activity_topic/'
    TBLPROPERTIES ("orc.compress" = "snappy");

DROP TABLE IF EXISTS dwt_area_topic;
CREATE EXTERNAL TABLE dwt_area_topic
(
    `province_id`                    STRING COMMENT '编号',
    `visit_last_1d_count`            BIGINT COMMENT '最近1日访客访问次数',
    `login_last_1d_count`            BIGINT COMMENT '最近1日用户访问次数',
    `visit_last_7d_count`            BIGINT COMMENT '最近7访客访问次数',
    `login_last_7d_count`            BIGINT COMMENT '最近7日用户访问次数',
    `visit_last_30d_count`           BIGINT COMMENT '最近30日访客访问次数',
    `login_last_30d_count`           BIGINT COMMENT '最近30日用户访问次数',
    `visit_count`                    BIGINT COMMENT '累积访客访问次数',
    `login_count`                    BIGINT COMMENT '累积用户访问次数',
    `order_last_1d_count`            BIGINT COMMENT '最近1天下单次数',
    `order_last_1d_original_amount`  DECIMAL(16, 2) COMMENT '最近1天下单原始金额',
    `order_last_1d_final_amount`     DECIMAL(16, 2) COMMENT '最近1天下单最终金额',
    `order_last_7d_count`            BIGINT COMMENT '最近7天下单次数',
    `order_last_7d_original_amount`  DECIMAL(16, 2) COMMENT '最近7天下单原始金额',
    `order_last_7d_final_amount`     DECIMAL(16, 2) COMMENT '最近7天下单最终金额',
    `order_last_30d_count`           BIGINT COMMENT '最近30天下单次数',
    `order_last_30d_original_amount` DECIMAL(16, 2) COMMENT '最近30天下单原始金额',
    `order_last_30d_final_amount`    DECIMAL(16, 2) COMMENT '最近30天下单最终金额',
    `order_count`                    BIGINT COMMENT '累积下单次数',
    `order_original_amount`          DECIMAL(16, 2) COMMENT '累积下单原始金额',
    `order_final_amount`             DECIMAL(16, 2) COMMENT '累积下单最终金额',
    `payment_last_1d_count`          BIGINT COMMENT '最近1天支付次数',
    `payment_last_1d_amount`         DECIMAL(16, 2) COMMENT '最近1天支付金额',
    `payment_last_7d_count`          BIGINT COMMENT '最近7天支付次数',
    `payment_last_7d_amount`         DECIMAL(16, 2) COMMENT '最近7天支付金额',
    `payment_last_30d_count`         BIGINT COMMENT '最近30天支付次数',
    `payment_last_30d_amount`        DECIMAL(16, 2) COMMENT '最近30天支付金额',
    `payment_count`                  BIGINT COMMENT '累积支付次数',
    `payment_amount`                 DECIMAL(16, 2) COMMENT '累积支付金额',
    `refund_order_last_1d_count`     BIGINT COMMENT '最近1天退单次数',
    `refund_order_last_1d_amount`    DECIMAL(16, 2) COMMENT '最近1天退单金额',
    `refund_order_last_7d_count`     BIGINT COMMENT '最近7天退单次数',
    `refund_order_last_7d_amount`    DECIMAL(16, 2) COMMENT '最近7天退单金额',
    `refund_order_last_30d_count`    BIGINT COMMENT '最近30天退单次数',
    `refund_order_last_30d_amount`   DECIMAL(16, 2) COMMENT '最近30天退单金额',
    `refund_order_count`             BIGINT COMMENT '累积退单次数',
    `refund_order_amount`            DECIMAL(16, 2) COMMENT '累积退单金额',
    `refund_payment_last_1d_count`   BIGINT COMMENT '最近1天退款次数',
    `refund_payment_last_1d_amount`  DECIMAL(16, 2) COMMENT '最近1天退款金额',
    `refund_payment_last_7d_count`   BIGINT COMMENT '最近7天退款次数',
    `refund_payment_last_7d_amount`  DECIMAL(16, 2) COMMENT '最近7天退款金额',
    `refund_payment_last_30d_count`  BIGINT COMMENT '最近30天退款次数',
    `refund_payment_last_30d_amount` DECIMAL(16, 2) COMMENT '最近30天退款金额',
    `refund_payment_count`           BIGINT COMMENT '累积退款次数',
    `refund_payment_amount`          DECIMAL(16, 2) COMMENT '累积退款金额'
) COMMENT '地区主题宽表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dwt/dwt_area_topic/'
    TBLPROPERTIES ("orc.compress" = "snappy");

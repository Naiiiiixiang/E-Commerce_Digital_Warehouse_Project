create database gmall_report character set utf8mb4 collate utf8mb4_general_ci;
use gmall_report;
DROP TABLE IF EXISTS ads_visit_stats;
CREATE TABLE `ads_visit_stats`
(
    `dt`               DATE         NOT NULL COMMENT '统计日期',
    `is_new`           VARCHAR(255) NOT NULL COMMENT '新老标识,1:新,0:老',
    `channel`          VARCHAR(255) NOT NULL COMMENT '渠道',
    `uv_count`         BIGINT(20)     DEFAULT NULL COMMENT '日活(访问人数)',
    `duration_sec`     BIGINT(20)     DEFAULT NULL COMMENT '页面停留总时长',
    `avg_duration_sec` BIGINT(20)     DEFAULT NULL COMMENT '一次会话，页面停留平均时长',
    `page_count`       BIGINT(20)     DEFAULT NULL COMMENT '页面总浏览数',
    `avg_page_count`   BIGINT(20)     DEFAULT NULL COMMENT '一次会话，页面平均浏览数',
    `sv_count`         BIGINT(20)     DEFAULT NULL COMMENT '会话次数',
    `bounce_count`     BIGINT(20)     DEFAULT NULL COMMENT '跳出数',
    `bounce_rate`      DECIMAL(16, 2) DEFAULT NULL COMMENT '跳出率',
    PRIMARY KEY (`dt`, `is_new`, `channel`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS ads_page_path;
CREATE TABLE `ads_page_path`
(
    `dt`         DATE NOT NULL COMMENT '统计日期',
    `source`     VARCHAR(255) DEFAULT NULL COMMENT '跳转起始页面',
    `target`     VARCHAR(255) DEFAULT NULL COMMENT '跳转终到页面',
    `path_count` BIGINT(255)  DEFAULT NULL COMMENT '跳转次数',
    UNIQUE KEY (`dt`, `source`, `target`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_user_total;
CREATE TABLE `ads_user_total`
(
    `dt`                   DATE NOT NULL COMMENT '统计日期',
    `new_user_count`       BIGINT(20)     DEFAULT NULL COMMENT '新注册用户数',
    `new_order_user_count` BIGINT(20)     DEFAULT NULL COMMENT '新增下单用户数',
    `order_final_amount`   DECIMAL(16, 2) DEFAULT NULL COMMENT '下单总金额',
    `order_user_count`     BIGINT(20)     DEFAULT NULL COMMENT '下单用户数',
    `no_order_user_count`  BIGINT(20)     DEFAULT NULL COMMENT '未下单用户数(具体指活跃用户中未下单用户)',
    PRIMARY KEY (`dt`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS ads_user_change;
CREATE TABLE `ads_user_change`
(
    `dt`               DATE NOT NULL COMMENT '统计日期',
    `user_churn_count` BIGINT(20) DEFAULT NULL COMMENT '流失用户数',
    `user_back_count`  BIGINT(20) DEFAULT NULL COMMENT '回流用户数',
    PRIMARY KEY (`dt`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS ads_user_action;
CREATE TABLE `ads_user_action`
(
    `dt`                DATE NOT NULL COMMENT '统计日期',
    `home_count`        BIGINT(20) DEFAULT NULL COMMENT '浏览首页人数',
    `good_detail_count` BIGINT(20) DEFAULT NULL COMMENT '浏览商品详情页人数',
    `cart_count`        BIGINT(20) DEFAULT NULL COMMENT '加入购物车人数',
    `order_count`       BIGINT(20) DEFAULT NULL COMMENT '下单人数',
    `payment_count`     BIGINT(20) DEFAULT NULL COMMENT '支付人数',
    PRIMARY KEY (`dt`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_user_retention;
CREATE TABLE `ads_user_retention`
(
    `dt`              DATE           DEFAULT NULL COMMENT '统计日期',
    `create_date`     VARCHAR(255) NOT NULL COMMENT '用户新增日期',
    `retention_day`   BIGINT(20)   NOT NULL COMMENT '截至当前日期留存天数',
    `retention_count` BIGINT(20)     DEFAULT NULL COMMENT '留存用户数量',
    `new_user_count`  BIGINT(20)     DEFAULT NULL COMMENT '新增用户数量',
    `retention_rate`  DECIMAL(16, 2) DEFAULT NULL COMMENT '留存率',
    PRIMARY KEY (`create_date`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_user_continuity;
CREATE TABLE `ads_user_continuity`
(
    `dt`         DATE NOT NULL COMMENT '统计日期',
    `user_count` BIGINT(20) DEFAULT NULL COMMENT '最近七天内连续三天活跃用户数',
    PRIMARY KEY (`dt`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_user_online_count_min;
CREATE TABLE ads_user_online_count_min
(
    `dt`                DATE         NOT NULL COMMENT '统计日期',
    `mins`              VARCHAR(255) NOT NULL COMMENT '分钟，要求格式为yyyy-MM-dd HH:mm',
    `user_online_count` BIGINT(20) DEFAULT NULL COMMENT '在线用户数',
    PRIMARY KEY (`dt`, `mins`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_order_total;
CREATE TABLE `ads_order_total`
(
    `dt`               DATE NOT NULL COMMENT '统计日期',
    `order_count`      BIGINT(255)    DEFAULT NULL COMMENT '订单数',
    `order_amount`     DECIMAL(16, 2) DEFAULT NULL COMMENT '订单金额',
    `order_user_count` BIGINT(255)    DEFAULT NULL COMMENT '下单人数',
    PRIMARY KEY (`dt`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_order_by_province;
CREATE TABLE `ads_order_by_province`
(
    `dt`              DATE         NOT NULL,
    `province_id`     VARCHAR(255) NOT NULL COMMENT '统计日期',
    `province_name`   VARCHAR(255)   DEFAULT NULL COMMENT '省份名称',
    `area_code`       VARCHAR(255)   DEFAULT NULL COMMENT '地区编码',
    `iso_code`        VARCHAR(255)   DEFAULT NULL COMMENT '国际标准地区编码',
    `iso_code_3166_2` VARCHAR(255)   DEFAULT NULL COMMENT '国际标准地区编码',
    `order_count`     BIGINT(20)     DEFAULT NULL COMMENT '订单数',
    `order_amount`    DECIMAL(16, 2) DEFAULT NULL COMMENT '订单金额',
    PRIMARY KEY (`dt`, `province_id`) USING BTREE
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_repeat_purchase;
CREATE TABLE `ads_repeat_purchase`
(
    `dt`                DATE         NOT NULL COMMENT '统计日期',
    `tm_id`             VARCHAR(255) NOT NULL COMMENT '品牌ID',
    `tm_name`           VARCHAR(255)   DEFAULT NULL COMMENT '品牌名称',
    `order_repeat_rate` DECIMAL(16, 2) DEFAULT NULL COMMENT '复购率',
    PRIMARY KEY (`dt`, `tm_id`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_order_spu_stats;
CREATE TABLE `ads_order_spu_stats`
(
    `dt`             DATE         NOT NULL COMMENT '统计日期',
    `spu_id`         VARCHAR(255) NOT NULL COMMENT '商品ID',
    `spu_name`       VARCHAR(255)   DEFAULT NULL COMMENT '商品名称',
    `tm_id`          VARCHAR(255) NOT NULL COMMENT '品牌ID',
    `tm_name`        VARCHAR(255)   DEFAULT NULL COMMENT '品牌名称',
    `category3_id`   VARCHAR(255) NOT NULL COMMENT '三级品类ID',
    `category3_name` VARCHAR(255)   DEFAULT NULL COMMENT '三级品类名称',
    `category2_id`   VARCHAR(255) NOT NULL COMMENT '二级品类ID',
    `category2_name` VARCHAR(255)   DEFAULT NULL COMMENT '二级品类名称',
    `category1_id`   VARCHAR(255) NOT NULL COMMENT '一级品类ID',
    `category1_name` VARCHAR(255) NOT NULL COMMENT '一级品类名称',
    `order_count`    BIGINT(20)     DEFAULT NULL COMMENT '订单数',
    `order_amount`   DECIMAL(16, 2) DEFAULT NULL COMMENT '订单金额',
    PRIMARY KEY (`dt`, `spu_id`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS ads_activity_stats;
CREATE TABLE `ads_activity_stats`
(
    `dt`                    DATE         NOT NULL COMMENT '统计日期',
    `activity_id`           VARCHAR(255) NOT NULL COMMENT '活动ID',
    `activity_name`         VARCHAR(255)   DEFAULT NULL COMMENT '活动名称',
    `start_date`            DATE           DEFAULT NULL COMMENT '开始日期',
    `order_count`           BIGINT(11)     DEFAULT NULL COMMENT '参与活动订单数',
    `order_original_amount` DECIMAL(16, 2) DEFAULT NULL COMMENT '参与活动订单原始金额',
    `order_final_amount`    DECIMAL(16, 2) DEFAULT NULL COMMENT '参与活动订单最终金额',
    `reduce_amount`         DECIMAL(16, 2) DEFAULT NULL COMMENT '优惠金额',
    `reduce_rate`           DECIMAL(16, 2) DEFAULT NULL COMMENT '补贴率',
    PRIMARY KEY (`dt`, `activity_id`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS ads_coupon_stats;
CREATE TABLE `ads_coupon_stats`
(
    `dt`                    DATE         NOT NULL COMMENT '统计日期',
    `coupon_id`             VARCHAR(255) NOT NULL COMMENT '优惠券ID',
    `coupon_name`           VARCHAR(255)   DEFAULT NULL COMMENT '优惠券名称',
    `start_date`            DATE           DEFAULT NULL COMMENT '开始日期',
    `rule_name`             VARCHAR(200)   DEFAULT NULL COMMENT '优惠规则',
    `get_count`             BIGINT(20)     DEFAULT NULL COMMENT '领取次数',
    `order_count`           BIGINT(20)     DEFAULT NULL COMMENT '使用(下单)次数',
    `expire_count`          BIGINT(20)     DEFAULT NULL COMMENT '过期次数',
    `order_original_amount` DECIMAL(16, 2) DEFAULT NULL COMMENT '使用优惠券订单原始金额',
    `order_final_amount`    DECIMAL(16, 2) DEFAULT NULL COMMENT '使用优惠券订单最终金额',
    `reduce_amount`         DECIMAL(16, 2) DEFAULT NULL COMMENT '优惠金额',
    `reduce_rate`           DECIMAL(16, 2) DEFAULT NULL COMMENT '补贴率',
    PRIMARY KEY (`dt`, `coupon_id`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

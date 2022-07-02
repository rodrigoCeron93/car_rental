CREATE DATABASE IF NOT EXISTS `carrental` ;

DROP TABLE IF EXISTS `carrental`.`branch_office`;
CREATE TABLE `carrental`.`branch_office` (
  `branch_office_id` int NOT NULL,
  `code` varchar(4) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address_1` varchar(100) DEFAULT NULL,
  `address_2` varchar(100) DEFAULT NULL,
  `cp` int DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`branch_office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;









DROP TABLE IF EXISTS `carrental`.`car_rental`;
CREATE TABLE `carrental`.`car_rental` (
  `car_id` bigint DEFAULT NULL,
  `car_id_count` bigint DEFAULT NULL,
  `rental_time_mean` double DEFAULT NULL,
  `fare_mean` double DEFAULT NULL,
  `damage_fee_mean` double DEFAULT NULL,
  `year` bigint DEFAULT NULL,
  `model` text,
  `expedition` bigint DEFAULT NULL,
  `capacity` bigint DEFAULT NULL,
  `description_us` text,
  `description_es` text,
  `code` text,
  `name` text,
  `address_1` text,
  `address_2` text,
  `cp` bigint DEFAULT NULL,
  `city` text,
  `state` text,
  `address_complete_1` text,
  `address_complete_2` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `carrental`.`credit_car`;
CREATE TABLE `carrental`.`credit_car` (
  `number` varchar(30) DEFAULT NULL,
  `expiry_date` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `carrental`.`lu_car_type`;

CREATE TABLE `carrental`.`lu_car_type` (
  `car_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(45) DEFAULT NULL,
  `description_es` varchar(45) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`car_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `carrental`.`lu_motor_type`;

CREATE TABLE `carrental`.`lu_motor_type` (
  `motor_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(25) DEFAULT NULL,
  `description_es` varchar(25) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`motor_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `carrental`.`lu_payment_method_type`;

CREATE TABLE `carrental`.`lu_payment_method_type` (
  `payment_method_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(25) DEFAULT NULL,
  `description_es` varchar(25) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`payment_method_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





DROP TABLE IF EXISTS `carrental`.`lu_person_type`;

CREATE TABLE `carrental`.`lu_person_type` (
  `person_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(60) DEFAULT NULL,
  `description_es` varchar(60) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`person_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `carrental`.`lu_trade_mark_type`;

CREATE TABLE `carrental`.`lu_trade_mark_type` (
  `trade_mark_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(25) DEFAULT NULL,
  `description_es` varchar(25) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`trade_mark_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





DROP TABLE IF EXISTS `carrental`.`lu_user_type`;

CREATE TABLE `carrental`.`lu_user_type` (
  `user_type_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `description_us` varchar(25) DEFAULT NULL,
  `description_es` varchar(25) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;






DROP TABLE IF EXISTS `carrental`.`paypal_account`;

CREATE TABLE `carrental`.`paypal_account` (
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;











DROP TABLE IF EXISTS `carrental`.`rel_payment_method`;

CREATE TABLE `carrental`.`rel_payment_method` (
  `wallet_id` int DEFAULT NULL,
  `payment_method_id` int NOT NULL,
  `user_id` int NOT NULL,
  `principal` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;






DROP TABLE IF EXISTS `carrental`.`user`;

CREATE TABLE `carrental`.`user` (
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_type_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_type_id_idx` (`user_type_id`),
  CONSTRAINT `user_type_id` FOREIGN KEY (`user_type_id`) REFERENCES `lu_user_type` (`user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `carrental`.`person`;

CREATE TABLE `carrental`.`person` (
  `user_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `second_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `second_last_name` varchar(100) DEFAULT NULL,
  `curp` varchar(16) DEFAULT NULL,
  `rfc` varchar(16) DEFAULT NULL,
  `ine_number` varchar(22) DEFAULT NULL,
  `PF_type_id` varchar(20) DEFAULT NULL,
  KEY `fk_person_user1_idx` (`user_id`),
  CONSTRAINT `fk_person_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `carrental`.`car`;
CREATE TABLE `carrental`.`car` (
  `car_id` int NOT NULL,
  `motor_type_id` int NOT NULL,
  `trade_mark_type_id` int NOT NULL,
  `car_type_id` int NOT NULL,
  `niv` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `model` varchar(60) DEFAULT NULL,
  `expedition` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `branch_office_id` int NOT NULL,
  PRIMARY KEY (`car_id`),
  KEY `motor_type_id_idx` (`motor_type_id`),
  KEY `car_type_id_idx` (`car_type_id`),
  KEY `branch_office_id_idx` (`branch_office_id`),
  KEY `trade_mark_type_id_idx` (`trade_mark_type_id`),
  CONSTRAINT `branch_office_id` FOREIGN KEY (`branch_office_id`) REFERENCES `branch_office` (`branch_office_id`),
  CONSTRAINT `car_type_id` FOREIGN KEY (`car_type_id`) REFERENCES `lu_car_type` (`car_type_id`),
  CONSTRAINT `motor_type_id` FOREIGN KEY (`motor_type_id`) REFERENCES `lu_motor_type` (`motor_type_id`),
  CONSTRAINT `trade_mark_type_id` FOREIGN KEY (`trade_mark_type_id`) REFERENCES `lu_trade_mark_type` (`trade_mark_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `carrental`.`rental`;

CREATE TABLE `carrental`.`rental` (
  `trip_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rental_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `branch_office` int DEFAULT NULL,
  `payment_method_id` int NOT NULL,
  `fare` int DEFAULT NULL,
  `damage_fee` decimal(2,2) DEFAULT NULL,
  `car_id` int NOT NULL,
  `number` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`trip_id`),
  KEY `car_id_idx` (`car_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `car_id` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

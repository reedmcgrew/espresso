CREATE DATABASE `lab2_user_data`;
USE `lab2_user_data`;
#SCHEMA

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(200),
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#USERS
create user 'lab2_user'@'%' identified by 'silly pass';
grant all on lab2_user_data.* to 'lab2_user'@'%';

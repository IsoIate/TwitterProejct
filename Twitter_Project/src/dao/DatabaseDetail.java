package dao;

public @interface DatabaseDetail {
/*
	데이터베이스 -> 추후 세분화
	
	# 유저 로그인 정보
	CREATE TABLE `user_login` (
		`user_num` int NOT NULL AUTO_INCREMENT,
		`id` varchar(30) NOT NULL,
		`pw` varchar(45) NOT NULL,

		PRIMARY KEY (`user_num`)
	);
	
	# 유저 개인정보		
	CREATE TABLE `user_info` (
		`user_num` int NOT NULL AUTO_INCREMENT,
		`email` varchar(40) NOT NULL,
		`nickname` varchar(45) DEFAULT NULL,
		`profileImg` varchar(100) DEFAULT NULL,
        `twitcount` int default 0,
        `follow` int default 0,
        `follower` int default 0,
		`madetime` timestamp default now(),

		PRIMARY KEY (`user_num`)
	);
	
	# 유저 생일
	CREATE TABLE `user_birthday` (
		`user_num` int NOT NULL AUTO_INCREMENT,
		`year` int DEFAULT NULL,
		`month` int DEFAULT NULL,
		`day` int DEFAULT NULL,

		PRIMARY KEY (`user_num`)
	);
	
	# 트윗 작성
	CREATE TABLE `twit_write` (
		`user_num` int NOT NULL AUTO_INCREMENT,
		`nickname` varchar(45) DEFAULT NULL,
		`profileImg` varchar(100) DEFAULT NULL,
		`text` varchar(140) NOT NULL,
		`twittime` timestamp default now(),
        
		PRIMARY KEY (`user_num`)
	);
	
	# 트윗 조회
	CREATE TABLE `twit_read` (
		`user_num` int NOT NULL AUTO_INCREMENT,
		`nickname` varchar(45) DEFAULT NULL,
		`profileImg` varchar(100) DEFAULT NULL,
		`text` varchar(140) NOT NULL,
		`twittime` timestamp default now(),
        
		PRIMARY KEY (`user_num`)
	);

*/
}

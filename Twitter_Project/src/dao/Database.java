package dao;

public @interface Database {
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
	   		`twitcount` int default 0,
			`madetime` timestamp default now(),
	
			PRIMARY KEY (`user_num`)
	);
	
	# 유저 프로필
	
	CREATE TABLE `user_profile` (
			`user_num` int NOT NULL AUTO_INCREMENT,
			`nickname` varchar(45) DEFAULT NULL,
			`profileImg` varchar(100) DEFAULT NULL,
	        `profile` varchar(140) DEFAULT 'Hello',
	
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
	
	CREATE TABLE `twit` (
			`user_num` int,
			`text` varchar(140) NOT NULL,
			`twittime` timestamp default now(),
	        `twitnumber`  int NOT NULL AUTO_INCREMENT,
			PRIMARY KEY (`twitnumber`)
	);
	
	# 팔로우 확인
	
	CREATE TABLE `user_fw` (
		  `user_num` int(11) NOT NULL AUTO_INCREMENT,
		  `follow` int(11) DEFAULT '0',
		  `follower` int(11) DEFAULT '0',
		  PRIMARY KEY (`user_num`)
	  );

*/
}

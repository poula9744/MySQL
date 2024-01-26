-- 계정명 book, 비번 book, 모든곳에서 접속 가능한 계정을 만드세요
-- 권한은 book_db 데이타베이스의 모든 테이블에 모든 권한을 갖도록 하세요

-- 계정이 있다면 삭제
drop user if exists 'book'@'%';

-- 계정 만들기
create user 'book'@'%' identified by 'book';

-- 권한부여(book 계정, book_db 데이터베이스에 
grant all privileges on book_db.* to 'book'@'%';

-- 즉시 변경 내용 반영
flush privileges;

-- 데이타 베이스가 있다면 삭제
drop database if exists book_db;

-- book_db를 만드세요
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

use book_db;
show databases;
-- drop database book_db;
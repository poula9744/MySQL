show databases;
use hrdb;
select * from employees;
-- --------------------
#       DCL: 계정관리       #
-- --------------------
create user 'webdb'@'%' identified by '1234'; -- 계정 생성 
alter user 'webdb'@'%' identified by 'webdb'; -- 비번 변경 
flush privileges;  -- 변경된 권한을 즉시 적용
grant all privileges on web_db.* to 'webdb '@'%';
-- web_db 데이타베이스의 모든 테이블에  'webdb '@'%' 사용자에게 모든 권한 부여
drop user 'webdb'@'%'; -- 계정  삭제


-- ----------------------
#       DDL: 데이터베이스      #
-- ----------------------
-- 데이터베이스 생성
create database web_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

show databases;
use web_db ;
drop database web_db;
show databases;


-- ----------------------
#       DDL: 테이블 관리      #
-- ----------------------
create table book(
	    book_id     int,
        title           varchar(50),
        author       varchar(20),
        pub_date   datetime
);


-- 데이터베이스(스키마) 접속
use book_db;

-- ----------------------
#       DDL: 테이블 관리      #
-- ----------------------

-- book 테이블 생성 
create table book(
	    book_id     int,
        title           varchar(50),
        author       varchar(20),
        pub_date   datetime
);
show tables;

-- 컬럼추가 
alter table book add pubs varchar(50);

-- 컬럼수정 
alter table book modify title varchar(100);

alter table book rename column title to subject;

-- 컬럼삭제
alter table book drop author;

-- 테이블 명 수정 
rename table book to article;

-- 테이블 삭제
drop table article;




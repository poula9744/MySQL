
-- 데이터베이스(스키마) 접속
use book_db;

-- 작가 테이블 만들기
create table author(
		author_id        int                         primary key,
        author_name  varchar(100)        not null,
        author_desc    varchar(500)      
);

-- 책 테이블 만들기
create table book(
	book_id      int                     primary key,
    title 			  varchar(100)    not null,
    pubs          varchar(100),
    pub_date    datetime,
    author_id    int,
    constraint book_fk foreign key (author_id)
    references author(author_id)
);

-- 작가 등록
# 묵시적 방법
insert into author
values(1, '박경리', '토지 작가');

# 명시적 방법
insert into author(author_id, author_name)
values (2, '이문열');

insert into author(author_id, author_name)
values (3, '박명수');

insert into author(author_id, author_name)
values(4, '정우성');

-- insert into author(author_id, author_name)
-- values (2, '정우성'); ---> 2번이 있는데 또 2번을 넣으려 해서 오류남


# 조건을 만족하는 레코드를 변경 
update author
set author_name = '기안84',
	  author_desc = '웹툰작가'
where author_id = 1;

update author
set  author_desc = '웹툰작가'
where author_id = 4 ;

#where 절이 생략되면 모든 레코드에 적용
update author
set author_name = '강풀',
	   author_desc = '인기작가';

select * 
from author;

-- 조건을 만족하는 레코드 삭제
delete from author
where author_id = 1;


# 조건이 없으면 모든 데이터 삭제
delete from author;

drop table author;
drop table book;

-- 작가 테이블 auto_increment
create table author(
	author_id          int   	auto_increment		 primary key,
    author_name   varchar(100)  not null,
    author_desc     varchar(500)
    );
    
insert into author(author_name, author_desc)
values('이문열', '경북 영양'); 

insert into author(author_name, author_desc)
values('박경리', '경상남도 통영');

insert into author  -- 무조건 순서대로 써줘야해서 에러가 남 --> null 넣어주기
values(null, '유시민', '17대 국회의원');

select * 
from author;

select last_insert_id();
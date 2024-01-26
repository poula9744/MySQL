-- 데이터베이스 생성 
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

-- 데이터베이스(스키마) 접속
use book_db;

-- author 테이블 생성 
create table author(
	author_id       int     auto_increment   primary key,
    author_name    varchar(100)  not null,
    author_desc      varchar(500)
);

-- book 테이블 생성 
create table book(
	book_id         int                      auto_increment     primary key,
    title               varchar(50),
    pubs             varchar(20),
    pub_date       date,
	author_id       int,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- DML
insert into author
values(null, '이문열', '경북 영양');

insert into author
values(null,'박경리', '경상남도 통영');

insert into author
values(null, '유시민', '17대 국회의원');

insert into author(author_name, author_desc)
values('기안84', '기안동에서 산 84년생');

insert into author
values(null, '강풀', '온라인 만화가 1세대');

insert into author
values(null, '김영하', '알쓸신잡');


insert into book
values(null, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book(title, pubs, pub_date, author_id )
values('삼국지', '민음사', '2002-03-01', 1);

insert into book(title, pubs, pub_date, author_id )
values('토지', '마로니에북스', '2012-08-15', 2);

insert into book(title, pubs, pub_date, author_id)
values('유시민의 글쓰기 특강','생각의길', '2015-04-01', 3);

insert into book(title, pubs, pub_date, author_id)
values('패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book(title, pubs, pub_date, author_id)
values('순정만화', '재미주의', '2011-08-03', 5);

insert into book(title, pubs, pub_date, author_id)
values('오직두사람',  '문학동네', '2017-05-04', 6);

insert into book(title, pubs, pub_date, author_id)
values('26년', '재미주의', '2012-02-04', 5);

-- 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
update author
	set author_name = '강풀' ,
	author_desc = '서울특별시'
where author_id = 5 ;

select * 
from book b, author a
where b.author_id = a.author_id
order by book_id asc;

-- author 테이블에서 기안84 데이터를 삭제해 보세요 → 삭제 안됨
delete from author
where author_id=4;
-- book 테이블 author_id가 REFERENCE 테이블인 author 테이블 author_id를 참조하고 있다.
-- REFERENCE 테이블에 없는 값은 외래키에 넣을 수 없다. 
-- author 테이블에서 기안84 데이터를 삭제하기 위해서는 book 테이블과 author 테이블 모두 삭제해야한다. 



-- drop database book_db;
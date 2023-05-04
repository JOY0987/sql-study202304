-- 연습 게시판 테이블
create table ex_board (
	board_no int(10) auto_increment primary key,
    title VARCHAR(80) not null,
    content VARCHAR(2000),
    board_writer VARCHAR(50),
    view_count int(10) default 0,
    reg_date_time DATETIME default current_timestamp
);

select *
from ex_board;

insert into ex_board (
-- 			board_no, 
			title, 
			content, 
			board_writer, 
			view_count
-- 			reg_date_time
			)
values ("첫번째글!", "첫번째내용", "일번이", 0)
;

insert into ex_board (
-- 			board_no, 
			title, 
			content, 
			board_writer, 
			view_count
-- 			reg_date_time
			)
values ("두번째글!", "두번째내용", "이번이", 0)
;




select *
from tbl_board
where title like concat('%', '30', '%')
order by board_no desc
limit 0, 6
;

-- Board 댓글 만들기
create table tbl_reply (
	reply_no INT(10) auto_increment,
	reply_text VARCHAR(1000) not null,
	reply_writer VARCHAR(100) not null,
	reply_date DATETIME default current_timestamp,
	board_no INT(10), 
	constraint pk_reply primary key (reply_no),
	constraint fk_reply
	foreign key (board_no)
	references tbl_board (board_no)
	on delete cascade
)
;
-- 원본글이 삭제되면 댓글도 삭제해!

-- drop table tbl_reply;

-- truncate table tbl_board;

select * from tbl_board;

select * from tbl_reply where board_no = 3;

-- drop table tbl_table;

select *
from tbl_reply
where board_no = 7
;

SELECT * FROM tb_emp;

-- 테이블(엔터티) 생성
-- 성적정보 저장 테이블

CREATE TABLE tbl_score (
   name VARCHAR2(4) NOT NULL,
   kor NUMBER(3) NOT NULL CHECK(kor > 0 AND kor <= 100),
   eng NUMBER(3) NOT NULL CHECK(eng > 0 AND eng <= 100),
   math NUMBER(3) NOT NULL CHECK(math > 0 AND math <= 100),
   total NUMBER(3) NULL, -- NULL 생략가능
   average NUMBER(5, 2),
   grade CHAR(1),
   stu_num NUMBER(6),
   -- PK 거는 법
   -- 1. PK 에 별칭을 단다.
   -- 2. stu_num 에 PK 를 걸어준다.
   -- 3. PK 는 자동으로 UNIQUE 속성이 부여된다.
   CONSTRAINT pk_stu_num
   PRIMARY KEY (stu_num)
);

-- 테이블 생성 후 PK 적용하기
ALTER TABLE TBL_SCORE
ADD CONSTRAINT pk_stu_num
   PRIMARY KEY (stu_num);

-- 컬럼 추가하기
ALTER TABLE   TBL_SCORE 
ADD   (sci NUMBER(3) NOT NULL);

-- 컬럼 제거하기
ALTER TABLE   TBL_SCORE 
DROP COLUMN sci;

-- 테이블 복사 (tb_emp)
-- CTAS !
CREATE TABLE tb_emp_copy
AS SELECT * FROM tb_emp;

-- 복사 테이블 조회
SELECT * FROM tb_emp_copy;
SELECT * FROM tb_emp;

-- 데이터 삭제 : 모두 롤백 불가
-- drop table
-- 구조, 내부 데이터 전체 삭제
DROP TABLE TB_EMP_COPY;

-- truncate table 
-- 구조는 놔두고 내부 데이터만 전체 삭제
TRUNCATE TABLE TB_EMP_COPY;



-- 예시테이블
CREATE TABLE goods (
   id NUMBER(6) PRIMARY KEY,
   g_name VARCHAR2(10) NOT NULL,
   price NUMBER(10) DEFAULT 1000,
   reg_date DATE
);

-- SELECT (탐색)
SELECT * FROM goods;


-- INSERT (추가) 
INSERT INTO goods
   (id, g_name, price, reg_date)
VALUES 
   (1, '선풍기', '120000', SYSDATE);
   
INSERT INTO goods
   (id, g_name, reg_date)
VALUES 
   (2, '달고나', SYSDATE);
   
INSERT INTO goods
   (id, g_name, price)
VALUES 
   (3, '후리', 500);
   
-- 컬럼명 생략시 모든 컬럼에 대해 순서대로 넣어야 함 ( 실무에서 사용 금지! )
INSERT INTO goods
VALUES 
   (4, '세탁기', 10000, SYSDATE);
   
-- 멀
INSERT INTO goods
   (id, g_name, price)
VALUES
   (5, '후리1', 500),
   (6, '후리2', 1500), 
   (7, '후리3', 3000);


SELECT * FROM goods;

-- UPDATE (수정)
UPDATE GOODS 
SET g_name = '냉장고'
WHERE id = 3
;

UPDATE GOODS 
SET g_name = '콜라', price = 3000
WHERE id = 2
;

UPDATE GOODS 
SET price = 9999
; -- 모든 행의 price 가 수정

UPDATE tbl_user
SET age = age + 1
; -- ex ) 연도가 넘어갈 때 사용


SELECT * FROM goods;

-- DELETE (행을 삭제)
DELETE FROM goods 
WHERE id = 3
;

-- 모든 행 삭제
DELETE FROM goods;


-- SELECT 조회
SELECT	
	CERTI_CD
	, CERTI_NM 
	, ISSUE_INSTI_NM 
FROM TB_CERTI
;

SELECT		
	 CERTI_NM 
	, ISSUE_INSTI_NM 
	, CERTI_CD
FROM TB_CERTI
;

SELECT ALL		
	 CERTI_NM 
	, ISSUE_INSTI_NM 
FROM TB_CERTI
;

-- 중복 제거 distinct
SELECT DISTINCT 
	ISSUE_INSTI_NM 
FROM TB_CERTI
;

-- 모든 컬럼 조회
-- 실무에서는 사용하지 마세요
-- 모든 컬럼 적어두고, 필요한대로 지워서 쓰는게 효율적
SELECT	
	*
FROM TB_CERTI
;

-- 열 별칭 부여 (alias)
SELECT	
	EMP_NM 사원명,
	ADDR AS "사원의 거주지 주소"
FROM TB_EMP
;

SELECT	
	te.EMP_NM 사원명,
	te.ADDR AS "사원의 거주지 주소"
FROM TB_EMP te
; -- 열 별칭에 띄어쓰기가 있으면 꼭  ""로 묶어줘야함!

-- 문자열 연결하기
-- || 가 + 의 역할
SELECT 
	CERTI_NM || ' (' || ISSUE_INSTI_NM || ')' AS "자격증 정보"
FROM TB_CERTI
;
-- 트랜잭션

CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(8,2)
);

INSERT INTO employees VALUES (1, 'Alice', 5000);
INSERT INTO employees VALUES (2, 'Bob', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 7000);



COMMIT; -- 변경사항을 완전히 DB에 반영


-- 트랜잭션 시작
BEGIN
	-- 모든 사원들의 급여를 1000씩 올려줄거다
	UPDATE EMPLOYEES
	SET SALARY = SALARY + 1000;

	-- 급여 총합 조회
	SELECT sum(SALARY) FROM EMPLOYEES;

	-- 롤백 : 이전 커밋으로 돌아가기
	ROLLBACK;

	SELECT sum(SALARY) FROM EMPLOYEES;
END;


-- 내 돈이 빠짐
UPDATE account
SET balance = balance - 1000
WHERE USER_NAME = '김철수';
	-- 여기서 COMMIT 하면 안됨! 상대가 돈을 받는 것까지 성공하고 COMMIT 해야함
UPDATE account
SET balance = balance + 1000
WHERE USER_NAME = '박영희';

ROLLBACK;


-- WHERE 조건절
SELECT 
	EMP_NO, EMP_NM, ADDR, SEX_CD -- 열을 제한
FROM TB_EMP
WHERE SEX_CD = 1 -- 행을 제한
;

-- WHERE 절로 PK 동등 조건을 걸면
-- 무조건 단일행이 조회된다.
SELECT EMP_NO, EMP_NM, ADDR, SEX_CD
FROM TB_EMP
WHERE EMP_NO = 1000000003
;


-- 비교 연산자
SELECT 
	EMP_NO, EMP_NM, BIRTH_DE, TEL_NO
FROM TB_EMP
WHERE BIRTH_DE >= '19900101'
	AND BIRTH_DE <= '19991231'
;

-- BETWEEN 연산자
-- 위와 같은 결과
SELECT 
	EMP_NO, EMP_NM, BIRTH_DE, TEL_NO
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19900101' AND '19991231'
;


-- OR 연산자 ( + 개념 )
SELECT EMP_NO, EMP_NM, DEPT_CD
FROM TB_EMP
WHERE DEPT_CD = '100004'
	OR DEPT_CD = '100006'
;


-- IN 연산자
-- OR 과 같은 결과
SELECT EMP_NO, EMP_NM, DEPT_CD
FROM TB_EMP
WHERE DEPT_CD IN ('100004', '100006')
;

-- NOT IN 연산자
-- 아닌 넘들만
SELECT EMP_NO, EMP_NM, DEPT_CD
FROM TB_EMP
WHERE DEPT_CD NOT IN ('100004', '100006')
;


-- LIKE 연산자
-- 검색에서 주로 사용
-- 와일드 카드 매핑 (% : 0글자 이상, _ : 딱 1글자)
SELECT 
	EMP_NO, EMP_NM
FROM TB_EMP
WHERE EMP_NM LIKE '%심'
; -- '심' 앞에 0글자 이상만 오면 매칭

SELECT 
	EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE ADDR LIKE '%용인%'
; -- 용인시 거주자 찾기

SELECT 
	EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE EMP_NM LIKE '이%'
; -- 이씨 찾기

SELECT 
	EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE EMP_NM LIKE '이__'
; -- 이씨 찾기 (위와 같다)

SELECT 
	EMP_NO, EMP_NM, ADDR
FROM TB_EMP
WHERE EMP_NM LIKE '_B'
;


-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT 
	EMP_NO, 
	EMP_NM, 
	BIRTH_DE, 
	DEPT_CD 
FROM TB_EMP
WHERE 1=1 -- 실무 TIP
	AND EMP_NM LIKE '김%' 
	AND BIRTH_DE LIKE '199%'
	AND DEPT_CD IN ('100003', '100004', '100006')
;


-- 부정 일치 비교 연산자
-- 성별이 1(남자)인 사원 조회
SELECT 
	EMP_NO, 
	EMP_NM, 
	ADDR, 
	SEX_CD 
FROM TB_EMP
WHERE SEX_CD <> 2
--WHERE NOT SEX_CD = 2
--WHERE SEX_CD ^= 2
--WHERE SEX_CD != 2
; 


-- 성별 코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.
SELECT 
	EMP_NO,
	EMP_NM,
	SEX_CD
FROM TB_EMP
WHERE 1=1
	AND SEX_CD <> 1
	AND EMP_NM NOT LIKE '이%'
;


-- null 값만 조회
-- 반드시 IS NULL 연산자로 조회해야 한다.
SELECT 
	EMP_NO,
	EMP_NM,
	DIRECT_MANAGER_EMP_NO
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NOT NULL
;


-- 연산자 우선 순위
-- NOT > AND > OR
SELECT 
	EMP_NO,
	EMP_NM,
	ADDR
FROM TB_EMP
WHERE 
	EMP_NM LIKE '김%' AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%')
;
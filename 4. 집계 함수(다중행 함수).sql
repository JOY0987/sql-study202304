

SELECT * FROM TB_SAL_HIS;


-- 집계 함수 (다중행 함수)
-- : 여러 행을 묶어서 함수를 적용
SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005'
;

SELECT
    SUBSTR(emp_nm, 1, 1) 성씨   
FROM tb_emp
;


-- GROUP BY로 소그룹화 하지 않으면 집계함수는 전체행수를 기준으로 집계한다.
SELECT 
    SUM(pay_amt) "지급 총액"
    , AVG(pay_amt) "평균 지급액"
    , COUNT(pay_amt) "지급 횟수"
FROM tb_sal_his
;

SELECT * FROM tb_emp;

-- COUNT (특정 열)는 행의 수를 반환하고, null 값은 카운트하지 않는다.
-- COUNT (*)는 null 값도 카운트한다.
SELECT 
    COUNT(emp_no) AS "총 사원수"
    , COUNT(direct_manager_emp_no) "dmen"
    , COUNT(*) 
    , MIN(birth_de) "최연장자의 생일"
    , MAX(birth_de) "최연소자의 생일"
FROM tb_emp;


SELECT 
    direct_manager_emp_no
FROM tb_emp;


-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회

SELECT 
	EMP_NO,
	EMP_NM,
	BIRTH_DE,
	DEPT_CD 
FROM tb_emp
ORDER BY dept_cd
;

SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;

-- 사원별 누적 급여수령액 조회
SELECT *
FROM TB_SAL_HIS
ORDER BY EMP_NO, PAY_DE;

SELECT  SUM(PAY_AMT)
FROM TB_SAL_HIS; -- 결과 1건

SELECT 
    emp_no "사번"
    , SUM(pay_amt) "누적 수령액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- GROUP BY 시 행의 개수가 줄어들기 때문에 SELECT 에 일반적인 함수를 사용하지 못할 수 있음.
SELECT 
--	EMP_NO,
	MAX(EMP_NO), 
	DEPT_CD 
FROM TB_EMP
GROUP BY DEPT_CD 
;

-- 사원별로 2019년에 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- GROUP BY 절에 있는 WHERE 절은 그룹화하기 전에 필터링을 합니다.
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한
-- 그룹화해서 통계 낸 이후에 필터링
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no) > 1
ORDER BY dept_cd
;


-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- 평균 급여가 450만원 이상인 사람만 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
;

-- 그룹화 대상 컬럼이 2개 이상인 경우
SELECT 
    emp_no
    , emp_nm
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, sex_cd
;


SELECT 
    dept_cd
    , SEX_CD 
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd -- n번 부서이면서, 성별이 1인 경우 <-> 2인 경우 (GROUP BY의 다중화)
ORDER BY dept_cd -- GROUP BY 컬럼이 아닌 걸로 정렬 시도시 오류발생
;


-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값, 생략가능), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC
; -- 		1차 정렬		2차 정렬


SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC
; -- 별칭으로도 정렬 지정 가능

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 1 DESC
;


SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC
;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

SELECT 
	emp_nm,
	DIRECT_MANAGER_EMP_NO
FROM TB_EMP
ORDER BY DIRECT_MANAGER_EMP_NO DESC
;
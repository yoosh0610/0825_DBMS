-- <Quiz> --

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 직급명, 근무 나라명을 조회해 주세요

SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID               LOCATION_ID
SELECT * FROM JOB;        --            JOB_CODE                 
SELECT * FROM LOCATION;   --                       LOCATION_ID   NATIONAL_CODE
SELECT * FROM NATIONAL;   -- 									 NATIONAL_CODE


SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
 	   NATIONAL USING (NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '한국';

--------------------------------------------------------------------------------
/*
 * < VIEW 뷰 > --> 논리적인 가상 테이블
 * 
 * SELECT문 저장하는 객체
 * 
 * 1. VIEW 생성
 * 
 * 표현법
 * CREATE VIEW 뷰이름
 * 	   AS 서브쿼리;
 */ 
--
CREATE VIEW VW_EMPLOYEE
	AS SELECT
	          EMP_ID
		    , EMP_NAME
		    , DEPT_TITLE
		    , JOB_NAME
			     , NATIONAL_NAME
			  FROM
			       EMPLOYEE
			  JOIN
			       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
			  JOIN
			       JOB USING (JOB_CODE)
			  JOIN
			       LOCATION ON (LOCATION_ID = LOCAL_CODE)
			  JOIN
			 	   NATIONAL ON (NATIONAL_CODE)

SELECT * FROM VW_EMPLOYEE;

-- 한국에서 근무하는 사원
SELECT
 	   *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '한국';

-- 일본에서 근무하는 사원
SELECT
 	   *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '일본';

-- 뷰의 장점 : 쿼리문이 엄청 긴게 필요할 때 그때그때 작성하면 힘들다...
--			 딱 한번 뷰로 만들어주면 그때부터 뷰를 사용해서 간단하게 조회할 수 있음

-- 해당 계정이 가지고 있는 VIEW에 대한 정보를 조회할 수 있는 데이터 딕셔너리
SELECT * FROM USER_VIEWS;
-- 뷰는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있지 않음
--						 (쿼리문을 TEXT 형태로 저장해놓음)

--------------------------------------------------------------------------------
/*
 * CREATE OR REPLACE VIEW 뷰이름
 *     AS 서브쿼리;
 * 
 * 뷰 생성 시 기존에 중복된 이름의 뷰가 존재한다면 갱신(변경)해주고
 * 없다면 새로운 뷰를 생성해줌
 */
-- 사원의 사원명, 연봉, 근무년수를 조회할 수 있는 SELECT문 정의
SELECT
	   EMP_NAME
     , SALARY * 12
	 , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
  FROM
       EMPLOYEE;

CREATE OR REPLACE VIEW VW_EMP
    AS (SELECT
    		   EMP_NAME
    		 , SALARY * 12 "연봉"
	         , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
          FROM
               EMPLOYEE);
/*
 * 뷰 생성 시 SELECT절에 함수 또는 산술연산식이 산술연산식이 기술되어있는 경우 뷰 생성이 불가능하기 때문에
 * 반드시 별칭을 지정해주어야 함
 */    
SELECT * FROM VW_EMP;
    
-- 별칭 부여 방법 두 번째!(모든 컬럼에다가 별칭을 지어주어야 함!)
CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수)
    AS (SELECT
    		   EMP_NAME
    		 , SALARY * 12
	         , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
          FROM
               EMPLOYEE);

-- 뷰 삭제하기
DROP VIEW 뷰이름;
-----------------------------------------------------------------------------------------









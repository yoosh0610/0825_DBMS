SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM
       EMPLOYEE;

SELECT
       DEPT_ID
     , DEPT_TITLE
  FROM
       DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 한꺼번에 조회
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM
       EMPLOYEE;

SELECT
       JOB_CODE
     , JOB_NAME
  FROM
       JOB;

--------------------------------------------------------------------------------

--> JOIN을 통해 연결고리에 해당하는 컬럼만 매칭시킨다면 마치 하나의 조회 결과물처럼 조회 가능

-- KH
-- 어떤 강의장에 어떤 강사가 수업을 하고 있는가?
CREATE TABLE CLASS_ROOM(
     CLASS_ID CHAR(1),
     LECTURE_NAME VARCHAR2(20)
);
SELECT * FROM CLASS_ROOM;

INSERT INTO CLASS_ROOM VALUES('A', '이승철');
INSERT INTO CLASS_ROOM VALUES('B', '홍길동');
INSERT INTO CLASS_ROOM VALUES('C', '고길동');
--하나의 테이블의 여러 컬럼이 들어올때 데이터를 분리

CREATE TABLE STUDENT(
     CLASS_ID CHAR(1),
     STUDENT_NAME VARCHAR2(20)
);
INSERT INTO STUDENT VALUES('A', '이승욱');
INSERT INTO STUDENT VALUES('A', '채정민');
INSERT INTO STUDENT VALUES('B', '김윤기');
INSERT INTO STUDENT VALUES('C', '김태호');
COMMIT;

SELECT 
       CLASS_ID
     , LECTURE_NAME
  FROM   
       CLASS_ROOM;

SELECT 
       CLASS_ID
     , STUDENT_NAME
  FROM   
       STUDENT;

-- 저장은 따로 되어 있지만 조회는 같이 하고 싶다
SELECT
       LECTURE_NAME
     , CLASS_ROOM.CLASS_ID
     , STUDENT.CLASS_ID
     , STUDENT_NAME
  FROM   
       CLASS_ROOM, STUDENT
--CLASS_ID값이 같은 것만 조회(조건) -->JOIN의 원리
 WHERE
       CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;

/*
 * < JOIN >
 * 
 * 두 개 이상의 테이블에서 데이터를 한 번에 조회하기 위해 사용하는 구문
 * 조회결과는 하나의 ResultSet으로 나옴
 * 
 * 관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음(중복방지)
 * -> JOIN구문을 사용해서 여러 개의 테이블 간 "관계"를 맺어서 같이 조회 해야함 
 * => 무작정 JOIN을 해서 조인하는 것이 아니고 테이블 간 매칭을 할 수 있는 컬럼이 존재해야 함
 * 
 * JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회)구문"으로 나뉜다.
 * 
 * ===========================================================================
 * 			오라클 전용 구문   		|    	ANSI(오라클 + 타 DBMS)구문
 * ===========================================================================
 * 				등가조인			|		      내부조인
 * 			(EQUAL JOIN)		|			(INNER JOIN)
 * ----------------------------------------------------------------------------
 * 				포괄조인			|		왼쪽 외부조인(LEFT OUTER JOIN)
 * 			(LEFT OUTER)		|	   오른쪽 외부조인(RIGHT OUTER JOIN)
 * 			(RIGHT OUTER)		|	전체 외부조인(FULL OUTER JOIN) -> 오라클에선 X
 * -----------------------------------------------------------------------------
 * 				카테시안 곱		|			교차조인
 * 			(CARTESIAN PRODUCT)	|		  (CROSS JOIN)
 * -----------------------------------------------------------------------------
 * 자체조인(SELF JOIN)
 * 비등가조인(NON EQUAL JOIN)
 * 자연조인(NATURAL JOIN)
 */

/*
 * 1. 등가조인(EQUAL JOIN) / 	내부조인(INNER JOIN)
 * 
 * JOIN 시 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회
 * ( == 일치하지 않는 값들을 조회에서 제외)
 */

--> 오라클 전용 구문
--> SELECT 절에는 조회하고 싶은 컬럼명을 각각 기술
-->   FROM 절에는 조회하고자 하는 테이블을 , 를 이용해서 전부 다 나열
--> WHERE  절에는 매칭을 시키고자 하는 컬럼명에 대한 조건을 제시함( = )

-- 전체 사원들의 사원명, 부서코드, 부서명을 한꺼번에 조회
SELECT * FROM EMPLOYEE;   -- EMP_NAME, DEPT_CODE (23행)
SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE (9행)

-- case 1. 연결한 두 컬럼의 컬럼명이 다른 경우(DEPT_CODE - DEPT_ID)
SELECT
       EMP_NAME
     , DEPT_CODE
     , DEPT_ID
     , DEPT_TITLE
  FROM 
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID;
-- 207개 행중에 21행만 일치 (부서가 아직 부여되지 않은 사원 2명 빠짐)
-- 일치하지 않는 값은 조회에서 제외
-- DEPT_CODE가 NULL인 사원 2명은 데이터가 조회되지 않는다.
-- DEPT_ID가 D3, D4, D7인 부서데이터가 조회되지 않는다.

-- 전체 사원들의 사원명, 직급코드, 직급명을 한꺼번에 조회
SELECT * FROM EMPLOYEE;   -- EMP_NAME, JOB_CODE (행)
SELECT * FROM JOB;        -- JOB_CODE, JOB_NAME (행)

-- case 2. 연결할 두 컬럼의 이름이 같은 경우(JOB_CODE)
SELECT
       EMP_NAME
     , JOB_CODE
     , JOB_NAME
     , JOB_CODE
  FROM
       EMPLOYEE
     , JOB
 WHERE
       JOB_CODE = JOB_CODE;

-- 방법 1. 테이블명을 사용하는 방법
SELECT
       EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB.JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE
     , JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2. 별칭 사용(각 테이블마다 별칭 부여 가능) => 편하지만 길어지만 헷갈릴 수 있다
SELECT
       EMP_NAME
     , E.JOB_CODE
     , J.JOB_CODE
     , JOB_NAME
  FROM 
       EMPLOYEE E
     , JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE;
--FROM에서 별칭을 달면(FROM은 항상 일등이라서) 전부 사용 가능 

--> ANSI구문
-- FROM절에 기준 테이블을 하나 지술한 뒤
-- 그 뒤에 JOIN절에 같이 조회하고자 하는 테이블을 기술(매칭시킬 컬럼에 대한 조건도 기술)
-- USING / ON 구문

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 사원명, 부서코드, 부서명
-- 연결컬럼이 컬럼명이 다름(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID)
-- 무조건 ON구문만 사용가능!!!(USING은 못씀 안됨 불가능함!!!)
SELECT
       EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM
       EMPLOYEE
-- INNER(생략가능)
  JOIN  
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- EMP_NAME, JOB_CODE, JOB_NAME
-- 사원명, 직급코드, 직급명
-- 연결할 두 컬럼명이 같을 경우 (JOB_CODE)
-- ON 구문이용 ) 애매하다(AMBIGUOUSLY) 발생할 수 있음 -> 어떤 테이블의 컬럼인지 명시
SELECT
       EMP_NAME
     , E.JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE E
  JOIN  
       JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- USING 구문이용 ) 컬럼명이 동일할 경우 사용이 가능하며 동등비교연산자를 기술하지 않음 
SELECT
       EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE);
-- 똑같은 테이블이 많을 경우 사용X

-- [참고사항] NATURAL JOIN(자연조인)
SELECT
        EMP_NAME
      , JOB_CODE
      , JOB_NAME
   FROM
        EMPLOYEE
NATURAL
   JOIN
        JOB;
--제일 편하지만 운이 좋음(JOB가 하나뿐이라서)
-- 두 개의 테이블을 조인하는데 운 좋게도 두 개의 테이블에 일치하는 컬럼이 딱 하나 있을때 사용.
/*
 * < Quiz >
 */
-- 사원명과 직급명을 같이 조회해주세요. 단 직급명이 대리인 사원들만 조회해주세요.
-- EMP_NAME, JOB_NAME
-- EMPLOYEE, JOB

--> ORACLE문법 => 등가조인(EQUAL JOIN)
SELECT 
       EMP_NAME
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
 WHERE      
       E.JOB_CODE = J.JOB_CODE 
   AND
       JOB_NAME = '대리';

--> ANSI문법 => 내부조인(INNER JOIN)   이널조인
SELECT 
       EMP_NAME
     , JOB_NAME
  FROM
       EMPLOYEE E
  JOIN  
       JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE 
       JOB_NAME = '대리';

-- EQUAL JOIN / INNER JOIN : 일치하지 않는 행은 애초에 ResultSet에 포함시키지 않음
----------------------------------------------------------------------------
/*
 * 2. 포괄조인 / 외부조인(OUTER JOIN)
 * 
 * 테이블간의 JOIN 시 일치하지 않는 행도 포함시켜서 ResultSet 반환
 * 단, 반드시 LEFT / RIGHT를 지정해줘야 함!(기준 테이블을 선택해야 함)
 */
-- EMPLOYEE테이블에 존재하는 "모든" 사원의 사원명, 부서명 조회
-- INNER JOIN
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
-- INNER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--EMPLOYEE 테이블에서 DEPT_CODE가 NULL인 두 명의 사원은 조회 X
--DEPARTMENT 테이블에서 부서에 배정된 사원이 없는 부서(D3, D4, D7) 조회 X

-- 1) LEFT [ OUTER ] JOIN : 두 테이블 중 왼편에 기술한 테이블을 기준으로 JOIN
-- 조건과는 상관없이 왼편에 기술한 테이블의 데이터를 전부 조회(일치하는 값을 못찾더라도 조회)

--> ANSI
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT
-- OUTER(생략가능)
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- LEFT기준으로 왼쪽에 있는 테이블을 모두 출력할거야

--> ORACLE
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID(+);
--기준으로 삼지 않을 테이블의 컬럼에 (+)를 붙여준다

--EMP_NAME 기준으로 이름의 값이 없더라도 조회

-- 2) RIGHT [ OUTER ] JOIN : 두 테이블 중 오른편에 기술한 테이블을 기준으로 JOIN
-- 일치하는 컬럼이 존재하지 않더라도 오른쪽 테이블의 데이터는 무우우조건 다 조회

--> ANSI
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORACLE
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID;

-- DEPT_TITLE 기준으로 부서명에 사람이 없더라도 조회

-- 3) FULL [ OUTER ] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있는 JOIN

--> ANSI
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
  FULL
 OUTER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 두테이블의 값이 없는 모든 컬럼도 다 조회

--> ORACLE : 오라클 구문에서는 사용이 불가능!!
SELECT 
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID(+);
---------------------------------------------------------------------------
/*
 * 3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인(CROSS JOIN)
 * 모든 테이블의 각 행들을 서로서로 매핑해서 조화된 (곱집합) ** 사용금지 문법
 * 
 * 두 테이블들의 행들이 곱해진 조회 뽑아냄 => 데이터 많을수록 방대한 행이 생겨남
 * => 과부화의 위험
 */

--> ORACLE
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT;
--                                  23   *    9       =>  207
--> ANSI
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE CROSS JOIN DEPARTMENT;
--------------------------------------------------------------------------------
/*
 * 4. 비등가 조인(NON EQUAL JOIN)
 * '='를 사용하지 않는 조인
 * 
 * 컬럼값을 비교하는 경우가 아니라 "범위"에 포함되는 내용을 매칭
 */
-- EMPLOYEE테이블로부터 사원명, 급여
SELECT 
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE;

SELECT * FROM SAL_GRADE;

--> ORACLE
SELECT 
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
     , MIN_SAL, MAX_SAL
  FROM
       EMPLOYEE
     , SAL_GRADE
 WHERE
       SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI
SELECT 
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE
  JOIN
       SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
 --------------------------------------------------------------------------    
/*
 * 5. 자체조인(SELF JOIN)
 * 
 * 같은 테이블을 다시 한 번 조인하는 경우
 * 자기 자신의 테이블과 조인을 맺음
 */
SELECT 
       EMP_ID "사원번호"
     , EMP_NAME "사원 이름"
     , PHONE "전화번호"
     , MANAGER_ID "사수번호"
  FROM
       EMPLOYEE;

SELECT EMP_ID, EMP_NAME, PHONE, MANAGER_ID FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--> ORACLE
-- 사원사번, 사원명, 사원 폰번호, 사수번호
-- 사수사번, 사수명, 사수 폰번호
SELECT 
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
       M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E,
       EMPLOYEE M
--조회하는 테이블이 같을 때 별칭을 붙여 구분 => 카테시안 곱
 WHERE
       --E.MANAGER_ID = M.EMP_ID;
--사수번호가 없는 사원이 존재해서 15명만 조회
       E.MANAGER_ID = M.EMP_ID(+);

--> ANSI
SELECT 
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
       M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E
  LEFT
  JOIN    
       EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
-------------------------------------------------------------------------------
/*
 * < 다중 JOIN >
 * 
 */
-- 사원명 + 부서명 + 직급명 + 지역명(LOCAL_NAME) --> 4개가 전부 다른 테이블
SELECT * FROM EMPLOYEE;    -- EMP_NAME    DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_TITLE  DEPT_ID              LOCATION_ID
SELECT * FROM JOB;         -- JOB_NAME               JOB_CODE
SELECT * FROM LOCATION;    -- LOCAL_NAME                       LOCAL_CODE
--미리 정리해서 하는것이 꼬이지 않음(계획이 80%-얼마나 꼼꼼하게 했는지, 순서도 계획-차근차근)

--EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
--> ANSI 구문
SELECT
       EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
  FROM
       EMPLOYEE
  LEFT--
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING (JOB_CODE)
  LEFT--
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE);
-- 부서, 지역명이 없는 2명이 제외 -> LEFT

--> ORACLE
SELECT
       EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
  FROM
       EMPLOYEE E
     , DEPARTMENT
     , JOB J
     , LOCATION
 WHERE    
       DEPT_CODE = DEPT_ID(+)
   AND     
       LOCATION_ID = LOCAL_CODE(+)
   AND     
       E.JOB_CODE = J.JOB_CODE;
---------------------------------------------------------------------------------
/*
 * < 집합 연산자 SET OPERATOR> (= 집합)
 * 
 * 여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
 * 
 * - UNION : 합집합(두 쿼리문의 수행 결과값을 더한 후 중복되는 부분을 제거)
 * - INTERSECT : 교집합(두 쿼리문의 수행 결과값중 중복된 부분)
 * - MINUS : 차집합(선행 쿼리문 결과값 빼기 후행 쿼리문의 결과값을 한 결과)
 *   -- AND, OR문으로 대체 가능
 * - UNION ALL : 합집합의 결과에 교집합을 더한 개념
 * (두 쿼리문을 수행한 결과값을 무조건 더함. 합집합에서 중복 제거를 하지 않는 것)
 * => 중복행이 여러 번 조회 될 수 있음
 */

-- 1. UNION
-- 부서코드가 D5인 사원들 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'; -- 6명
--급여가 300만원 초과인 사원들
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; -- 8명

SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
--쿼리와 쿼리 사이에 UNION을 붙임
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
        = 'D5'
    OR
       SALARY > 3000000;
-- UNION 쓰려면 SELECT절에 시술하는 컬럼이 같아야 함(=>OR문과 비슷, 같지 않음)

--부서코드가 D1, D2, D5인 부서의 급여합계를 조회하고 싶다
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
--GROUP BY문으로 대체 가능
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D1', 'D2', 'D5')
 GROUP BY DEPT_CODE;
-----------------------------------------------------------------------------
-- 2. UNION ALL : 여러 개의 쿼리 결과를 무조건 합치는 연산자(중복 가능) => 대체불가
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
   ALL
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
-----------------------------------------------------------------------------
-- 3. INTERSECT : (교집합 - 여러 쿼리 결과의 중복된 결과만을 조회)
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
INTERSECT
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
--AND문으로 대체 가능
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       SALARY > 3000000;
-----------------------------------------------------------------------------
-- 4. MINUS : (차집합 - 선행쿼리 결과에서 후행 쿼리결과를 뺀 나머지)
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 MINUS
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
--AND문으로 대체 가능
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       SALARY <= 3000000;
-- 관점의 전환하면 대체 가능
































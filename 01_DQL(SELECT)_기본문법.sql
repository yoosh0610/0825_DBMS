-- 주석문 : 한 줄 주석 적을 때는 이렇게 씁니다.
/*
	여러 줄 주석을 사용할 때 이렇게 씁니다.
*/

/*
 * <SELECT>
 * 데이터를 조회하거나 검색할 때 사용하는 명령어
 * 
 * [ 표현법 ]  --  컬럼명
 * SELECT 
 * 		  조회하고자 하는 컬럼
 * 		, 조회하고자 하는 컬럼
 * 		, 조회하고자 하는 컬럼
 * 	 FROM
 * 		  테이블명;
 * 
 * SELECT문의 결과는 행 단위로 조회됨
 * 
 *  - ResultSet : 조회된 행들의 집합 // SELECT문을 통해 조회된 데이터 결과물을 의미함
 */

-- EMPLOYEE테이블에서 모든 컬럼을 전부 다 조회하겠다.(*)
SELECT * FROM EMPLOYEE; -- 이 방법은 사용해선 안됨
-- * 사용 시 성능에 영향을 끼침

-- SELECT EMP_ID FROM EMPLOYEE; <- 이런식으로 조회
-- 갈색->키워드  녹색은 식별자도 구별
SELECT  -- 이렇게 쓰는 걸 권장함(보기 좋아서)
       EMP_NAME
     , EMAIL
     , SALARY
  FROM
       EMPLOYEE;

SELECT emp_name, email, salary FROM employee; -- 이렇게해도 실행됨

-- 명령어, 키워드, 테이블명, 컬럼명은 대/소문자를 가리지 않음
-- 소문자로 작성을 해도 잘 동작을 하지만 대문자로 작성하는 습관을 들이는 것이 좋음



-- 실습문제

-- 1. JOB테이블에서 JOB_CODE, JOB_NAME컬럼을 조회하세요.
SELECT 
       JOB_CODE
     , JOB_NAME
  FROM
       JOB; 
-- 2. JOB테이블에서 직급명만 조회하게 SELECT문을 작성해보세요.
SELECT
       JOB_NAME
  FROM     
       JOB;
-- 3. DEPARTMENT 테이블에서 DEPT_ID, DEPT_TITLE, LOCAITON_ID 컬럼을 조회하세요.
SELECT
       DEPT_ID
     , DEPT_TITLE
     , LOCAITON_ID
  FROM   
       DEPARTMENT;
-- 4. EMPLOYEE테이블에서 EMP_NAME, EMAIL, PHONE컬럼을 조회하세요.
SELECT
       EMP_NAME
     , EMAIL
     , PHONE
  FROM   
       EMPLOYEE;
-- 5. EMPLOYEE테이블에서 HIRE_DATE, EMP_NAME, SALARY컬럼을 조회하세요.
SELECT
       HIRE_DATE
     , EMP_NAME
     , SALARY
  FROM   
       EMPLOYEE;
--------------------------------------------------------------------------
/*
 * < 컬럼의 ㅈ회된 값을 통한 산술연산>
 * 컬럼들을 나열해서 조회를 할 때 산술연산(+, -, *, /)을 기술해서 결과를 조회할 수 있음
 */

-- EMPLOYEE테이블로부터 직급명, 월급, 연봉(== 월급 x 12)
SELECT
       EMP_NAME
     , SALARY
     , SALARY * 12 + 400000
  FROM   
       EMPLOYEE;

-- EMPLOYEE테이블로부터 사원명, 월급, 보너스, 보너스를 포함한 연봉((월급 * 보너스 + 월급) * 12)
SELECT
       EMP_NAME
     , SALARY
     , BONUS
     , ((SALARY * BONUS + SALARY) * 12)
  FROM   
       EMPLOYEE;
--> 산술연산 과정에서 NULL값이 존재할 경우 산술연산의 결과도 NULL이 된다.

-- DATE => 년, 월, 일, 시, 분, 초
-- DATE 타입끼리의 연산 --> 근무 일수(오늘날짜 - 입사일)
-- 현재 지금 시점의 날짜값 : SYSDATE
SELECT
       EMP_NAME
     , HIRE_DATE
     , SYSDATE - HIRE_DATE -- 일 단위(시, 분, 초도 연산되어서 표기 => 매번 달라짐)
  FROM   
       EMPLOYEE;
-- 결과값은 일 단위 --> 값이 지저분한 이유는 DATE안에서 시/분/초가 포함되어 있으므로
-- 시/분/초까지 연산을 수행해서 지저분하게 나옴

-----------------------------------------------------------------------------------
/*
 * < 컬럼명의 별칭 부여하기>
 * [ 표현법 ]
 * 컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭
 * 
 * 별칭에 특수문자 또는 공백문자가 포함될 경우 반드시 ""로 묶어주어야 함
 */

SELECT
       EMP_NAME AS 사원명
     , SALARY AS "급여 (월)" --( )이면 연산으로 인식, 공백에도 => " "로 묶어줘야 함
  FROM   
       EMPLOYEE;

--------------------------------------------------------------------------------
/*
 * < 리터럴 >
 * 
 * 임의로 지정한 문자열('')을 SELECT절에 기술하게 되면
 * ResultSet을 반환받을 때 데이터를 붙여서 조회할 수 있음
 */
-- EMPLOYEE테이블로부터 사원명, 급여
SELECT
       EMP_NAME
     , SALARY
     , '원' 단위
  FROM   
       EMPLOYEE;

------------------------------------------------------------------------------------
/*
 * <DISTINCT>
 * 
 * 조회하고자 하는 컬럼 앞에 작성하여 중복된 값을 딱 한번만 조회하는 용도
 * 
 * 주의) SELECT에 DISTINCT구문은 한 개만 사용이 가능
 */

SELECT
       DISTINCT DEPT_CODE
  FROM   
       EMPLOYEE;
----------------------------------------------------------------------------

/*
 * SELECT문을 이용해서 조회를 할 때 조건을 부여하는 방법!
 * 
 * < WHERE 절 >
 * 조회하고자 하는 테이블에 특정 조건을 제시해서
 * 족건에 만족하는 행만 조회하고자 할 때 기술하는 구문
 * 
 * [ 표현법 ]
 * SELECT
 *        컬럼명
 *      , 컬럼명
 *      , 컬럼명
 *   FROM
 *        테이블명
 *  WHERE
 *        조건식;
 * 
 * - 조건식에 다양한 연산자들을 사용할 수 있음
 * 
 * < 비교연산자 >
 * >, <, <=, >=  // 대소비교
 * 
 * =, !=  // 동등비교
 */

-- EMPLOYEE테이블로부터 사원들의 사원명, 급여 조회 --> 급여가 300만원 이상인 사원들만
SELECT
       EMP_NAME
     , SALARY
  FROM   
       EMPLOYEE
 WHERE
       SALARY >= 3000000;

-- EMPLOYEE테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드 조회
SELECT
       EMP_NAME
     , DEPT_CODE
  FROM   
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D9';

-- EMPLOYEE테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 전화번호 조회
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
    --   DEPT_CODE != 'D9'; => 가장 일반적인 방식
    --   DEPT_CODE ^= 'D9';
       DEPT_CODE <> 'D9';

-- 실행순서(합리적인) 1. FROM(목적지) -> 2. WHERE(조건) -> SELECT(조회결과)
----------------------------------------------------------------------------------
/*
 * < 실습 >
 */
-- 1. EMPLOYEE 테이블에서 급여가 250만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT
       EMP_NAME
     , SALARY
     , HIRE_DATE
  FROM   
       EMPLOYEE
 WHERE
       SALARY >= 2500000;
-- 2. EMPLOYEE 테이블에서 부서코드가 D6인 사원들의 이름, 급여, 보너스 조회
SELECT
       EMP_NAME
     , SALARY
     , BONUS
  FROM   
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D6';
-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원(ENT_YN == 'N')들의 이름, 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM   
       EMPLOYEE
 WHERE
       ENT_YN = 'N';
-- 4. EMPLOYEE 테이블에서 연봉이 5000 이상인 사원들의 이름 연봉 조회
-- 단, 연봉컬럼은 별칭으로 연봉으로 조회되게 할 것
SELECT
       EMP_NAME
     , (SALARY * 12) AS "연봉" -- 한눈에 알아보기 좋게 표기
  FROM   
       EMPLOYEE
 WHERE
       (SALARY * 12) >= 50000000;
---------------------------------------------------------------------------
/*
 *< 논리 연산자 >
 * 여러 개의 조건을 엮을 때 사용
 * 
 * AND(~~이면서, 그리고) / OR(~~이거나, 또는)
 */

--EMPLOYEE 테이블에서 부서코드가 'D9'면서 급여가 500만원 이하인 사원들의
-- 사원명, 부서코드, 급여 조회
SELECT
       EMP_NAME
     , SALARY
     , DEPT_CODE
  FROM   
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D9'
   AND    
       SALARY <= 5000000;

-- EMPLOYEE 테이블에서 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의
-- 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
     , SALARY
     , DEPT_CODE
  FROM   
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D6'
    OR    
       SALARY >= 3000000;

-- EMPLOYEE 테이블에서 급여컬럼의 값이 350만원 이상이고 500만원 이하인 사원들의
-- 사번(EMP_ID), 이름, 급여를 조회
SELECT
       EMP_NAME
     , SALARY
     , EMP_ID
  FROM   
       EMPLOYEE
 WHERE
       SALARY >= 3500000
   AND    
       SALARY <= 5000000;
------------------------------------------------------------------------------
/*
 * < BETWEEN AND > <= 이 코드를 선호함
 * 몇 이상 몇 이하인 범위에 대해서 조건을 제시할 때 사용
 * 
 * 표현법
 * 비교대상컬럼명 BETWEEN 하한값 AND 상한값
 */
-- EMPLOYEE 테이블에서 급여가 350만원 이상이고 500만원 이하인 사원들의 사번, 이름, 직급코드(JOB_CODE)
SELECT
       EMP_NAME
     , JOB_CODE
     , EMP_ID
  FROM   
       EMPLOYEE
 WHERE
       SALARY BETWEEN 3500000 AND 5000000;
   
-- EMPLOYEE 테이블에서 급여가 350만원 미만이거나 500만원을 초과하는 사원들의 사번, 이름, 직급코드
SELECT
       EMP_NAME
     , JOB_CODE
     , EMP_ID
  FROM   
       EMPLOYEE
 WHERE
       SALARY NOT BETWEEN 3500000 AND 5000000;
--> 오라클에서의 NOT은 자바의 !와 동일한 의미(날짜체크할때 많이 사용)

/*호텔조회 사이트
 *  FROM 
 *       TB_HOTEL
 * WHERE
 *       LOCATION = '오사카'
 *   AND
 *       DATE BETWEEN '09/09' AND '09/11'
 */

-- BETWEEN AND 연산자는 DATE형식에서도 사용 가능
-- 입사일이 '90/01/01' ~ '03/01/01'인 사원들의 이름 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM   
       EMPLOYEE
 WHERE
       HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

------------------------------------------------------------------
/*
 * < LIKE '특정패턴' >
 * 비교하려는 컬럼의 값이 내가 지정한 특정 패턴에 만족할 경우 조회
 * 
 * [ 표현법 ]
 * 비교대상컬럼 LIKE '특정패턴'
 * 
 * - 특정패턴 --> 와일드카드
 * '%', '_' => 두 가지를 가지고 패턴을 만들 수 있음
 * 
 * '%' : 0글자 이상
 *       비교대상컬럼 LIKE 'A%' => 컬럼값 중 'A'로 시작하는 것만 조회 -> Apple, Add, A
 *       비교대상컬럼 LIKE '%A' => 컬럼값 중 'A'로 끝나는 것만 조회 -> BananA, GolilA, A
 *       비교대상컬럼 LIKE '%A%' => 컬럼값 중 'A'가 포함되는 것을 전부 조회
 * '_' : 1글자
 * 비교대상컬럼 LIKE '_A' => 컬럼값 중 'A'앞에 무조건 1글자가 있어야만 패턴에 만족
 * 비교대상컬럼 LIKE '__A' => 컬럼값 중 'A'앞에 무조건 2글자가 있어야만 패턴에 만족
 */
-- EMPLOYEE 테이블로부터 모든 사원의 이름, 전화번호 조회
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE;

-- EMPLOYEE 테이블에서 성이 '박'씨인 사원들의 사원명, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '박%';

-- EMPLOYEE 테이블에서 이름에 '준'이라는 글자가 포함된 사원들의 사원명, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '%준%';

-- 이름에 두번째 글자가 '승'인 사원들의 사원명, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '_승_';

-- 이름에 두번째 글자가 '승'이 아닌 사원들의 사원명, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       EMP_NAME NOT LIKE '_승_';

--> 자바에서 for charArr [1].equals("승") <= 전체조회 후 조건을 검색하기 때문에 비효율적(속도,연산,메모리공간) 

--------------------------------------------------------------------------
/*
 * LIKE
 */
-- 1. EMPLOYEE 테이블로부터 전화번호 4번째 자리가 9로 시작하는 사원들의 사원명, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       PHONE LIKE '___9%';
-- 2. EMPLOYEE 테이블로부터 이름이 '영'으로 끝나는 사원들의 이름, 입사일
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM   
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '%영';
-- 3. EMPLOYEE 테이블로부터 전화번호 처음 3자리가 010이 아닌 사원들의 이름, 전화번호
SELECT
       EMP_NAME
     , PHONE
  FROM   
       EMPLOYEE
 WHERE
       PHONE NOT LIKE '010%';
-- 4. DEPARTMENT 테이블로부터 해외 영업과 관련된 부서들의 부서명 조회
SELECT 
       DEPT_TITLE
  FROM
       DEPARTMENT
 WHERE  
       DEPT_TITLE LIKE '%해외영업%';
----------------------------------------------------------------------------
/*
 * < IS NULL >
 * 
 * [ 표현법 ]
 * 
 * 비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
 * 비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닐 경우
 */
SELECT 
       EMP_NAME
     , BONUS 
  FROM
       EMPLOYEE;
-- EMPLOYEE 테이블로부터 보너스를 받지 않는 (보너스가 없는) 사원들의 사원명, 보너스 조회
SELECT 
       EMP_NAME
     , BONUS 
  FROM
       EMPLOYEE
 WHERE
       BONUS IS NULL;-- NULL값은 동등비교할수 없다
 -- EMPLOYEE 테이블로부터 보너스를 받는 사원들의 사원명, 보너스 조회
SELECT 
       EMP_NAME
     , BONUS 
  FROM
       EMPLOYEE
 WHERE
       BONUS IS NOT NULL;
-----------------------------------------------------------------------------------
/*
 * < 연결연산자 || >
 * 여러개의 컬럼 값들을 마치 하나의 컬럼인것처럼 연결시켜주는 연산자
 * 컬럼값 또는 리터럴(문자열)을 전부 다 합칠 수 있음
 * 
 * System.out.println(num + "fdsa");
 */
SELECT 
       EMP_ID || EMP_NAME
  FROM
       EMPLOYEE;
 
SELECT EMP_ID || '번 사원 ' || EMP_NAME || '님의 핸드폰번호는 ' ||
       PHONE || '입니다.' AS "사원의 정보"
  FROM
       EMPLOYEE;
---------------------------------------------------------------------------
/*
 * < IN >
 * 비교대상 컬럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지
 */
-- EMPLOYEE 테이블로부터 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드 조회
/*
 SELECT 
       EMP_NAME
     , DEPT_CODE 
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D6'
    OR
       DEPT_CODE = 'D8'
    OR
       DEPT_CODE = 'D5';
*/
SELECT 
       EMP_NAME
     , DEPT_CODE 
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN ('D6', 'D8', 'D5');
------------------------------------------------------------------------------------
/*
 * < 연잔사 우선순위 >
 * 
 * 1. ( )
 * 2. 산술연산자
 * 3. 연결연산자
 * 4. 비교연산자
 * 5. IS NULL, LIKE, IN (앞에 있는,왼쪽부터)
 * 6. BETWEEN AND
 * 7. NOT
 * 8. AND
 * 9. OR
 */
----------------------------------------------------------------------------
/*
 * < ☆★☆★☆★☆★☆★☆★ ORDER BY 절 ☆★☆★☆★☆★☆★☆★☆★ >
 * 정렬용도로 사용하는 구문
 * SELECT문의 가장 마지막에 작성하는 문법 + 실행 순서 또한 가장 마지막
 * ORDER BY절을 작성하지 않으면 RseultSet은 정렬이 안된 상태
 * 
 * 표현법
 * 
 * SELECT
 *        컬럼명
 *      , 컬럼명
 *      , ...
 *   FROM
 *        테이블명
 *  WHERE
 *        조건식(생략가능)
 *  ORDER
 *     BY
 *        [정렬기준으로 삼고싶은 컬럼명 / 별칭 / 컬럼 순번 ]
 *        [ASC / DESC ]
 *        [NULL FIRST / NULL LAST] (생략가능)
 * 
 * - ASC : 오름차순 정렬(기본값)
 * - DESC : 내림차순 정렬
 * 
 * - NULLS FIRST : 컬럼값이 NULL일 경우 조회결과의 위쪽에 배치(내림차순일 경우 기본값)
 * - NULLS LAST : 컬럼값이 NULL일 경우 조회결과의 아래쪽에 배치(오름차순일 경우 기본값)
 */
SELECT 
       EMP_ID
     , EMP_NAME 
  FROM
       EMPLOYEE;
-- 숫자가 오름차순으로 정렬된 것처럼 출력(원래 정렬X상태) => 정렬을 꼭 줘야하 함

SELECT 
       EMP_ID
     , EMP_NAME
     , BONUS
  FROM
       EMPLOYEE
 ORDER
    BY
--     BONUS; ASC / DESC 생략 시 ASC(오름차순)
--     BONUS DESC; 내림차순 정렬시 기본적으로 NULLS FIRST
--     BONUS DESC NULLS LAST; 
       BONUS, EMP_ID, EMP_NAME;
-- 첫번째로 제시한 정렬기준의 컬럼값이 동일할 경우 다음 정렬기준을 명시할 수 있음
-- 다국적 언어일 경우 영어, 중국, 일본, 한국(국가 코드순으로)
/*
SELECT
       EMP_NAME
     , SALARY * 12 AS "연봉"
  FROM   
       EMPLOYEE;
 WHERE 
       연봉 > 40000000; 
 */      
-- 위에 코드는 안됨 -> 실행 순서때문
-- FROM(테이블) -> WHERE() -> SELECT() -> ORDER BY 
SELECT
       EMP_NAME
     , SALARY * 12 AS "연봉"
  FROM   
       EMPLOYEE;
 WHERE 
       SALARY > 40000000;
 ORDER
    BY
     --연봉; 별칭 사용가능
	   2; --권장하지 않는 방법 (추가나 삭제될 때마다 수정해야 함 => 비추천)
















/*
	함수  < FUNCTION >

	자바로 따지면 메소드
	전달된 값을 가지고 계산된 결과를 반환해준당
	
	- 단일행 함수 : N개의 값을 읽어서 N개의 결과값을 반환(매 행마다 함수 결과 반환)
	- ☆그룹 함수☆ : N개의 값을 읽어서 1개의 결과값을 반환(그룹별로 함수 결과 반환)
*/
--------------------------- < 단일행 함수 > ---------------------
SELECT
        SALARY
      , LENGTH(SALARY)
   FROM
        EMPLOYEE;
  
SELECT
        SALARY
      , LENGTH(SALARY)
      , SUM(SALARY)
   FROM
        EMPLOYEE;
-- 단일행 함수와 그룹함수는 함께 사용할 수 없음 : 결과 행의 개수가 다르기 때문





/*
 * < 문자열 관련된 함수 >
 * LENGTH / LENGTHB
 * 
 * STR : '문자열' / 문자열이 들어가는 컬럼
 * 
 * "equals".length(); <-- 애랑 똑같음
 * - LENGTH(STR) : 전달된 문자열의 글자 수 반환
 * - LENGTHB(STR) : 전달된 문자열의 바이트 수 반환
 * 
 * 결과는 NUMBER타입
 * 
 * 한글 : 'ㄱ', 'ㅏ', '강' => 한 글자당 3Byte
 * 숫자, 영어, 특수문자 => 한 글자당 1Byte
 */
SELECT
       LENGTH('오라클!')
     , LENGTHB('오라클!')
  FROM
       DUAL; -- 가상테이블(DUMMY TABLE)

SELECT
       EMAIL
     , LENGTH(EMAIL)
  FROM
       EMPLOYEE;
----------------------------------------------------------------------------
/*
 * INSTR
 * 
 * INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
 * 
 * INSTR(STR, '특정 문자', 찾을 위치의 시작값, 순번)
 * 
 * 결과값은 NIMBER타입으로 반환
 * 찾을 위치의 시작값과 순번은 생략이 가능
 * 
 * 찾을 위치의 시작값
 * 1 : 앞에서부터 찾겠다(생략가능)
 * -1 : 뒤에서부터 찾겠다
 */
SELECT
       INSTR('AABAACAABBAA', 'B')
  FROM
       DUAL;

SELECT
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- 뒤에서부터 첫 번째 'B'가 앞에서부터 몇 번째인지

SELECT
       INSTR('AABAACAABBAA', 'B', 1, 3)  
  FROM
       DUAL;-- 앞에서부터 세 번째 'B'가 앞에서부터 몇 번째인지

SELECT
       INSTR(EMAIL, '@') "@의 위치"
  FROM
       EMPLOYEE;
-----------------------------------------------------------------------------
/*
 * SUBSTR
 * 
 * - SUBSTR(STR, POSITION, LENGTH) : 문자열로부터 특전 문자열을 추출해서 반환
 * 
 * - STR : '문자열' 또는 문자타입 컬럼 값
 * - POSITION : 문자열 추출 시작위치값(POSITION번째 문자열부터 추출) -> 음수도 가능
 * - LENGTH : 추출할 문자 개수(생략시 끝자리라는 의미)
 */
SELECT
       SUBSTR('KH정보교육원', 3)
  FROM
       DUAL;

SELECT
       SUBSTR('KH정보교육원', 3, 2)
  FROM
       DUAL;

SELECT
       SUBSTR('KH정보교육원', -3, 2)
  FROM
       DUAL; -- POSITION이 음수일 경우 뒤에서 N번째 부터 추출하겠다 라는 의미

-- EMPLOYEE 테이블로부터 사원명과 이메일컬럼과 EMAIL컬럼값 중 아이디값만 추출해서 조회
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) "아이디"
  FROM
       EMPLOYEE;

SELECT
       *
  FROM
       EMPLOYEE;
-------------------------------------------------------------------------------------
-- 성별중에 남성만 조회(주민번호 뒷자리에서 확인 - 1이면 남자, 2면 여자)
SELECT
       EMP_NAME
     , SUBSTR(EMP_NO, 8, 1)
  FROM
       EMPLOYEE;
-- 남성 사원들만 조회
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SUBSTR(EMP_NO, 8, 1) = 1; --SUBSTR(EMP_NO, 8, 1) = '1';
-----------------------------------------------------------------------------------------
/*
 * LPAD / RPAD
 * 
 * - LPAD(LeftPAD) / RPAD(RightPAD)(STR, 최종적으로 반환할 문자의 길이(바이트), 패딩할 문자)
 *  : 인자로 전달할 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 N길이만큼의 문자열 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 * 덧붙이고자 하는 문자는 생략 가능
 */

SELECT
       LPAD(EMAIL, 25)
  FROM
       EMPLOYEE;
-- 공백문자가 들어가고 25바이트가 되도록 체움(공백도 1바이트)

SELECT
       LPAD(EMAIL, 25, '!')
  FROM
       EMPLOYEE;

-- EMPLOYEE테이블에서 모든 직원의 사원명과 주민등록번호 뒤 6자리를 마스킹처리해서 조회하기
-- 예시 => 이** 621335-1******
SELECT
       SUBSTR(EMP_NAME, 1, 1)
     , SUBSTR(EMP_NO, 1 ,8)
  FROM
       EMPLOYEE;

SELECT
       RPAD(SUBSTR(EMP_NAME, 1, 1), 4, '*') --한글이 2바이트로 쓰임, 기본적으로 3바이트
     , RPAD(SUBSTR(EMP_NO, 1 ,8), 14, '*')
  FROM
       EMPLOYEE;

------------------------------------------------------------------------------
/*
 * LTRIM/ RTRIM(STR, 제거하고자 하는 문자)
 * : 문자열의 왼쪽 또는 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 */

SELECT
       LTRIM('      K  H')
  FROM
       DUAL;

SELECT
       LTRIM('123123KH123', '123')
  FROM
       DUAL;
--------------------------------------------------------------------------------
/*
 * TRIM
 * 
 *  - TRIM(BOTH / LEADING / TRAILING '제거하고자 하는 문자' FROM STR)
 *  : 문자열의 앞 / 뒤 / 양쪽에 있는 문자를 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER
 * BOTH / LEADING / TRAILING !!!!!
 */
SELECT
       TRIM('      K  H   ')
  FROM
       DUAL; -- BOTH

SELECT
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL;

SELECT
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL;
------------------------------------------------------------------------------------
/*
 * LOWER / UPPER / INITCAP
 * 
 * - LOWER(STR)
 * : 다 소문자로 변경
 * 
 * - UPPER(STR)
 * : 다 대문자로 변경
 * 
 * - INITCAP(STR)
 * : 각 단어마다 앞글자만 대문자로 변경
 * 
 * 결과값은 모두 결과값은 CHARACTER타입으로 반환
 */
SELECT
       LOWER('HELLO WORLD')
  FROM
       DUAL;

SELECT
       UPPER('hello world')
  FROM
       DUAL;

SELECT
       INITCAP('hello world')
  FROM
       DUAL;
-------------------------------------------------------------------------
/*
 * CONCAT
 * 
 * - CONCAT(STR1, STR2)
 * : 전달된 두 개의 인자를 하나로 합친 결과를 반환
 * 
 * 반환타입은 CHARACTER
 */
SELECT CONCAT('경실련 하이텔', '정보교육원')!!!!!!!!
--------------------------------------------------------------------------
/*
 * REPLACE
 * 
 * - REPLACE(STR, 찾을문자, 바꿀문자)
 * : STR로부터 찾을 문자를 찾아서 바꿀 문자로 바꾼 문자열을 반환
 * 결과값은 CHARACTER타입
 */
SELECT
       REPLACE('서울시 중구 남대문로 120 대일빌딩', '대일빌딩', '그레이츠 청계')
  FROM
       DUAL;

SELECT
       EMAIL
     , REPLACE(EMAIL, 'kh.or.kr','iei.co.kr')
  FROM
       EMPLOYEE;
-----------------------------------------------------------------------------
/*
 * MOD
 * 
 * - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지 값 !!!!!!!!!!!!!!
 * 
 */

SELECT
       MOD(10, 3)
     , MOD(-10, 3)
     , MOD(10.8, 3)
  FROM
       DUAL;
-- 자바는 기본 실수자료형로 연산하면 안됨, 여기서 처리
---------------------------------------------------------------------------------
/*
 * ROUND
 * - ROUND(NUMBER, 위치) : 반올림 처리해주는 함수
 * 
 * 위치 : 소수점 아래 N번째 !!!!!!!!!!!!!!!!!
 * 생략도 가능, 생략시 기본값은 0
 */
SELECT
       ROUND(123.456)
     , ROUND(123.456, 1)
     , ROUND(123.456, 2)
     , ROUND(123.456, -1)
     , ROUND(123.456, -2)
  FROM
       DUAL;
-----------------------------------------------------------------------------------
/*
 * FLOOR
 * 
 * - FLOOR(NUMBER) 소수점 라애의 수를 무조건 버림처리해주는 함수
 * 
 * CEIL
 * 
 * - CEIL(NUMBER) 소수점 아래의 수를 무조건 올림처리해주는 함수
 */
SELECT
       FLOOR(123.45)
  FROM
       DUAL;

SELECT
       CEIL(123.456)
  FROM
       DUAL;
--소수점자리를 지정할 수 없다

--한자리만 버리고 싶다
SELECT
       FLOOR(123.45 * 10) / 10
  FROM
       DUAL;
--인식의 변화를 해야 할 필요가 있다

-- 각 직원별로 고용일로부터 오늘까지의 근무 일수 조회 + 이름조회
SELECT
       EMP_NAME 
     , FLOOR(SYSDATE - HIRE_DATE) -- 버림처리하면 이쁘게 떨어짐
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME 
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일') "근무일자" 
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME 
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일') "근무일자"
  FROM
       EMPLOYEE
 WHERE     
       FLOOR(SYSDATE - HIRE_DATE) > 365 * 17;

-----------------------------------------------------------------------
/*
 * TRUNC
 * - TRUNC(NUMBER, 위치) : 소수점 뒤 위치지정이 가능한 절삭처리 함수
 */
SELECT
       TRUNC(123.465, 2)
  FROM
       DUAL;
-------------------------------------------------------------
/*
 * < 날짜 관련 함수 >
 * 
 * DATE 타입 : 년, 월, 일, 시, 분, 초를 모두 포함한 자료형(데이터가 더 작음, 7바이트)
 * TIMESTAMP <- 얘는 나중에(나노초,시간기준선까지 포함, 금융쪽에서) 
 */
SELECT
       SYSDATE
     , SYSTIMESTAMP
  FROM
       DUAL;

-- MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜사이의 개월 수 반환(NUMBER)
-- EMPLOYEE테이블로부터 각 사원 사원명, 고용일로부터 근무일수, 근무개월 수 조회
SELECT
       EMP_NAME 
     , FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수" 
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "개월수"
  FROM
       EMPLOYEE;

-- ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더한 날짜(DATE로 반환)
SELECT
       ADD_MONTHS(SYSDATE, 4)
  FROM
       DUAL;

-- NEXT_DAY(DATE, 요일) : 특정날짜에서 가장 가까운 요일을 찾아 그 날짜를 반환
SELECT
       NEXT_DAY(SYSDATE, '금요일')
     , NEXT_DAY(SYSDATE, '금')
     , NEXT_DAY(SYSDATE, 6) --1: 일요일, 2: 월요일, 3:화요일, ..7: 토요일
  FROM
       DUAL;
-- 언어변경 ALTER SESSION SET NLS_LANGUAGE = AMERICAN; // KOREA

-- LAST_DAY(DATE) 날짜를 받아서 해당 날짜가 있는 달의 마지막 날짜를 반환
SELECT
       LAST_DAY(SYSDATE)
  FROM
       DUAL;
---------------------------------------------------------------------------------
/*
 * ☆★EXTRACT : 년도 또는 월 또는 일정보를 추출해서 반환(NUMBER타입)
 * 
 * - EXTRACT(YEAR FORM DATE) : 년도만 추출
 * - EXTRACT(MONTH FORM DATE) : 월만 추출
 * - EXTRACT(DAY FORM DATE) : 일만 추출
 */

-- EMPLOYEE테이블에서 사원명 입사년도 입사월 입사일
SELECT
       EMP_NAME 
     , EXTRACT(YEAR FORM HIRE_DATE) AS "년도"
     , EXTRACT(MONTH FORM HIRE_DATE) AS "월"
     , EXTRACT(DAY FORM HIRE_DATE) AS "일"
     , EXTRACT(YEAR FORM SYSDATE)- EXTRACT(YEAR FORM HIRE_DATE)
  FROM
       EMPLOYEE;

--!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------------
/*
 * < 형변환 함수 >
 * 
 * NUMBER / DATE => CHARACTER
 * 
 * - TO_CHAR(NUMBER/DATE, 포맷) : 숫자 또는 날짜 데이터를 문자데이터타입으로 반환
 */
SELECT
       1234
     , TO_CHAR(1234)--문자로 변환(,로 자리수 구분X)
     , TO_CHAR(1234, '000000') --자리수보다 큰 콩간을 0으로 채움
     , TO_CHAR(1234, '99999') -- 자리수보다 큰 공간을 공백문자로 채움
     , TO_CHAR(1234, 'L00000') -- 설정된 나라(LOCAL)의 화폐단위
     , TO_CHAR(1234, '$99999')
     , TO_CHAR(12341234, 'L999,999,999,999')
  FROM
       DUAL;
--파란색은 넘버라는 뜻
-------------------------------------------------------------------------------
--DATE(년월일시분초) => CHARACTER
SELECT
       SYSDATE
     , TO_CHAR(SYSDATE)
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'PM HH:MI:SS')-- PM 오전 / 오후 출력
     , TO_CHAR(SYSDATE, 'HH24:MI:SS')-- 24시간 표기형식
     , TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL;
------------------------------------------------------------------
-- 년도로 쓸 수 있는 포맷 Y2K문제
SELECT
       TO_CHAR(SYSDATE, 'YYYY')--이얼
     , TO_CHAR(SYSDATE, 'RRRR')--라운드이얼
     , TO_CHAR(TO_DATE('26-95', 'DD-YY'), 'YYYY')
     , TO_CHAR(TO_DATE('26-95', 'DD-RR'), 'YYYY')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM
       DUAL;
-- RR은 상황에 따라 다르게 생각(0~49->2000, 50~99->1900)

-- 월에 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'MONTH')--영어로 쓰면 차이
     , TO_CHAR(SYSDATE, 'RM')
  FROM
       DUAL;

-- 일에 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'DD')
     , TO_CHAR(SYSDATE, 'D')--요일을 숫자로
     , TO_CHAR(SYSDATE, 'DDD')--365일중 현제 일수
  FROM
       DUAL;
-- DD : 한달기준
-- D : 일주일기준(일요일부터)
-- DDD : 일년기준(1월1일부터)

--요일
SELECT
       TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')--앞글자만
  FROM
       DUAL;

SELECT
       EMP_NAME
     --, TO_CHAR(HIRE_DATE, 'YYYY년 MM월 DD일')--안돌아감(한글은 묶어줘야함)
     , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')
  FROM
       DUAL;
-----------------------------------------------------------------
/*
 * NUMBER / CHARACTER => DATE
 * 
 * - TO_DATE(NUMBER, CHARACTER, 포맷) : 숫자/문자를 날짜로 변환(DATE로 반환)
 */
SELECT
       --20250826 정수로 인식
       TO_DATE(20250826)
     --, TO_DATE(001212)  정수는 00이 앞에 있으면 날아가버림
     , TO_DATE('001212')--''로 날짜를 묶어줘야함
     , TO_DATE('980607', 'YYMMDD') --년도에 따라 형식을 넣어줘야함
  FROM
       DUAL;
--------------------------------------------------------------------------------------
/*
 * CHARACTER => NUMBER
 * 
 * - TO_NUMBER(CHARACTER, 포맷) : 문자를 숫자형으로 변환(NUMBER로 반환)
 */
SELECT
      '01234'
    , TO_NUMBER('01234')
  FROM
       DUAL;

SELECT
       123 + 456
       '123' + '456'
       '123' || '456'
  FROM
       DUAL;

SELECT
       '11,000' + '20,000'
  FROM
       DUAL; -- 이건 불가능(,가 들어가면 오류)
       
 SELECT
        TO_NUMBER('44,000', '99,999') + TO_NUMBER('20,000','99,999')
   FROM
        DUAL; 
  ------------------------------------------------------------------------    
   /*
    * NULL처리 함수
    * 
    * NVL(컬럼명, 해당 컬럼값이 NULL값일 경우 반환할 결과값)
    */    
 --EMPLOYEE테이블로부터 사원명, 보너스 
 SELECT
       EMP_NAME 
     , BONUS 
     , NVL(BONUS, 0)
  FROM
       EMPLOYEE;
 
 --보너스를 포함 연봉조회
 SELECT
       EMP_NAME 
     , (SALARY + SALARY * BONUS) *12 
  FROM
       EMPLOYEE;
 
 SELECT
       EMP_NAME 
     , (SALARY + SALARY * NVL(BONUS, 0)) *12 
  FROM
       EMPLOYEE;
 
 SELECT
       EMP_NAME 
     , (SALARY + SALARY * NVL(BONUS, 0)) *12 
     , NVL(DEPT_CODE, '부서 없음')
  FROM
       EMPLOYEE;
 
 -- NVL2(컬럼명, 결과값1, 결과값2)
 -- 해당 컬럼에 값이 존재할 경우 결과값 1을 반환
 -- 해당 컬럼에 값이 NULL값일 경우 결과값 2를 반환
 SELECT
       EMP_NAME 
     , DEPT_CODE
     , NVL2(DEPT_CODE, '부서 배치 완료', '부서 없음')
  FROM
       EMPLOYEE;
 
 -- NULLIF(비교대상1, 비교대상2)
 -- 두 개의 값이 동일할 경우 NULL을 반환
 -- 두 개의 값이 동일하지 않을 경우 비교대상1을 반환
 SELECT
        NULLIF('1', '1')
      , NULLIF('1', '2')
  FROM
       DUAL;
 -----------------------------------------------------------------
 /*
  * < 선택함수 >
  * 
  * DECODE(비교대산(컬럼명/산술연산/함수식), 조건값1, 결과값1, 조건값2, 결과값2, ...결과값);
  * 
  *  - 자바에서의 switch문과 유사
  *  switch(비교대상){
  *  case 조건값1 : 결과값1;
  *  case 조건값2 : 결과값2;
  *  default 결과값;
  *  }
  */
 --EMPLOYEE테이블 사원명, 성별
 SELECT
       EMP_NAME 
     , SUBSTR(EMP_NO, 8, 1)
  FROM
       EMPLOYEE;
 
 SELECT
       EMP_NAME 
     , DECODE(SUBSTR(EMP_NO, 8, 1), 
              1, '남성', 
              2, '여성')
  FROM
       EMPLOYEE;
 
  SELECT
       EMP_NAME 
     , DECODE(SUBSTR(EMP_NO, 8, 1), 
              1, '남성', 
              2, '여성',
              '성별 선택 안함') AS "성별"
  FROM
       EMPLOYEE;
 
-- 직원들의 급여를 인상시켜서 조회
-- 직급코드(JOB_CODE)가 'J7'인 사원들의 급여는 15%인상해서 조회
--직급코드가 'J6'인 사원들의 급여는 20%인상해서 조회
--직급코드가 'J5'인 사원들의 급여는 30%인상해서 조회
--나머지 직급인 사원들의 급여는 5%인상해서 조회
 SELECT
       EMP_NAME 
     , SALARY
  FROM
       EMPLOYEE;
 
 SELECT
       EMP_NAME 
     , SALARY
     , JOB_CODE
     , DECODE(JOB_CODE, 'J7', (SALARY + SALARY * 0.15)
                      , 'J6', (SALARY + SALARY * 0.2)
                      , 'J5', (SALARY + SALARY * 0.3)
                      , (SALARY + SALARY * 0.05)) "인상 후 급여"
  FROM
       EMPLOYEE;
---------------------------------------------------------------------------- 
/*
 * CASE WHEN THEN 구문
 * 
 * - DECODE랑 비교했을 때 DECODE는 동등비교만 수행
 *   CASE WHEN THEN 다양한 조건식을 기술 가능
 * 
 * [ 표현법 ]
 * CASE
 *      WHEN 조건식1 THEN 결과값1
 *      WHEN 조건식2 THEN 결과값2
 *        ...
 *      ELSE 결과값
 * END
 */
 SELECT
        EMP_NAME 
      , CASE
	     WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남성' 
	     WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여성' 
	     ELSE '성별선택안함'
        END "성별"
   FROM
        EMPLOYEE;
 -----------------------------------------------------------------------------
 
 ---------------------------- < ☆그룹 함수☆ > -----------------------------
 /*
  * N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행결과를 반환)
  */
 -- KH그룹의 사원 급여의 합은 얼마인가?
 SELECT
        SALARY
   FROM
        EMPLOYEE;
 -- 1. SUM(숫자타입) : 해당 컬럼값들의 총 합계를 반환해주는 함수
 -- 전체 사원의 총 급여합계
 SELECT
        SUM(SALARY)
   FROM
        EMPLOYEE;
 
 -- 이메일에 0이 들어가있는 사원들의 총 급여 합 
 SELECT
        SUM(SALARY)
   FROM
        EMPLOYEE
  WHERE      
        EMAIL LIKE '%0';
 
-- 부서코드가 D5인 친구들만 
 SELECT
        SUM(SALARY)
   FROM
        EMPLOYEE
  WHERE      
        EMAIL LIKE '%0'
    AND   
        DEPT_CODE = 'D5';
 
 -- 2. AVG(숫자타입) : 해당 컬럼값들의 편균값을 구해서 반환
 -- 전체사원들의 급여 평균 구하기
 SELECT
        ROUND(AVG(SALARY))
   FROM
        EMPLOYEE;
 
 -- 3. MIN(ANY) : 해당 컬럼값들 중 작은 값 반환
 SELECT
        MIN(SALARY) "제일 작은 급여"
      , MIN(EMP_NAME) "제일 이름이 빠른 사람"
      , MIN(HIRE_DATE) "제일 빠른 입사일"
   FROM
        EMPLOYEE;
 
 -- 4. MAX(ANY) : 해당 컬럼값들 중 큰 값 반환
 SELECT
        MIN(SALARY) "제일 높은 급여"
      , MIN(EMP_NAME) "제일 이름이 늦은 사람"
      , MIN(HIRE_DATE) "제일 늦은 입사일"
   FROM
        EMPLOYEE;
 
 -- 5. COUNT(*/ 컬럼명 / DISTINCT 컬럼명) : 행 개수 세서 반환
 SELECT * FROM EMPLOYEE;
 -- COUNT(*) : 조회 결과에 해당하는 모든 행 개수를 다 세서 반환
 SELECT
        COUNT(*)
   FROM
        EMPLOYEE;

 --보너스를 받는 사원의 수
 -- COUNT(컬럼명) : 제시한 컬럼값이 NULL이라닌 행만 세서 반환
 SELECT
        COUNT(BONUS)
   FROM
        EMPLOYEE;
 
 SELECT
        COUNT(*)
   FROM
        EMPLOYEE
  WHERE
        BONUS IS NOT NULL;
 
 --현재 사원들이 속해있는 부서 개수
 -- COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복값이 존재할 경우 하나로만 세서 반환
 SELECT
        COUNT(DISTINCT DEPT_CODE)
   FROM
        EMPLOYEE;
 
 
 
 
 
 
 
 
 
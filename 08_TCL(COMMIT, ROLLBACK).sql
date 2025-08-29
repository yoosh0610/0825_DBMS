/*
 *  < TCL : TRANSACTION CONTROL LANGUAGE >
 * 			  트랜잭션 	  제어 	   언어
 * 
 * ☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
 * ☆★☆★☆★☆★☆★☆★☆★☆★ 생각이 필요한 개념 ★☆★☆★☆★☆★☆★☆★☆★☆★☆★
 * ☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
 * 
 *    TRANSACTION
 *  - 작업단위
 *  - 데이터베이스의 상태를 변화시키는 논리적인 연산단위
 *  - 여러개의 DML구문을 하나로 묶어 처리하는 매커니즘
 *  - 개발하는데 개발자가 하나로 묶여야하는 기능의 단위(정답X, 좋은 예제는O)
 *  - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 관리
 *  - COMMIT(확정)하기 전까지의 변동사항을 하나의 트랜잭션에 담게 됨
 *  - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE
 * 
 * * TRANSACTION의 4가지 속성
 * 
 * 	ACID
 * 
 * 1. Atomicity(원자성) : 트랜잭션 내의 모든 작업은 전부 수행되거나,
 * 						전혀 수행되지 않아야 한다.라는 원칙
 * 2. Consistency(일관성) : 트랜잭션이 성공적으로 완료 된 후에도
 * 						데이터베이스는 유효한 상태를 유지해야 한다.는 원칙
 *   			        (트랜잭션이 성공했는데 테이블이 깨지면 안된다, 제약조건이 깨지면 안된다)
 * 3. Isolation(고립성) : 동시에 실행되는 여러 트랜잭션이 상호간에 영향을 끼치지
 * 						않도록 하는 원칙
 * 4. Durablity(지속성) : 트랜잭션이 성공적으로 수행되었다면,
 * 						시스템에 문제가 발생하더라도 영구적으로 반영 되어야 한다.
 * 
 * COMMIT(트랙잭션을 종료 처리 후 확정) , ROLLBACK(트랙잭션 취소), SAVEPOINT
 */

CREATE TABLE EMP_COPY
	AS SELECT EMP_ID, EMP_NAME FROM EMPLOTEE;

SELECT * FROM EMP_COPY;
-- 사번이 900번인 사원 삭제
DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID = 900;

-- 사번이 222번인 사원 삭제
DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID = 222;

SELECT * FROM EMP_COPY;

DELETE 
  FROM 
       EMP_COPY;
-- 전부 다 삭제

ROLLBACK; --전부 살아남
-- 여러 DELETE를 담고 있는 TRANSACTION을 날려버림
-----------------------------------------------------------------------------
SELECT * FROM EMP_COPY; -- 트랙잭션 아직 안생김

DELETE FROM EMP_COPY WHERE EMP_ID = 900; -- 트랙잭션 생성

UPDATE EMP_COPY SET EMP_NAME = '고길동' WHERE EMP_NAME = '홍길동';

SELECT * FROM EMP_COPY;

COMMIT;-- 트랙잭션에 있는 작업을 확정(저장하고 트랙잭션을 종료)
ROLLBACK;
-----------------------------------------------------------------------------------
-- 사번이 214, 216번인 사원 삭제
DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID IN (214, 216);

-- 2개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT DELETE2ROWS; --저장포인트 지정

SELECT * FROM EMP_COPY;

DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID = 222;

ROLLBACK TO DELETE2ROWS; -- 저장포인트로 돌아감

SELECT * FROM EMP_COPY;
ROLLBACK;
------------------------------------------------------------------------------------
COMMIT;

DELETE FROM EMP_COPY WHERE EMP_ID = 222;

SELECT * FROM EMP_COPY;

CREATE TABLE HAHA(
	HID NUMBER
	);
-- 돌아오지 않음
-- COMMIT이 여기서 실행
ROLLBACK;
/*
 * DDL 구문(CREATE, ALTER, DROP)을 수행하는 순간
 * 트랜잭션에 있는 모든 작업사항을 무조건 COMMIT해서 실제 DB에 반영 한 후 DDL을 수행
 * --> DDL을 써야하는데 이젠 트랜잭션이 존재한다 ==> COMMIT / ROLLBACK 수행 수 처리
 * 
 */











































































































































































CREATE DATABASE rentcardb04;

USE rentcardb04;

CREATE TABLE rentcar(
	no INT,
    name VARCHAR(20),
    category INT,
    price INT,
    use_people INT,
    company VARCHAR(50),
    img VARCHAR(50),
    info VARCHAR(500)
);
DESC rentcar;

CREATE TABLE member(
	id VARCHAR(20),
    pw1 VARCHAR(20),
    email VARCHAR(50),
    tel VARCHAR(20),
    hobby VARCHAR(60),
    job VARCHAR(15),
    age INT,
    info VARCHAR(50)
);
DESC member; 

CREATE TABLE car_reserve(
	reserve_seq INT,
    no INT,
    id VARCHAR(50),
    qty INT,
    d_day INT,
    r_day VARCHAR(50),
    use_in INT,
    use_wifi INT,
    use_navi INT,
    use_seat INT
);
DESC car_reserve;

#-------------------------------------------------------------------------------
INSERT INTO member VALUES('qwer', '1234', 'qwer@naver.com', '010-2343-3453', '스포츠', '개발자', 28, '반갑습니다.');
INSERT INTO member VALUES('abcd', '1234', 'abcd@naver.com', '010-6523-1742', '독서', '배우', 42, '반갑습니다.');
SELECT * FROM member;

INSERT INTO rentcar VALUES (1, '아반테', 1,  2000, 4, '기아', '1.jpg' , '아반테 자동차 입니다.');
INSERT INTO rentcar VALUES (2, 'BMW', 3,  6000, 4, 'BMW', '2.jpg' , 'BMW 자동차 입니다.');
INSERT INTO rentcar VALUES (3, '카니발', 1,  4000, 7, '기아', '3.jpg' , '카니발 자동차 입니다.');
INSERT INTO rentcar VALUES (4, '카렌스', 2,  2500, 4, '기아', '4.jpg' , '카렌스 자동차 입니다.');
INSERT INTO rentcar VALUES (5, '코란도', 1,  3000, 4, '현대', '5.jpg' , '코란도 자동차 입니다.');
INSERT INTO rentcar VALUES (6, '에쿠스', 3,  6000, 4, 'BMW', '6.jpg' , '에쿠스 자동차 입니다.');
INSERT INTO rentcar VALUES (7, '제네시스', 1,  3000, 4, '기아', '7.jpg' , '제네시스 자동차 입니다.');
INSERT INTO rentcar VALUES (8, '그랜져', 1,  2400, 4, '현대', '8.jpg' , '그랜져 자동차 입니다.');
INSERT INTO rentcar VALUES (9, 'k3', 1,  2700, 4, '현대', '9.jpg' , 'k3 자동차 입니다.');
INSERT INTO rentcar VALUES (10, 'k5', 2,  5000, 4, '기아', '10.jpg' , 'k5 자동차 입니다.');
INSERT INTO rentcar VALUES (11, 'k9', 1,  6000, 4, '현대', '11.jpg' , 'k9 자동차 입니다.');
INSERT INTO rentcar VALUES (12, '라세티', 2,  2000, 5, '기아', '12.jpg' , '라세티 자동차 입니다.');
INSERT INTO rentcar VALUES (13, 'lf소나타', 1,  2000, 4, '현대', '13.jpg' , 'lf소나타 자동차 입니다.');
INSERT INTO rentcar VALUES (14, '말리부', 3,  2000, 4, 'BMW', '14.jpg' , '말리부 자동차 입니다.');
INSERT INTO rentcar VALUES (15, '모닝', 1,  23000, 4, '현대', '15.jpg' , '모닝 자동차 입니다.');
INSERT INTO rentcar VALUES (16, '올라도', 3,  5000, 4, 'BMW', '16.jpg' , '올라도 자동차 입니다.');
INSERT INTO rentcar VALUES (17, '레이', 2,  4000, 4, '현대', '17.jpg' , '레이 자동차 입니다.');
INSERT INTO rentcar VALUES (18, 'SM5', 1,  2700, 4, 'BMW', '18.jpg' , 'SM5 자동차 입니다.');
SELECT * FROM rentcar;

INSERT INTO car_reserve (reserve_seq, no, id, qty, d_day, r_day, use_in, use_wifi, use_navi, use_seat)
VALUES(1, 16, 'qwer', 1, 1, '2021-01-22', 1, 1, 1, 1);
INSERT INTO car_reserve (reserve_seq, no, id, qty, d_day, r_day, use_in, use_wifi, use_navi, use_seat)
VALUES(2, 17, 'abcd', 2, 7, '2021-01-19', 1, 1, 1, 2);
INSERT INTO car_reserve (reserve_seq, no, id, qty, d_day, r_day, use_in, use_wifi, use_navi, use_seat)
VALUES(3, 6, 'abcd', 1, 2, '2021-02-10', 1, 1, 1, 2);

SELECT * FROM car_reserve;

SELECT COUNT(*) FROM member WHERE id='qwer' AND pw1='1234';

SELECT * FROM rentcar ORDER BY no DESC;

SELECT * FROM rentcar WHERE no=15;

SELECT MAX(reserve_seq) FROM car_reserve;

SELECT * FROM rentcar WHERE category=2;

DELETE FROM car_reserve WHERE id='abcd' AND r_day='2021-01-19';

SELECT DATE_FORMAT(r_day, '%y-%m-%d') FROM car_reserve;

SELECT * FROM rentcar a2, car_reserve a1
WHERE a1.id='abcd' AND CURDATE() < r_day AND a1.no=a2.no;










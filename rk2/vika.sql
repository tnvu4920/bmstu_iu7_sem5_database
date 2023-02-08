������� 3
������� 1

create database rk2;

CREATE TABLE departament(
	did SERIAL PRIMARY KEY,
	name_dep VARCHAR NOT NULL,
	describe_dep VARCHAR NOT NULL
);

INSERT INTO departament(name_dep,describe_dep) values
('sm7', 'eng'),
('sm4', 'eng'),
('sm5', 'eng'),
('iu7', 'inf'),
('iu5', 'inf'),
('iu6', 'inf'),
('iu2', 'inf'),
('sm2', 'eng'),
('sm3', 'eng'),
('sm6', 'eng');

CREATE TABLE teacher(
	tid SERIAL PRIMARY KEY,
	departament_id INT, FOREIGN KEY (departament_id) REFERENCES departament(did) ON DELETE CASCADE,
	fio VARCHAR NOT NULL,
	degre INT NOT NULL,
	post VARCHAR NOT NULL
	--departament VARCHAR NOT NULL
);

INSERT INTO teacher(departament_id, fio,degre,post) values
(1,'teac1',2, 'assistent'),
(2,'teac2',4, 'assistent'),
(4,'teac3',8, 'laborant'),
(3,'teac4',4, 'assistent'),
(3,'teac5',3, 'laborant'),
(5,'teac6',2, 'assistent'),
(1,'teac7',1, 'assistent'),
(2,'teac8',5, 'zamdec'),
(4,'teac9',3, 'assistent'),
(1,'teac10',3, 'naycruk');

CREATE TABLE subject(
	sid SERIAL PRIMARY KEY,
	name_sub VARCHAR NOT NULL,
	hours INT NOT NULL,
	semester INT NOT NULL,
	raiting FLOAT NOT NULL
);

INSERT INTO subject(name_sub, hours,semester,raiting) values
('Prog',72,1,3),
('Python',32,1,9),
('C++',56,4, 2.1),
('C',72,2,5),
('Math',72,1, 4.5),
('OS',100,5, 10),
('DB',72,5,9),
('TISD',32,3,5.3),
('AA',40,5,6),
('KG',72,4, 5);

CREATE TABLE subject_teachers(
	tid INT,FOREIGN KEY (tid) REFERENCES teacher(tid) ON DELETE CASCADE,
	sid INT,FOREIGN KEY (sid) REFERENCES subject(sid) ON DELETE CASCADE
);

INSERT INTO subject_teachers(tid, sid) values
(1, 3),
(2, 6),
(4, 5),
(7, 1),
(6, 2),
(5, 1),
(10, 9),
(9, 1),
(8, 2),
(9, 10);

������� 2

1.�������� ��������� � ������� ���������� ����� ������ ��� � ���� ��������� 4 ��������

select name_sub, hours
from subject
where hours < all(
	select hours
	from subject
	where semester = 4
);

2. ������� ���������� ����� ���� ���������
select avg(hours) as "avg hours",
sum(hours)/count(*) as "calc"
from subject;

3.������� �������������� ���������� ��

create temp table smteachers as
select T.fio, D.name_dep from teacher T  join departament D on D.did = T.departament_id
where D.name_dep like '%sm%';


������� 3
create or replace procedure get_ind(tname Varchar)
as $$
	declare
		a int;
		curRow record;
		tblCurs refcursor;
begin
	open tblCurs FOR
		EXECUTE 'Select indexname FROM pg_indexes WHERE tablename =' || tname;
		LOOP
			FETCH tblCurs INTO curRow;
			EXIT WHEN NOT FOUND;

			RAISE NOTICE '%', curRow.indexname;
		END LOOP;
		CLOSE tblCurs;
end;
$$ LANGUAGE PLpgSQL;

CALL get_ind('teacher');
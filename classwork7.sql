CREATE DATABASE UDB;
USE UDB;

CREATE TABLE classroom (
    building VARCHAR(15),
    room_number VARCHAR(7),
    capacity NUMERIC(4, 0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name VARCHAR(20),
    building VARCHAR(15),
    budget NUMERIC(12, 2) CHECK (budget > 0),
    PRIMARY KEY (dept_name)
);

CREATE TABLE course (
    course_id VARCHAR(8),
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2, 0) CHECK (credits > 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);


CREATE TABLE instructor (
    ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8, 2) CHECK (salary > 29000),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);

CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
    year NUMERIC(4, 0) CHECK (year > 1701 AND year < 2100),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number) ON DELETE SET NULL
);

CREATE TABLE teaches (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4, 0),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES instructor(ID) ON DELETE CASCADE
);

CREATE TABLE student (
    ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3, 0) CHECK (tot_cred >= 0),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);

CREATE TABLE takes (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4, 0),
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES student(ID) ON DELETE CASCADE
);

CREATE TABLE advisor (
    s_ID VARCHAR(5),
    i_ID VARCHAR(5),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (i_ID) REFERENCES instructor(ID) ON DELETE SET NULL,
    FOREIGN KEY (s_ID) REFERENCES student(ID) ON DELETE CASCADE
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(4),
    day VARCHAR(1),
    start_hr NUMERIC(2) CHECK (start_hr >= 0 AND start_hr < 24),
    start_min NUMERIC(2) CHECK (start_min >= 0 AND start_min < 60),
    end_hr NUMERIC(2) CHECK (end_hr >= 0 AND end_hr < 24),
    end_min NUMERIC(2) CHECK (end_min >= 0 AND end_min < 60),
    PRIMARY KEY (time_slot_id, day, start_hr, start_min)
);

CREATE TABLE prereq (
    course_id VARCHAR(8),
    prereq_id VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);

INSERT INTO classroom VALUES 
('Packard', '101', 500),
('Painter', '514', 10),
('Taylor', '3128', 40),
('Watson', '100', 30),
('Watson', '120', 50),
('Painter', '117', 20),
('Taylor', '3122', 45),
('Watson', '015', 35),
('Packard', '201', 60),
('Watson', '321', 25);


INSERT INTO department VALUES 
('Biology', 'Watson', 90000),
('Comp. Sci.', 'Taylor', 100000),
('Elec. Eng.', 'Taylor', 85000),
('Finance', 'Painter', 120000),
('History', 'Watson', 45000),
('Music', 'Packard', 80000),
('Physics', 'Watson', 70000),
('Chemistry', 'Watson', 75000);


INSERT INTO course VALUES 
('BIO-101', 'Intro. to Biology', 'Biology', 4),
('BIO-301', 'Genetics', 'Biology', 4),
('BIO-399', 'Computational Biology', 'Biology', 3),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
('CS-190', 'Game Design', 'Comp. Sci.', 3),
('CS-315', 'Robotics', 'Comp. Sci.', 3),
('CS-319', 'Image Processing', 'Comp. Sci.', 3),
('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
('FIN-201', 'Investment Banking', 'Finance', 3),
('MUS-101', 'Introduction to Music', 'Music', 3);


INSERT INTO instructor VALUES 
('10101', 'Srinivasan', 'Comp. Sci.', 65000),
('12121', 'Wu', 'Finance', 90000),
('15151', 'Mozart', 'Music', 40000), -- Mozart in Music department
('22222', 'Einstein', 'Physics', 95000),
('32343', 'El Said', 'History', 60000),
('34567', 'Gold', 'Physics', 87000),
('45565', 'Katz', 'Comp. Sci.', 75000),
('58583', 'Califieri', 'History', 62000),
('76543', 'Singh', 'Finance', 80000),
('76766', 'Crick', 'Biology', 72000),
('10211', 'Smith', 'Biology', 66000),
('10321', 'Doe', 'Biology', 62000),
('10431', 'Clark', 'Comp. Sci.', 63000),
('10541', 'Adams', 'Finance', 67000),
('10651', 'Jones', 'Comp. Sci.', 64000),
('10761', 'Kim', 'Music', 68000),
('10871', 'Lee', 'Physics', 71000),
('10981', 'White', 'Elec. Eng.', 72000),
('11091', 'Brown', 'History', 69000),
('11111', 'Newton', 'Physics', NULL),
('11112', 'Curie', 'Chemistry', NULL);


INSERT INTO section VALUES 
('BIO-101', '1', 'Summer', 2009, 'Painter', '514', 'A'),
('BIO-301', '1', 'Spring', 2010, 'Packard', '101', 'B'),
('BIO-399', '1', 'Winter', 2010, 'Taylor', '3128', 'C'),
('CS-101', '1', 'Fall', 2009, 'Taylor', '3128', 'D'),
('CS-190', '1', 'Spring', 2009, 'Watson', '100', 'E'),
('CS-315', '1', 'Summer', 2010, 'Watson', '100', 'F'),
('CS-319', '1', 'Spring', 2009, 'Watson', '120', 'G'),
('CS-347', '1', 'Winter', 2009, 'Watson', '100', 'H'),
('EE-181', '1', 'Spring', 2010, 'Watson', '321', 'I'),
('FIN-201', '1', 'Winter', 2009, 'Painter', '117', 'J'),
('MUS-101', '1', 'Fall', 2010, 'Packard', '101', 'K'),
('BIO-101', '2', 'Fall', 2009, 'Packard', '101', 'A'),
('BIO-101', '3', 'Spring', 2010, 'Packard', '101', 'B'),
('CS-101', '2', 'Fall', 2009, 'Taylor', '3128', 'D'),
('CS-101', '3', 'Spring', 2010, 'Taylor', '3128', 'E'),
('FIN-201', '2', 'Fall', 2009, 'Painter', '514', 'F'),
('FIN-201', '3', 'Spring', 2010, 'Painter', '514', 'G'),
('BIO-301', '2', 'Spring', 2010, 'Packard', '101', 'H'),
('CS-319', '2', 'Fall', 2009, 'Watson', '120', 'I');


INSERT INTO teaches VALUES 
('10101', 'BIO-101', '1', 'Summer', 2009),
('10211', 'BIO-301', '1', 'Spring', 2010),
('10321', 'BIO-399', '1', 'Winter', 2010),
('10431', 'CS-101', '1', 'Fall', 2009),
('10541', 'CS-190', '1', 'Spring', 2009),
('10651', 'CS-315', '1', 'Summer', 2010),
('10761', 'CS-319', '1', 'Spring', 2009),
('10871', 'CS-347', '1', 'Winter', 2009),
('10981', 'EE-181', '1', 'Spring', 2010),
('11091', 'FIN-201', '1', 'Winter', 2009),
('15151', 'CS-101', '1', 'Fall', 2009), -- Mozart teaching a Comp. Sci. course
('15151', 'MUS-101', '1', 'Fall', 2010); -- Mozart teaching a Music course

INSERT INTO student VALUES 
('50000', 'Thompson', 'Biology', 12),
('51000', 'Zhou', 'Comp. Sci.', 28),
('52000', 'Brandt', 'Comp. Sci.', 32),
('53000', 'Lyon', 'History', 10),
('54000', 'Sadowsky', 'Finance', 20),
('55000', 'Shankar', 'Finance', 45),
('56000', 'Williams', 'Music', 14),
('57000', 'Dillon', 'Physics', 18),
('58000', 'Bourne', 'Physics', 24),
('59000', 'Rogers', 'Biology', 18),
('60000', 'Nguyen', 'Comp. Sci.', 30),
('61000', 'Smith', 'Physics', 22),
('62000', 'Ahmed', 'History', 12),
('63000', 'Clark', 'Music', 10),
('64000', 'Lewis', 'Finance', 25),
('65000', 'Hall', 'Biology', 18),
('66000', 'Wright', 'Elec. Eng.', 20),
('67000', 'King', 'Comp. Sci.', 40),
('68000', 'Green', 'History', 15),
('69000', 'Baker', 'Physics',12);

INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES
('50000', 'CS-101', '1', 'Fall', 2009, 'A'),
('51000', 'BIO-101', '2', 'Fall', 2009, 'B'),
('52000', 'CS-319', '1', 'Spring', 2009, 'C'),
('53000', 'FIN-201', '1', 'Winter', 2009, 'B'),
('54000', 'CS-190', '1', 'Spring', 2009, 'A'),
('55000', 'MUS-101', '1', 'Fall', 2010, 'C'),
('56000', 'BIO-301', '1', 'Spring', 2010, 'B'),
('57000', 'EE-181', '1', 'Spring', 2010, 'A'),
('58000', 'CS-347', '1', 'Winter', 2009, 'B'),
('59000', 'BIO-399', '1', 'Winter', 2010, 'A');




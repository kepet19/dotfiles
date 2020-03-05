CREATE TABLE Rooms (
	room_number VARCHAR (50) UNIQUE NOT NULL PRIMARY KEY,
	room_type VARCHAR (50) NOT NULL
);
INSERT INTO Rooms (room_number ,room_type)
VALUES ('R2','Normal'),
('R4','Two Bed'),
('R5','Special'),
('R6','Special');
SELECT * FROM Rooms;

CREATE TABLE Doctors (
	doctor_number serial PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	room_adress VARCHAR (50) NOT NULL,
	phone integer NOT NULL,
	department_id VARCHAR (50) NOT NULL,
	designation VARCHAR (50) NOT NULL,
	charge_pr_hour integer NOT NULL
);
INSERT INTO Doctors (name, room_adress, phone, department_id, designation, charge_pr_hour) 
VALUES ('Dr. Peterson', 'U45', 12341234, 'Neurology', 'Professor', 5000), 
('Dr. Jensen', 'U32', 24352435, 'Orthopedic', 'Professor', 5000),
('Dr. Poetch', 'U186', 34563456, 'ENT/Neurology', 'Assistant Professor', 3000),
('Dr. Neurenheim', 'U150', 45674567, 'Skin/Orthepoedic', 'Assistant Professor', 3000);

SELECT * FROM Doctors;

CREATE TABLE doctor_patians (
	doctor_number integer NOT NULL REFERENCES Doctors(doctor_number),
	patient_number integer NOT NULL REFERENCES Patients(patient_number)
);
INSERT INTO doctor_patians(doctor_number, patient_number)
VALUES(1 ,1 ),
(1 ,2 ),
(1 ,3 ),
(2 ,3 ),
(2 ,4 ),
(2 ,5 ),
(3 ,1 ),
(3 ,6 ),
(4 ,7 ),
(4 ,8 );
SELECT * FROM doctor_patians;

CREATE TABLE Patients (
	patient_number serial PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	CPR_number VARCHAR (50) NOT NULL,
	phone integer NOT NULL
);
INSERT INTO Patients (name, last_name, CPR_number, phone)
VALUES ('Jan','K', 	'190582-1113', 98769876),
('Peter','K',		'300175-2359', 87658765),
('Jens','K', 		'041298-1257', 76547654),
('Ole','K', 		'051165-9863', 65436543),
('Anna','K', 		'260792-1050', 54325432),
('Dennis','K', 		'041298-1257', 43214321),
('Ahmed','K', 		'041298-1257', 32103210),
('Annika','K', 		'041298-1257', 21092109);
SELECT * FROM Patients;


CREATE TABLE beds (
	bed_number VARCHAR (50) NOT NULL,
	room_number VARCHAR (50) NOT NULL REFERENCES Rooms(Room_number), 
	patient_number integer NOT NULL REFERENCES Patients(patient_number)
);

INSERT INTO beds (bed_number, room_number, patient_number)
VALUES('B1', 'R2' , 1 ),
('B1', 'R2' , 2 ),
('B1', 'R2' , 4 ),
('B5', 'R4' , 3 ),
('B5', 'R4' , 5 ),
('B8', 'R5' , 1 ),
('B9', 'R6' , 8 );
SELECT * FROM beds;


CREATE VIEW MyCustomView AS
	patients.patient_number, name, cpr_number, phone, bed_number, room_number FROM patients, beds
	WHERE patients.patient_number = beds.patient_number;

SELECT * FROM MyCustomView;

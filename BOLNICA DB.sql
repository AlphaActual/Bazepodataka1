-- --------------------MARIJA-------------------- --
DROP DATABASE IF EXISTS bolnica;
CREATE DATABASE bolnica;
USE bolnica;

CREATE TABLE odjel
(id INTEGER PRIMARY KEY,
naziv VARCHAR (20) NOT NULL UNIQUE,
kat INTEGER NOT NULL,
broj_soba INTEGER NOT NULL
);
CREATE TABLE doktor (
id INTEGER PRIMARY KEY,
ime VARCHAR (20) NOT NULL,
prezime VARCHAR (20) NOT NULL,
datum_rođenja DATE NOT NULL,
id_odjel INTEGER NOT NULL,
FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);
CREATE TABLE sos_kontakt (
id INTEGER PRIMARY KEY,
ime VARCHAR (20) NOT NULL,
prezime VARCHAR (20) NOT NULL,
broj_telefona VARCHAR (15) NOT NULL UNIQUE
);

-- ----------------------NOEL--------------------- --
--id-jevi 400-500,500-600,600-700


-- ----------------------TIN--------------------- --


CREATE TABLE soba (
id INTEGER PRIMARY KEY,
broj_sobe INTEGER NOT NULL,
broj_kreveta INTEGER NOT NULL,
stanje VARCHAR (20) NOT NULL,
id_odjel INTEGER NOT NULL,
FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);

CREATE TABLE lijek (
id INTEGER PRIMARY KEY,
vrsta VARCHAR (20) NOT NULL,
proizvodac VARCHAR (20) NOT NULL,
naziv VARCHAR (20) NOT NULL,
količina INTEGER NOT NULL,
rok_valjanosti DATE NOT NULL

);

CREATE TABLE terapija (
id INTEGER PRIMARY KEY,
id_pacijent INTEGER NOT NULL,
id_lijek INTEGER NOT NULL,
FOREIGN KEY (id_pacijent) REFERENCES pacijent (id),
FOREIGN KEY (id_lijek) REFERENCES lijek (id)
);


-- ---POPUNJAVANJE TABLICA: odjel, doktor, sos_kontakt--- --

-- id od 100 do 200
INSERT INTO odjel VALUES
(100, 'Kardiologija', 4, 5),
(101, 'Intenzivno liječenje', 5, 12),
(102, 'Ortopedija', 3, 8),
(103, 'Pedijatrija', 1, 17),
(104, 'Oftalmologija', 2, 5);
-- id od 200 do 300
INSERT INTO doktor VALUES 
(200, 'Krešimira', 'Paspalj', STR_TO_DATE('11.01.1978.','%d.%m.%Y.'), 102),
(201, 'Noris', 'Grubor', STR_TO_DATE('03.05.1982.','%d.%m.%Y.'), 104),
(202, 'Šime', 'Ljubić', STR_TO_DATE('09.12.1973.','%d.%m.%Y.'), 103),
(203, 'Jasmina', 'Mejak', STR_TO_DATE('03.06.1985.','%d.%m.%Y.'), 101),
(204, 'Mauro', 'Tomasov', STR_TO_DATE('24.07.1970.','%d.%m.%Y.'), 100),
(205, 'Jan', 'Nikolić', STR_TO_DATE('22.08.1962.','%d.%m.%Y.'), 100),
(206, 'Gabrijel', 'Popović', STR_TO_DATE('01.05.1976.','%d.%m.%Y.'), 101),
(207, 'Božidarka', 'Obad', STR_TO_DATE('03.06.1990.','%d.%m.%Y.'), 103),
(208, 'Jelena', 'Debeljak', STR_TO_DATE('28.03.1988.','%d.%m.%Y.'), 102),
(209, 'Rudolf', 'Kolar', STR_TO_DATE('16.09.1967.','%d.%m.%Y.'), 101);
-- id od 300 do 400
INSERT INTO sos_kontakt VALUES
(300, 'Zora', 'Kunstl', '0997314087'),
(301,'Stanko', 'Sutarić', '0916813627'),
(302, 'Issa', 'Biševac', '0929430314'),
(303, 'Elenora', 'Delfar', '0957923190'),
(304, 'Aden', 'Kotolaš', '0997871285'),
(305, 'Vojmil', 'Novaković', '0990409583'),
(306, 'Ljubica', 'Topić', '0970504540'),
(307, 'Alan', 'Bačić', '0910584947'),
(308, 'Silvana', 'Cindrić', '0990403030'),
(309, 'Vilim', 'Kovačević', '0910178482'),
(310, 'Ranka', 'Marković', '0920470333'),
(311, 'Draženka', 'Čerkez', '0970196705'),
(312, 'Senka', 'Jelić', '0970196856'),
(313, 'Matej', 'Herceg', '0910133420'),
(314, 'Melita', 'Petrović', '0920330135'),
(315, 'Renata', 'Lončar', '0998925648'),
(316, 'Marica', 'Kovać', '0992020998'),
(317, 'Tomica', 'Radić', '0912661128'),
(318, 'Dragica', 'Marušić', '0972680286'),
(319, 'Lucija', 'Anić', '0992681124');



-- ---POPUNJAVANJE TABLICA: soba, lijek, terapija--- --

-- id od 700 do 800
INSERT INTO soba VALUES

-- sobe odjel 100
(700, 001, 6,'slobodno', 100),
(701, 002, 6,'popunjeno', 100),
(702, 003, 6,'popunjeno', 100),
(703, 004, 6,'nedostupno', 100),
(704, 005, 6,'slobodno', 100),

-- sobe odjel 101
(705, 006, 3,'slobodno', 101),
(706, 007, 3,'slobodno', 101),
(707, 008, 3,'popunjeno', 101),
(708, 009, 3,'slobodno', 101),
(709, 010, 3,'popunjeno', 101),
(710, 011, 5,'slobodno', 101),
(711, 012, 5,'slobodno', 101),
(712, 013, 6,'slobodno', 101),
(713, 014, 6,'nedostupno', 101),
(714, 015, 4,'nedostupno', 101),
(715, 016, 5,'slobodno', 101),
(716, 017, 5,'slobodno', 101),

-- sobe odjel 102
(717, 018, 5,'popunjeno', 102),
(718, 019, 5,'popunjeno', 102),
(719, 020, 5,'slobodno', 102),
(720, 021, 5,'slobodno', 102),
(721, 022, 6,'popunjeno', 102),
(722, 023, 6,'slobodno', 102),
(723, 024, 6,'popunjeno', 102),
(724, 025, 4,'nedostupno', 102),

-- sobe odjel 103

(725, 026, 3,'slobodno', 103),
(726, 027, 3,'slobodno', 103),
(727, 028, 4,'popunjeno', 103),
(728, 029, 3,'slobodno', 103),
(729, 030, 3,'popunjeno', 103),
(730, 031, 5,'slobodno', 103),
(731, 032, 5,'slobodno', 103),
(732, 033, 6,'slobodno', 103),
(733, 034, 6,'nedostupno', 103),
(734, 035, 4,'nedostupno', 103),
(735, 036, 3,'nedostupno', 103),
(736, 037, 5,'slobodno', 103),
(737, 038, 3,'slobodno', 103),
(738, 039, 3,'popunjeno', 103),
(739, 040, 1,'nedostupno', 103),
(740, 041, 5,'slobodno', 103),
(741, 042, 6,'slobodno', 103),

-- sobe odjel 104

(742, 043, 3,'slobodno', 104),
(743, 044, 6,'slobodno', 104),
(744, 045, 6,'slobodno', 104),
(745, 046, 4,'popunjeno', 104),
(746, 047, 3,'slobodno', 104);

-- id od 800 do 900
INSERT INTO lijek VALUES
(800, 'Anelgetik', 'Bayer', 'Aspirin', 503, STR_TO_DATE('22.08.2024.','%d.%m.%Y.'),
(801, 'Anelgetik', 'Bayer', 'Aspirin', 104, STR_TO_DATE('20.03.2022.','%d.%m.%Y.'),
(802, 'Anelgetik', 'Alexion', 'Morfin', 1372, STR_TO_DATE('17.09.2024.','%d.%m.%Y.');
--WORK IN PROGRESS

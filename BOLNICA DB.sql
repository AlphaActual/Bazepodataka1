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

CREATE TABLE pacijent(
id INTEGER PRIMARY KEY,
ime VARCHAR(20) NOT NULL,
prezime VARCHAR(30) NOT NULL,
datum_rodenja DATETIME NOT NULL,
adresa VARCHAR (40) NOT NULL,
spol CHAR (1) NOT NULL,
broj_telefona VARCHAR (20) NOT NULL UNIQUE,
MBO VARCHAR (20) NOT NULL UNIQUE,
id_sos_kontakt INTEGER NOT NULL,
FOREIGN KEY (id_sos_kontakt) REFERENCES sos_kontakt (id)
);

CREATE TABLE medicinske_sestre(
id INTEGER PRIMARY KEY,
ime VARCHAR (20) NOT NULL,
prezime VARCHAR (30) NOT NULL,
datum_rodenja DATETIME NOT NULL,
id_odjel INTEGER NOT NULL,
FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);

CREATE TABLE dijagnoza(
id INTEGER PRIMARY KEY,
sifra VARCHAR (20) NOT NULL UNIQUE,
naziv VARCHAR (20) NOT NULL UNIQUE
);

-- ----------------------NEVEN---------------------- --
/*  možda da imamo novu relaciju posjetitelj(id, ime, prezime, broj telefona...) pa da u posjetama se ne ponavlja ime, prezime
u slučaju da imamo istog posjetitelja više puta */

CREATE TABLE prijem(
id INTEGER PRIMARY KEY,
datum_prijema DATE NOT NULL,
id_pacijent INTEGER NOT NULL,
id_medicinska_sestra INTEGER NOT NULL,
id_doktor INTEGER NOT NULL,
id_dijagnoza INTEGER NOT NULL,
id_odjel INTEGER NOT NULL,
id_soba INTEGER NOT NULL,
FOREIGN KEY (id_pacijent) REFERENCES pacijent(id),
FOREIGN KEY (id_medicinska_sestra) REFERENCES medicinska_sestra(id),
FOREIGN KEY (id_doktor) REFERENCES doktor (id),
FOREIGN KEY (id_dijagnoza) REFERENCES dijagnoza(id),
FOREIGN KEY (id_odjel) REFERENCES odjel(id),
FOREIGN KEY (id_soba) REFERENCES soba(id)
 );
 
 CREATE TABLE posjeta(
 id INTEGER PRIMARY KEY,
 ime VARCHAR(20) NOT NULL,
 prezime VARCHAR(20) NOT NULL,
 temperatura NUMERIC(2,1) NOT NULL,
 datum DATE NOT NULL,
 vrijeme_dolaska TIME NOT NULL,
 vrijeme_odlaska TIME NOT NULL
 );
 
 CREATE TABLE raspored_opreme(
 id INTEGER PRIMARY KEY,
 sifra VARCHAR(10) NOT NULL UNIQUE,
 naziv VARCHAR(20) NOT NULL,
 datum_zaprimanja DATE NOT NULL,
 datum_otpisa DATE,
 kolicina INTEGER NOT NULL,
 id_soba INTEGER NOT NULL,
 FOREIGN KEY (id_soba) REFERENCES soba(id)
  );

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
);

CREATE TABLE stanje_lijekova (
id INTEGER PRIMARY KEY,
id_lijek INTEGER NOT NULL,
količina INTEGER NOT NULL,
rok_valjanosti DATE NOT NULL
FOREIGN KEY (id_lijek) REFERENCES lijek (id),
);

CREATE TABLE terapija (
id INTEGER PRIMARY KEY,
id_pacijent INTEGER NOT NULL,
id_lijek INTEGER NOT NULL,
uporaba TEXT
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

-- ---POPUNJAVANJE TABLICA: pacijent, medicinska_setra, dijagnoza--- --
-- id od 400 do 500
INSERT INTO pacijent VALUES 
(400, 'Alen', 'Kolić', STR_TO_DATE('17.08.1991.','%d.%m.%Y.'), 'Benešićeva ulica 23', 'M', '0997863487', '94567894', 300),
(401, 'Ivan', 'Rupčić', STR_TO_DATE('23.02.1962.','%d.%m.%Y.'), 'Zavrtnica 17', 'M', '0916813627', '82631549', 301),
(402, 'Lissa', 'Ivić', STR_TO_DATE('07.10.2012.','%d.%m.%Y.'), 'Put Duilova 11', 'Ž', '0929430314', '47395186', 302),
(403, 'Klara', 'Zenzerović', STR_TO_DATE('25.05.1998.','%d.%m.%Y.'), 'Ante Starčevića 23', 'Ž', '0957923190', '82641357', 303),
(404, 'Sebastijan', 'Milošević', STR_TO_DATE('18.11.1969.','%d.%m.%Y.'), 'Trg kralja Tomislava 15', 'M', '0954359871', '87645123', 304),
(405, 'Lucas', 'Perić', STR_TO_DATE('14.03.1976.','%d.%m.%Y.'), 'Franje Iskre 13', 'M', '0951893256', '854679137', 305),
(406, 'Paola', 'Marić', STR_TO_DATE('15.02.1979.','%d.%m.%Y.'), 'Valturska ulica 17', 'Ž', '098754236', '31675167', 306),
(407, 'Ema', 'Knežević', STR_TO_DATE('24.10.1995.','%d.%m.%Y.'), 'Busoler 18', 'Ž', '0957135987', '24578946', 307),
(408, 'Tomi', 'Ivković', STR_TO_DATE('28.07.1978.','%d.%m.%Y.'), 'Šijanska cesta 85', 'M', '0951359744', '48751677', 308),
(409, 'Stefan', 'Markulinčić', STR_TO_DATE('21.10.1978.','%d.%m.%Y.'), 'Mandićeva ulica 15', 'M', '0923697415', '19874537', 309),
(410, 'Mia', 'Stepančić', STR_TO_DATE('17.06.1985.','%d.%m.%Y.'), 'Ulica Valica3', 'Ž', '091569874', '76894578', 310),
(411, 'Bruno', 'Marušić', STR_TO_DATE('29.02.1984.','%d.%m.%Y.'), 'Labinska ulica 68', 'M', '0958794651', '87451963', 311),
(412, 'Iris', 'Orbanić', STR_TO_DATE('19.09.1998.','%d.%m.%Y.'), 'Kolodvorska ulica 58', 'Ž', '0957896542', '84532157', 312),
(413, 'Nora', 'Marjanović', STR_TO_DATE('12.12.1921.','%d.%m.%Y.'), 'Kandlerova ulica 88', 'Ž', '0953698521', '82648965', 313),
(414, 'Borna', 'Karlović', STR_TO_DATE('31.01.1965.','%d.%m.%Y.'), 'Ulica Castropola', 'M', '0957894561', '82487563', 314),
(415, 'Oliver', 'Kinić', STR_TO_DATE('23.02.1999.','%d.%m.%Y.'), 'Flaciusova ulica 12', 'M', '0953754232', '87865147', 315),
(416, 'Toni', 'Belić', STR_TO_DATE('25.12.1976.','%d.%m.%Y.'), 'Trščanska ulica 14', 'M', '0954235785', '78965478', 316),
(417, 'Petar', 'Dragojević', STR_TO_DATE('03.04.1978.','%d.%m.%Y.'), 'Ulica Trsine 45', 'M', '0957563219', '65498732', 317),
(418, 'Boris', 'Vlašić', STR_TO_DATE('28.07.1984.','%d.%m.%Y.'), 'Puljska cesta 19', 'M', '092548796', '815687459', 318),
(419, 'Matija', 'Mladenović', STR_TO_DATE('13.08.1997.','%d.%m.%Y.'), 'Miševečka ulica 4', 'M', '0918964756', '81587459', 319);

-- id od 500 do 600
INSERT INTO medicinske_sestre VALUES 
(500, 'Ivana', 'Ivić',STR_TO_DATE('11.02.1992','%d.%m.%Y.'), 100),
(501, 'Miliana', 'Milić',STR_TO_DATE('11.02.1999','%d.%m.%Y.'), 101),
(502, 'Ivana','Marić',STR_TO_DATE('01.02.1998','%d.%m.%Y.'), 102),
(503, 'Marko', 'Marulić',STR_TO_DATE('13.03.2000','%d.%m.%Y.'), 103),
(504, 'Žarka', 'Stanić', STR_TO_DATE('05.02.1992','%d.%m.%Y.'), 104);	

-- id od 600 do 700
/* provjeriti sifre i nazive dijagnoze da imaju veze s odjelima na kojima se lijece */
INSERT INTO dijagnoza VALUES
(600, 'nesto' , 'nesto'), 
(601, 'nesto' , 'nesto'),
(602, 'nesto' , 'nesto'),
(603, 'nesto' , 'nesto');  
(604, 'nesto' , 'nesto'),

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
(800, 'Anelgetik', 'Bayer', 'Aspirin'),
(801, 'Anelgetik', 'Alexion', 'Morfin'),
(802, 'Anelgetik', 'Baxter', 'Naproxen'),
(803, 'Anelgetik', 'Chemnovatic', 'Nefopam'),
(804, 'Anelgetik', 'Chemnovatic', 'Ketamine'),

(805, 'Antiaritmik', 'Baxter', 'Bisoprolol'),
(806, 'Antiaritmik', 'Alexion', 'Atenolol'),
(807, 'Antiaritmik', 'Ethypharm', 'Digoxin'),
(808, 'Antiaritmik', 'Chemnovatic', 'Adenosine'),
(809, 'Antiaritmik', 'Alexion', 'Diltiazem'),

(810, 'Antibiotik', 'Bayer', 'Amoxicillin'),
(811, 'Antibiotik', 'Bayer', 'Flucloxacillin'),
(812, 'Antibiotik', 'Bayer', 'Meropenem'),
(813, 'Antibiotik', 'Alexion', 'Vancomycin'),
(814, 'Antibiotik', 'Alexion', 'Gentamycin'),
(815, 'Antibiotik', 'Ethypharm', 'Clarithromycin'),
(816, 'Antibiotik', 'Ethypharm', 'Doxycycline'),

(817, 'Antikoagulans', 'Chemnovatic', 'Warfarin'),
(818, 'Antikoagulans', 'Ethypharm', 'Rivaroxaban'),
(819, 'Antikoagulans', 'Ethypharm', 'Enoxaparin'),
(820, 'Antikoagulans', 'Alexion', 'Heparin'),

(821, 'Sedativ', 'Baxter', 'Zopiclone'),
(822, 'Sedativ', 'Ethypharm', 'Haloperidol'),
(823, 'Sedativ', 'Ethypharm', 'Midazolam'),

(824, 'Antiemetik', 'Chemnovatic', 'Cyclizine'),
(825, 'Antiemetik', 'Chemnovatic', 'Ondansetron'),
(826, 'Antiemetik', 'Chemnovatic', 'Metoclopramide');

-- id od 900 do 1000
INSERT INTO stanje_lijekova VALUES
(900, 800, 503, STR_TO_DATE('22.08.2024.','%d.%m.%Y.')),
(901, 800, 104, STR_TO_DATE('20.03.2022.','%d.%m.%Y.')),
(902, 801, 1372, STR_TO_DATE('17.09.2024.','%d.%m.%Y.')),
(903, 802, 642, STR_TO_DATE('01.10.2023.','%d.%m.%Y.')),
(904, 803, 216, STR_TO_DATE('12.07.2025.','%d.%m.%Y.')),
(905, 804, 1201, STR_TO_DATE('15.09.2022.','%d.%m.%Y.')),

(906, 805, 610, STR_TO_DATE('16.02.2023.','%d.%m.%Y.')),
(907, 805, 102, STR_TO_DATE('12.02.2022.','%d.%m.%Y.')),
(908, 806, 517, STR_TO_DATE('18.06.2025.','%d.%m.%Y.')),
(909, 806, 54, STR_TO_DATE('18.05.2022.','%d.%m.%Y.')),
(910, 807, 354, STR_TO_DATE('16.07.2026.','%d.%m.%Y.')),
(911, 807, 32, STR_TO_DATE('10.08.2021.','%d.%m.%Y.')),
(912, 808, 725, STR_TO_DATE('01.10.2025.','%d.%m.%Y.')),
(913, 808, 478, STR_TO_DATE('21.11.2024.','%d.%m.%Y.')),
(914, 809, 1078, STR_TO_DATE('11.11.2025.','%d.%m.%Y.')),
(915, 809, 234, STR_TO_DATE('14.10.2023.','%d.%m.%Y.')),

(916, 810, 2146, STR_TO_DATE('01.12.2026.','%d.%m.%Y.')),
(917, 811, 1560, STR_TO_DATE('02.09.2024.','%d.%m.%Y.')),
(918, 812, 8756, STR_TO_DATE('02.07.2022.','%d.%m.%Y.')),
(919, 813, 312, STR_TO_DATE('12.04.2023.','%d.%m.%Y.')),
(920, 814, 890, STR_TO_DATE('07.09.2022.','%d.%m.%Y.')),
(921, 814, 101, STR_TO_DATE('03.09.2021.','%d.%m.%Y.')),
(922, 815, 531, STR_TO_DATE('12.12.2023.','%d.%m.%Y.')),
(923, 816, 320, STR_TO_DATE('03.07.2024.','%d.%m.%Y.')),

(924, 817, 753, STR_TO_DATE('16.07.2026.','%d.%m.%Y.')),
(925, 818, 980, STR_TO_DATE('22.03.2023.','%d.%m.%Y.')),
(926, 819, 340, STR_TO_DATE('22.06.2024.','%d.%m.%Y.')),
(927, 820, 650, STR_TO_DATE('10.09.2022.','%d.%m.%Y.')),

(928, 821, 214, STR_TO_DATE('05.10.2023.','%d.%m.%Y.')),
(929, 822, 456, STR_TO_DATE('05.12.2026.','%d.%m.%Y.')),
(930, 822, 356, STR_TO_DATE('05.07.2022.','%d.%m.%Y.')),
(931, 823, 760, STR_TO_DATE('04.09.2024.','%d.%m.%Y.')),

(932, 824, 630, STR_TO_DATE('07.10.2022.','%d.%m.%Y.')),
(933, 825, 120, STR_TO_DATE('03.06.2024.','%d.%m.%Y.')),
(934, 825, 236, STR_TO_DATE('03.08.2026.','%d.%m.%Y.')),
(935, 826, 601, STR_TO_DATE('02.04.2025.','%d.%m.%Y.'));

-- id od 1000 do 1100
INSERT INTO terapija VALUES
(1000,400,812, '2 tablete dnevno, tjedan dana'),
(1001,401,816, '1 tableta svakih 6 sati, tri dana'),
(1002,402,806, '1 tableta dnevno'),
(1003,403,803, 'po potrebi'),
(1004,404,810, 'svakih 8 sati jedna tableta');
--KORIGIRATI KAD SE UNESU PACIJENTI

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
sifra VARCHAR (60) NOT NULL UNIQUE,
naziv VARCHAR (60) NOT NULL UNIQUE
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
naziv VARCHAR (20) NOT NULL
);

CREATE TABLE stanje_lijekova (
id INTEGER PRIMARY KEY,
id_lijek INTEGER NOT NULL,
količina INTEGER NOT NULL,
rok_valjanosti DATE NOT NULL,
FOREIGN KEY (id_lijek) REFERENCES lijek (id),
CHECK (rok_valjanosti > STR_TO_DATE('15.05.2020.', '%d.%m.%Y.'))
);

CREATE TABLE terapija (
id INTEGER PRIMARY KEY,
id_pacijent INTEGER NOT NULL,
id_lijek INTEGER NOT NULL,
uporaba TEXT,
FOREIGN KEY (id_pacijent) REFERENCES pacijent (id),
FOREIGN KEY (id_lijek) REFERENCES lijek (id)
);

-- ----------------------NEVEN---------------------- --
/*  možda da imamo novu relaciju posjetitelj(id, ime, prezime, broj telefona...) pa da u posjetama se ne ponavlja ime, prezime
u slučaju da imamo istog posjetitelja više puta */

CREATE TABLE prijem(
id INTEGER PRIMARY KEY,
datum_prijema DATE NOT NULL,
id_pacijent INTEGER NOT NULL,
id_medicinske_sestre INTEGER NOT NULL,
id_doktor INTEGER NOT NULL,
id_dijagnoza INTEGER NOT NULL,
id_soba INTEGER NOT NULL,
FOREIGN KEY (id_pacijent) REFERENCES pacijent(id),
FOREIGN KEY (id_medicinske_sestre) REFERENCES medicinske_sestre(id),
FOREIGN KEY (id_doktor) REFERENCES doktor (id),
FOREIGN KEY (id_dijagnoza) REFERENCES dijagnoza(id),
FOREIGN KEY (id_soba) REFERENCES soba(id)
 );
 
 CREATE TABLE posjeta(
 id INTEGER PRIMARY KEY,
 ime VARCHAR(20) NOT NULL,
 prezime VARCHAR(20) NOT NULL,
 temperatura NUMERIC(3,1) NOT NULL,
 datum DATETIME NOT NULL,
 vrijeme_dolaska TIME NOT NULL,
 vrijeme_odlaska TIME NOT NULL,
 id_pacijent INTEGER NOT NULL,
 FOREIGN KEY (id_pacijent) REFERENCES pacijent (id)
 );
 
 CREATE TABLE oprema(
 id INTEGER PRIMARY KEY,
 sifra VARCHAR(10) NOT NULL UNIQUE,
 naziv VARCHAR(30) NOT NULL,
 datum_zaprimanja DATE NOT NULL
 
  
  );
  
   CREATE TABLE stanje_opreme(
  id INTEGER PRIMARY KEY,
  id_oprema INTEGER NOT NULL,
  id_soba INTEGER NOT NULL,
  količina INTEGER NOT NULL,
  FOREIGN KEY (id_oprema) REFERENCES oprema(id),
  FOREIGN KEY (id_soba) REFERENCES soba(id)  
);

-- ---POPUNJAVANJE TABLICA: odjel, doktor, sos_kontakt--- --

-- id od 100 do 200
INSERT INTO odjel VALUES
(100, 'Kardiologija', 2, 3),
(101, 'Intenzivno liječenje', 3, 3),
(102, 'Ortopedija', 1, 5);
-- id od 200 do 300
INSERT INTO doktor VALUES 
(200, 'Krešimira', 'Paspalj', STR_TO_DATE('11.01.1978.','%d.%m.%Y.'), 102),
(201, 'Noris', 'Grubor', STR_TO_DATE('03.05.1982.','%d.%m.%Y.'), 100),
(202, 'Šime', 'Ljubić', STR_TO_DATE('09.12.1973.','%d.%m.%Y.'), 101),
(203, 'Jasmina', 'Mejak', STR_TO_DATE('03.06.1985.','%d.%m.%Y.'), 101),
(204, 'Mauro', 'Tomasov', STR_TO_DATE('24.07.1970.','%d.%m.%Y.'), 100),
(205, 'Jan', 'Nikolić', STR_TO_DATE('22.08.1962.','%d.%m.%Y.'), 100),
(206, 'Gabrijel', 'Popović', STR_TO_DATE('01.05.1976.','%d.%m.%Y.'), 101),
(207, 'Božidarka', 'Obad', STR_TO_DATE('03.06.1990.','%d.%m.%Y.'), 100),
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
(419, 'Matija', 'Mladenović', STR_TO_DATE('13.08.1997.','%d.%m.%Y.'), 'Miševečka ulica 4', 'M', '0918964756', '81587459', 319),
(420, 'filip', 'Perišić', STR_TO_DATE('14.09.1998.','%d.%m.%Y.'), 'Laginjina ulica 18', 'M', '091598624', '8542681', 319);


-- id od 500 do 600
INSERT INTO medicinske_sestre VALUES 
(500, 'Ivana', 'Ivić',STR_TO_DATE('11.02.1992','%d.%m.%Y.'), 100),
(501, 'Miliana', 'Milić',STR_TO_DATE('11.02.1999','%d.%m.%Y.'), 101),
(502, 'Ivana','Marić',STR_TO_DATE('01.02.1998','%d.%m.%Y.'), 102),
(503, 'Marko', 'Marulić',STR_TO_DATE('13.03.2000','%d.%m.%Y.'), 100),
(504, 'Žarka', 'Stanić', STR_TO_DATE('05.02.1992','%d.%m.%Y.'), 102);	

-- id od 600 do 700

INSERT INTO dijagnoza VALUES
(600, 'Hypertensio arterialis essentialis (primaria)' , 'I 10'), 
(601, 'Angina pectoris' , 'I 20'),
(602, 'Infarctus myocardii acutus' , 'I 21'),
(603, 'Vulnus apertum abdominis lumbi et pelvis' , 'S 31'),
(604, 'Luxatio vertebrae lumbalis' , 'S 33.1'),
(605, 'Laesio traumatica aortae abdominalis' , 'S 35'),
(606, '(Osteo)arthrosis generalisata primaria' , 'M 15'),
(607, 'Deformationes digitorum manus et digitorum pedis acquisitae' , 'M 20'),
(608, 'Pes planus (acquisitus)' , 'M 21.4');


-- ---POPUNJAVANJE TABLICA: soba, lijek, terapija--- --

-- id od 700 do 800
INSERT INTO soba VALUES

-- sobe odjel 100
(700, 004, 2,'slobodno', 100),
(701, 005, 2,'popunjeno', 100),
(702, 006, 2,'popunjeno', 100),

-- sobe odjel 101
(703, 007, 2,'slobodno', 101),
(704, 008, 2,'nedostupno', 101),
(705, 009, 2,'popunjeno', 101),

-- sobe odjel 102
(706, 001, 2,'popunjeno', 102),
(707, 002, 2,'nedostupno', 102),
(708, 003, 2,'slobodno', 102),
(709,004,4,'popunjeno', 102),
(710,005,4,'popunjeno', 102);

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
(1000, 400, 812, '2 tablete dnevno, tjedan dana'),
(1001, 403, 816, '1 tableta svakih 6 sati, tri dana'),
(1002, 412, 806, '1 tableta dnevno'),
(1003, 408, 803, '2 tablete prije rucka, 5 dana'),
(1004, 411, 802, '1 tableta dnevno'),
(1005, 413, 813, 'po potrebi'),
(1006, 414, 807, '1 tableta svakih 7 sati, 6 dana'),
(1007, 416, 802, '2 tablete svaki dan u razmaku od 8 sati'),
(1008, 417, 800, 'po potrebi'),
(1009, 419, 817, 'svakih 8 sati jedna tableta'),
(1010, 400, 811, 'svakih 12 sati jedna tableta'),
(1011, 415, 811, '1 tableta dnevno'),
(1012, 416, 811, 'svakih 6 sati dvije tablete'),
(1013, 414, 810, 'svakih 12 sati jedna tableta');


-- prijem([id], datum_prijema, {id_pacijent}, {id_medicinska_sestra}, {id_doktor}, {id_dijagnoza},  {id_soba})
INSERT INTO prijem VALUES
(1100, STR_TO_DATE('22.08.2022.','%d.%m.%Y.'), 400, 500,201,600,700 ),
(1101, STR_TO_DATE('23.08.2022.','%d.%m.%Y.'), 401, 500,204,601,700 ),
(1102, STR_TO_DATE('24.08.2022.','%d.%m.%Y.'), 402, 503,205,600,702 ),
(1103, STR_TO_DATE('25.08.2022.','%d.%m.%Y.'), 403, 503,207,601,702 ),
(1104, STR_TO_DATE('26.08.2022.','%d.%m.%Y.'), 404, 501,202,602,705 ),
(1105, STR_TO_DATE('27.08.2022.','%d.%m.%Y.'), 405, 501,206,602,705 ),
(1106, STR_TO_DATE('28.08.2022.','%d.%m.%Y.'), 406, 502,200,603,706 ),
(1107, STR_TO_DATE('29.08.2022.','%d.%m.%Y.'), 407, 502,208,603,706 ),
(1108, STR_TO_DATE('22.08.2022.','%d.%m.%Y.'), 408, 504,200,604,708 ),
(1109, STR_TO_DATE('23.08.2022.','%d.%m.%Y.'), 409, 504,200,604,708 ),
(1110, STR_TO_DATE('24.08.2022.','%d.%m.%Y.'), 410, 502,200,604,709 ),
(1111, STR_TO_DATE('25.08.2022.','%d.%m.%Y.'), 411, 502,200,603,709 ),
(1112, STR_TO_DATE('26.08.2022.','%d.%m.%Y.'), 412, 502,200,604,709 ),
(1113, STR_TO_DATE('27.08.2022.','%d.%m.%Y.'), 413, 502,200,603,709 ),
(1114, STR_TO_DATE('28.08.2022.','%d.%m.%Y.'), 414, 504,208,604,710 ),
(1115, STR_TO_DATE('29.08.2022.','%d.%m.%Y.'), 415, 504,208,603,710 ),
(1116, STR_TO_DATE('30.08.2022.','%d.%m.%Y.'), 416, 504,208,604,710 ),
(1117, STR_TO_DATE('23.08.2022.','%d.%m.%Y.'), 417, 504,208,603,710 )
;

-- posjeta([id], ime, prezime, temperatura, datum, vrijeme_dolaska, vrijeme_odlaska, {id_pacijent})
INSERT INTO posjeta VALUES
(1201,'Zora', 'Kunstl',36.1, STR_TO_DATE('22.08.2022.','%d.%m.%Y.'), '10:00','10:30',400),
(1202,'Stanko', 'Sutarić',36.2, STR_TO_DATE('23.08.2022.','%d.%m.%Y.'), '11:00','11:30',401),
(1203,'Issa', 'Biševac',36.3, STR_TO_DATE('24.08.2022.','%d.%m.%Y.'), '12:30','12:35',402),
(1204,'Elenora', 'Delfar',36.4, STR_TO_DATE('25.08.2022.','%d.%m.%Y.'), '11:00','11:30',403),
(1205,'Aden', 'Kotolaš',36.5, STR_TO_DATE('26.08.2022.','%d.%m.%Y.'), '12:00','12:30',404),
(1206,'Vojmil', 'Novaković',36.6, STR_TO_DATE('27.08.2022.','%d.%m.%Y.'), '10:00','10:30',405),
(1207,'Ljubica', 'Topić',36.7, STR_TO_DATE('28.08.2022.','%d.%m.%Y.'), '10:00','10:30',406),

(1208,'Jopa', 'Stanic',36.8, STR_TO_DATE('29.08.2022.','%d.%m.%Y.'), '18:00','18:30',407),
(1209,'Zorko', 'Kunac',36.5, STR_TO_DATE('22.08.2022.','%d.%m.%Y.'), '17:00','17:30',408),
(1210,'Iva', 'Vanić',36.4, STR_TO_DATE('23.08.2022.','%d.%m.%Y.'), '11:00','12:30',409),
(1211,'Maja', 'Prijatel',36.3, STR_TO_DATE('24.08.2022.','%d.%m.%Y.'), '13:00','13:30',410),
(1212,'Kuma', 'Kumi',36.2, STR_TO_DATE('25.08.2022.','%d.%m.%Y.'), '14:00','14:30',411),
(1213,'Jasna', 'Zelić',36.1, STR_TO_DATE('26.08.2022.','%d.%m.%Y.'), '16:00','16:30',412),
(1214,'Jugoslav', 'Čerišnja',36.0, STR_TO_DATE('27.08.2022.','%d.%m.%Y.'), '12:00','12:30',413)
 ;
 
  -- id,sifra,naziv, datum_zaprimanja, datum_otpisa,
 INSERT INTO oprema VALUES
 (1300, 'A000.0', 'EKG', STR_TO_DATE('20.02.2002','%d.%m.%Y.')),
 (1301, 'A000.1', 'STETOSKOP', STR_TO_DATE('20.02.2003','%d.%m.%Y.')),
 (1302, 'A000.2', 'LARINGOSKOP', STR_TO_DATE('20.02.2004','%d.%m.%Y.')),
 (1303, 'A000.3', 'ULTRAZVUK', STR_TO_DATE('20.02.2005','%d.%m.%Y.')), 
 (1304, 'A000.4', 'MOBILNI RENTGENSKI UREĐAJ', STR_TO_DATE('20.02.2006','%d.%m.%Y.')),
 (1305, 'A000.5', 'KREVET ZA PRIJEVOZ PACIJENATA', STR_TO_DATE('20.02.2002','%d.%m.%Y.')),
 (1306, 'A000.6', 'HIDRAULICKI PODESIVA KOLICA', STR_TO_DATE('20.02.2002','%d.%m.%Y.'));

INSERT INTO stanje_opreme VALUES
  (1400,1300,704,3),
  (1401,1301,704,5),
  (1402,1302,707,3),
  (1403,1303,707,1),
  (1404,1304,707,1),
  (1405,1305,707,1),
  (1406,1306,704,2);



-- --------- TIN UPITI ---------- --
-- 1) Svi pacijenti koji su primljeni prije datuma X kod doktora Y a koji još nisu primili terapiju
 -- Doktorica Debeljak (id:208) otišla je na godišnji odmor 30.08.2022, te je bilo potrebno zbrinuti njene pacijente koji su joj dodjeljeni prije
 -- odlaska na godišnji odmor, a kojima ona još nije prepisala terapiju.
  
SELECT pa.*
FROM pacijent as pa, prijem as pr, doktor as d
WHERE pa.id = pr.id_pacijent 
    AND pr.id_doktor = d.id
    AND d.id = 208
    AND pr.datum_prijema < STR_TO_DATE('30.08.2022','%d.%m.%Y.')
HAVING pa.id NOT IN (SELECT id_pacijent FROM terapija);

-- 2) Popis svih pacijenata i ljudi koji su bili u doticaju s njima (doktori,sestre,posjetitelji) na katu broj 2 na kojem je izbila zaraza nakon datuma X
 -- Na katu broj 2 bolnice izbila je zaraza među pacijentima i potrebno je sastaviti popis svih ljudi(uključujući i pacijente) koji su se nakon određenog datuma našli na ovom katu.
-- selektiranje svih pacijenata s drugog kata gdje je izbila zaraza nakon datuma 
CREATE VIEW zarazeni_pacijenti AS
SELECT p.id,p.ime,p.prezime
FROM pacijent as p, prijem, soba, odjel
WHERE p.id = prijem.id_pacijent
	AND prijem.id_soba = soba.id
	AND soba.id_odjel = odjel.id
	AND kat = 2 
    AND  datum_prijema >= STR_TO_DATE('24.08.2022','%d.%m.%Y.');


-- popis zarazenih pacijenata
SELECT *  FROM  zarazeni_pacijenti

UNION

-- popis svih doktora na temelju zarazenih pacijenata
SELECT DISTINCT doc.id, doc.ime, doc.prezime 
FROM doktor as doc, zarazeni_pacijenti as za , prijem
WHERE za.id = prijem.id_pacijent
AND doc.id = prijem.id_doktor

UNION

-- popis svih medicinskih sestara na temelju zarazenih pacijenata
SELECT DISTINCT med.id, med.ime, med.prezime 
FROM medicinske_sestre as med, zarazeni_pacijenti as za , prijem
WHERE za.id = prijem.id_pacijent
AND med.id = prijem.id_medicinske_sestre

UNION

-- popis svih posjeta pacijentima drugog kata na temelju tablice zarazenih pacijenata
SELECT DISTINCT pos.id, pos.ime, pos.prezime
FROM posjeta as pos, zarazeni_pacijenti as za
WHERE za.id = pos.id_pacijent;

-- 3) Kolicine lijekova po nazivima kojima istice rok trajanja za manje od godinu dana
-- Odjel nabave obavezan je unaprijed  naručiti nove zalihe lijekova kojima ističe rok za manje od godinu dana, stoga je potrebno
-- sastaviti popis i stanje takvih zaliha lijekova u bolnici.
-- Lijekovi kojima je istekao rok trajanja su također u evidenciji sve do njihovog zbrinjavanja i odlaganja, no u ovom slučaju nas zanimaju samo lijekovi sa valjanim rokom uporabe  koji se
-- trenutno koriste u bolnici

-- SELECT lijek.naziv, stanje_lijekova.količina
SELECT li.id, li.naziv, st.količina, st.rok_valjanosti, (SELECT DATEDIFF(rok_valjanosti,(SELECT NOW() FROM DUAL))) as dani_do_isteka
FROM lijek as li
INNER JOIN stanje_lijekova as st ON li.id = st.id_lijek 
HAVING dani_do_isteka BETWEEN 0 AND 365
ORDER BY dani_do_isteka ASC;

-- 4) Koliko je koji doktor propisao lijekova pacijentima u razdoblju između X i Y?
-- 5) Doktori koji su prepisali najviše lijekova pacijentima u razdoblju između x i y?

CREATE VIEW broj_izdavanja_lijeka AS
SELECT doc.id, doc.ime, doc.prezime, COUNT(doc.id) as ukupno_izdano_lijekova 
FROM pacijent as pa
INNER JOIN prijem as pr ON pa.id = pr.id_pacijent
INNER JOIN doktor as doc ON doc.id = pr.id_doktor
INNER JOIN terapija as te ON pa.id = te.id_pacijent
WHERE  datum_prijema BETWEEN STR_TO_DATE('22.08.2022','%d.%m.%Y.') AND STR_TO_DATE('29.08.2022','%d.%m.%Y.')
GROUP BY doc.id
ORDER BY ukupno_izdano_lijekova DESC;

-- ukupno po doktoru
SELECT * 
FROM broj_izdavanja_lijeka;

-- doktori sa najviše izdanih lijekova
SELECT * 
FROM broj_izdavanja_lijeka
WHERE ukupno_izdano_lijekova = (SELECT MAX(ukupno_izdano_lijekova) FROM broj_izdavanja_lijeka);


-- 6) Koliko pacijenata je na kojoj vrsti lijekova?
SELECT vrsta as vrsta_lijeka, COUNT(vrsta) as broj_pacijenata
FROM pacijent as pa
INNER JOIN terapija as te ON pa.id = te.id_pacijent
INNER JOIN lijek as li ON li.id = te.id_lijek
GROUP BY vrsta
ORDER BY broj_pacijenata DESC;
-- ----- TIN kraj upita ----- --


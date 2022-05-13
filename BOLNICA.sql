DROP DATABASE IF EXISTS bolnica;
CREATE DATABASE bolnica;
USE bolnica;
-- id 100 do 200
CREATE TABLE doktor (
	id INTEGER PRIMARY KEY,
    ime VARCHAR (20) NOT NULL,
    prezime VARCHAR (30) NOT NULL,
    datum_rodenja DATETIME NOT NULL
);
-- id 600 do 700
CREATE TABLE medicinske_sestre(
	id INTEGER PRIMARY KEY,
    ime VARCHAR (20) NOT NULL,
    prezime VARCHAR (30) NOT NULL,
    datum_rodenja DATETIME NOT NULL
);
-- id 200 do 300
CREATE TABLE pacijent (
	id INTEGER PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    prezime VARCHAR(30) NOT NULL,
    datum_rodenja DATETIME NOT NULL,
    adresa VARCHAR (40) NOT NULL,
    spol CHAR (1) NOT NULL,
    broj_telefona VARCHAR (20) NOT NULL UNIQUE,
    broj_zdravstvene VARCHAR (20) NOT NULL UNIQUE
);
-- id 300 do 400
CREATE TABLE odjel (
	id INTEGER PRIMARY KEY,
    id_doktor INTEGER NOT NULL,
    id_medsestra INTEGER NOT NULL,
    naziv VARCHAR (40) NOT NULL UNIQUE,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_medsestra) REFERENCES medicinske_sestre (id)
);
-- id 400 do 500
CREATE TABLE recept (
	id INTEGER PRIMARY KEY,
    id_doktor INTEGER NOT NULL,
    id_pacijent INTEGER NOT NULL,
    datum DATETIME NOT NULL,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id)
);
-- id 500 do 600
CREATE TABLE soba (
	id INTEGER PRIMARY KEY,
    id_pacijent INTEGER NOT NULL,
    id_medsestra INTEGER NOT NULL,
    broj_sobe INTEGER NOT NULL UNIQUE,
    vrijeme_ulaska DATETIME NOT NULL,
    vrijeme_izlaska DATETIME NOT NULL,
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id),
    FOREIGN KEY (id_medsestra) REFERENCES medicinske_sestre (id)
);
-- id 700 do 800
CREATE TABLE termin (
	id INTEGER PRIMARY KEY,
    id_doktor INTEGER NOT NULL,
    id_pacijent INTEGER NOT NULL,
    datum_termina DATE NOT NULL,
    vrijeme_termina TIME NOT NULL,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id)
);
-- id 800 do 900
CREATE TABLE terapija (
	id INTEGER PRIMARY KEY,
    id_recept INTEGER NOT NULL,
    naziv_lijeka VARCHAR (30) NOT NULL UNIQUE,
    kolicina INTEGER NOT NULL,
    FOREIGN KEY (id_recept) REFERENCES recept (id),
    CHECK (kolicina > 0)
);
-- id 900 do 1000
CREATE TABLE dezurstvo (
	id INTEGER PRIMARY KEY,
    id_medsestra INTEGER NOT NULL,
    id_odjel INTEGER NOT NULL,
    datum_dezurstva DATETIME NOT NULL,
    FOREIGN KEY (id_medsestra) REFERENCES medicinske_sestre (id),
    FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);
-- id 1000 do 1100
CREATE TABLE zaposleni (
	id INTEGER PRIMARY KEY,
    id_odjel INTEGER NOT NULL,
    datum_zaposlenja DATETIME NOT NULL,
    datum_kraja_rada DATETIME NOT NULL,
    FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);
-- id 1100 do 1200
CREATE TABLE oprema (
	id INTEGER PRIMARY KEY,
    id_odjel INTEGER NOT NULL,
    id_soba INTEGER NOT NULL,
    naziv VARCHAR(20) NOT NULL,
    sifra VARCHAR(20) NOT NULL,
    datum_zaprimanja DATETIME NOT NULL,
    datum_otpisa DATETIME NOT NULL,
    FOREIGN KEY (id_odjel) REFERENCES odjel (id),
    FOREIGN KEY (id_soba) REFERENCES soba (id)
);
-- id 1200 do 1300
CREATE TABLE posjeta (
	id INTEGER PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    prezime VARCHAR(30) NOT NULL,
    id_pacijent INTEGER NOT NULL,
    id_soba INTEGER NOT NULL,
    datum DATETIME NOT NULL,
    vrijeme_dolaska TIME NOT NULL,
    vrijeme_odlaska TIME NOT NULL,
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id),
    FOREIGN KEY (id_soba) REFERENCES soba (id)
);

-- -------------------------MARIJA------------------------- --
-- unošenje podataka unutar relacija doktor, pacijent, posjeta
INSERT INTO doktor VALUES (100, 'Krešimira', 'Paspalj', STR_TO_DATE('11.01.1978.','%d.%m.%Y.')),
                              (101, 'Noris', 'Grubor', STR_TO_DATE('03.05.1982.','%d.%m.%Y.')),
                              (102, 'Šime', 'Ljubić', STR_TO_DATE('09.12.1973.','%d.%m.%Y.')),
                              (103, 'Jasmina', 'Mejak', STR_TO_DATE('03.06.1985.','%d.%m.%Y.')),
                              (104, 'Mauro', 'Tomasov', STR_TO_DATE('24.07.1970.','%d.%m.%Y.'));
INSERT INTO pacijent VALUES (200, 'Zora', 'Kunstl', STR_TO_DATE('15.09.1956.','%d.%m.%Y.'), 'Žitnjačka cesta 25', 'Ž', '0997314087', '69472315'),
                              (201, 'Stanko', 'Sutarić', STR_TO_DATE('23.02.1962.','%d.%m.%Y.'), 'Zavrtnica 17', 'M', '0916813627', '82631549'),
                              (202, 'Issa', 'Biševac', STR_TO_DATE('07.10.2012.','%d.%m.%Y.'), 'Put Duilova 11', 'Ž', '0929430314', '47395186'),
                              (203, 'Elenora', 'Delfar', STR_TO_DATE('25.05.1998.','%d.%m.%Y.'), 'Ante Starčevića 23', 'Ž', '0957923190', '82641357'),
                              (204, 'Aden', 'Kotolaš', STR_TO_DATE('16.04.1989.','%d.%m.%Y.'), 'Poljička cesta 32', 'M', '0997871285', '98356471');
			      
			   
# --------------------------NOEL--------------------------- --
# unošenje podataka unutar relacija termin, terapija, recept

INSERT INTO termin VALUES (700, 103, 204, STR_TO_DATE('10.05.2022.', '%d.%m.%Y.'),'10:15'),
                          (701, 104, 200, STR_TO_DATE('10.05.2022.', '%d.%m.%Y.'),'11:00'),
                          (702, 102, 202, STR_TO_DATE('11.05.2022.', '%d.%m.%Y.'),'12:30'),
		          (703, 100, 203, STR_TO_DATE('15.05.2022.', '%d.%m.%Y.'),'09:45'),
			  (704, 101, 201, STR_TO_DATE('13.05.2022.', '%d.%m.%Y.'),'08:30');
                          
INSERT INTO recept VALUES (400, 103, 204, STR_TO_DATE('10.05.2022.', '%d.%m.%Y.')),
			  (401, 104, 200, STR_TO_DATE('10.05.2022.', '%d.%m.%Y.')),
                          (402, 102, 202, STR_TO_DATE('11.05.2022.', '%d.%m.%Y.')),
                          (403, 100, 203, STR_TO_DATE('15.05.2022.', '%d.%m.%Y.')),       
                          (404, 101, 201, STR_TO_DATE('13.05.2022.', '%d.%m.%Y.'));
                          
# pokušaj,  prijedlog-promijeniti količinu iz INT u VARCHAR da mogu napisati npr "550mg"?			
INSERT INTO terapija VALUES (800, 400, 'lijek1', 550),
			    (801, 403, 'lijek2', 550), 
                            (802, 404, 'lijek3', 550), 
                            (803, 402, 'lijek4', 550),
                            (804, 401, 'lijek5', 550);
			    
			    
-----------------------------------------NEVEN-------------------------------

INSERT INTO medicinske_sestre VALUES (600, 'Ivana', 'Ivić',1992),
(601, 'Miliana', 'Milić',STR_TO_DATE('11.02.1999','%d.%m.%Y.')),
(602, 'Ivana','Marić',STR_TO_DATE('01.02.1998','%d.%m.%Y.')),
(603, 'Marko', 'Marulić',STR_TO_DATE('13.03.2000','%d.%m.%Y.')),
(604, 'Žarka', 'Stanić', STR_TO_DATE('05.02.1992','%d.%m.%Y.'));

INSERT INTO odjel VALUES (300,100,600,'ortopedija' ),
(301,101,601,'ortopedija' ),
(302,102,602,'ortopedija' ),
(303,103,603,'ortopedija' ),
(304,104,604,'ortopedija' );

INSERT INTO soba VALUES(500,200,600,1,12.00,13.00),
(501,201,601,2,TIME("11:30:10"),TIME("11:35:10")),
(502,202,602,3,TIME("12:30:10"),TIME("13:30:10")),
(503,203,603,4,TIME("14:30:10"),TIME("15:30:10")),
(500,204,604,5,TIME("16:30:10"),TIME("17:30:10"));

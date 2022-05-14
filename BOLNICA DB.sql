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

-- id od 100 do 200
INSERT INTO odjel VALUES
(100, 'Kardiologija', 4, 5),
(101, 'Intenzivno liječenje', 5, 12),
(102, 'Ortopedija', 3, 8),
(103, 'Pedijatrija', 1, 17),
(104, 'Oftalmologija', 2, 0);
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
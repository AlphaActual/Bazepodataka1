CREATE DATABASE bolnica;
USE bolnica;
DROP DATABASE bolnica;
CREATE TABLE doktor (
	id INTEGER PRIMARY KEY,
    ime VARCHAR (20) NOT NULL,
    prezime VARCHAR (30) NOT NULL,
    datum_rodenja DATE NOT NULL
);
CREATE TABLE pacijent (
	id INTEGER PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    prezime VARCHAR(30) NOT NULL,
    datum_rodenja DATE NOT NULL,
    adresa VARCHAR (40) NOT NULL,
    spol CHAR (1) NOT NULL,
    broj_telefona VARCHAR (20) NOT NULL UNIQUE,
    broj_zdravstvene VARCHAR (20) NOT NULL UNIQUE
);
CREATE TABLE odjel (
	id INTEGER PRIMARY KEY,
    id_doktor INTEGER NOT NULL,
    id_medsestra INTEGER NOT NULL,
    naziv VARCHAR (40) NOT NULL UNIQUE,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_medsestra) REFERENCES medicinske_sestre (id)
);
CREATE TABLE recept (
	id INTEGER PRIMARY KEY, 
    id_doktor INTEGER NOT NULL,
    id_pacijent INTEGER NOT NULL,
    datum DATE NOT NULL,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id)
);
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
CREATE TABLE medicinske_sestre(
	id INTEGER PRIMARY KEY,
    ime VARCHAR (20) NOT NULL,
    prezime VARCHAR (30) NOT NULL,
    datum_rodenja DATE NOT NULL
);
CREATE TABLE termin (
	id INTEGER PRIMARY KEY,
    id_doktor INTEGER NOT NULL,
    id_pacijent INTEGER NOT NULL,
    vrijeme_termina DATETIME NOT NULL,
    FOREIGN KEY (id_doktor) REFERENCES doktor (id),
    FOREIGN KEY (id_pacijent) REFERENCES pacijent (id)
);
CREATE TABLE terapija (
	id INTEGER PRIMARY KEY, 
    id_recept INTEGER NOT NULL,
    naziv_lijeka VARCHAR (30) NOT NULL UNIQUE,
    kolicina INTEGER NOT NULL,
    FOREIGN KEY (id_recept) REFERENCES recept (id),
    CHECK (kolicina > 0)
);
CREATE TABLE dezurstvo (
	id INTEGER PRIMARY KEY, 
    id_medsestra INTEGER NOT NULL,
    id_odjel INTEGER NOT NULL,
    datum_dezurstva DATE NOT NULL,
    FOREIGN KEY (id_medsestra) REFERENCES medicinske_sestre (id),
    FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);
CREATE TABLE zaposleni (
	id INTEGER PRIMARY KEY,
    id_odjel INTEGER NOT NULL,
    datum_zaposlenja DATE NOT NULL,
    datum_kraja_rada DATE NOT NULL,
    FOREIGN KEY (id_odjel) REFERENCES odjel (id)
);

TEST TIN P.
=======
MARIJA
Noel
RADI RADIO555


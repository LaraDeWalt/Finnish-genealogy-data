-- Finnish Genealogy Data
-- Initial relational database schema
--
-- This schema implements the first version of the project's
-- relational data model for historical genealogical research.


CREATE TABLE henkilot (
    person_id VARCHAR(10) PRIMARY KEY,
    etunimi VARCHAR(100),
    toinen_nimi VARCHAR(100),
    tytto_nimi VARCHAR(100),
    sukunimi VARCHAR(100),
    patronyymi VARCHAR(100),
    syntyma_paiva VARCHAR(5),
    syntymavuosi INTEGER,
    sukupuoli VARCHAR(20),
    syntymapaikka VARCHAR(255),
    kuolin_paiva VARCHAR(5),
    kuolin_vuosi INTEGER,
    kuolin_paikka VARCHAR(255)
);

CREATE TABLE paikat (
    place_id VARCHAR(10) PRIMARY KEY,
    nimi VARCHAR(255),
    muuta TEXT
);

CREATE TABLE lahteet (
    lahde_id VARCHAR(10) PRIMARY KEY,
    lahde_tyyppi VARCHAR(100),
    ajanjakso VARCHAR(50),
    alue VARCHAR(255),
    aineiston_nimi VARCHAR(255),
    aineiston_tarjoaja VARCHAR(255),
    linkki TEXT,
    lisatiedot TEXT
);

CREATE TABLE havainnot (
    havainto_id VARCHAR(10) PRIMARY KEY,
    havaintovuosi INTEGER,
    person_id VARCHAR(10),
    etunimi_lahteessa VARCHAR(100),
    sukunimi_lahteessa VARCHAR(100),
    patronyymi_lahteessa VARCHAR(100),
    syntymapaiva_lahteessa VARCHAR(5),
    syntymavuosi_lahteessa INTEGER,
    avioliitto_pv_lahteessa VARCHAR(5),
    avioliitto_vuosi_lahteessa INTEGER,
    kuolin_paiva_lahteessa VARCHAR(5),
    kuolin_vuosi_lahteessa INTEGER,
    kuolinsyy_lahteessa VARCHAR(255),
    place_id VARCHAR(10),
    asema_lahteessa VARCHAR(100),
    henkirahasta_vapaa VARCHAR(100),
    muuta TEXT,
    lahde_id VARCHAR(10) NOT NULL,
    sivu_nro VARCHAR(50),

    FOREIGN KEY (person_id) REFERENCES henkilot(person_id),
    FOREIGN KEY (place_id) REFERENCES paikat(place_id),
    FOREIGN KEY (lahde_id) REFERENCES lahteet(lahde_id)
);

CREATE TABLE paikkahavainnot (
    paikkahavainto_id VARCHAR(10) PRIMARY KEY,
    place_id VARCHAR(10) NOT NULL,
    ajanjakso VARCHAR(50),
    nimi_lahteessa VARCHAR(255),
    paikka_tyyppi VARCHAR(100),
    tila_numero_lahteessa VARCHAR(50),
    parent_place_id VARCHAR(10),
    maanomistus VARCHAR(100),
    lahde_id VARCHAR(10) NOT NULL,
    sivu_nro VARCHAR(50),
    muuta TEXT,

    FOREIGN KEY (place_id) REFERENCES paikat(place_id),
    FOREIGN KEY (parent_place_id) REFERENCES paikat(place_id),
    FOREIGN KEY (lahde_id) REFERENCES lahteet(lahde_id)
);

CREATE TABLE suhteet (
    suhde_id VARCHAR(10) PRIMARY KEY,
    person_id_1 VARCHAR(10) NOT NULL,
    suhdetyyppi VARCHAR(50) NOT NULL,
    person_id_2 VARCHAR(10) NOT NULL,
    alku_paiva VARCHAR(5),
    alku_vuosi INTEGER,
    loppu_paiva VARCHAR(5),
    loppu_vuosi INTEGER,
    loppu_syy VARCHAR(100),
    muuta TEXT,

    FOREIGN KEY (person_id_1) REFERENCES henkilot(person_id),
    FOREIGN KEY (person_id_2) REFERENCES henkilot(person_id)
);

CREATE TABLE suhdelahteet (
    suhdelahde_id VARCHAR(10) PRIMARY KEY,
    suhde_id VARCHAR(10) NOT NULL,
    lahde_id VARCHAR(10) NOT NULL,
    sivu_nro VARCHAR(50),
    peruste VARCHAR(255),
    varmuus VARCHAR(50),
    muuta TEXT,

    FOREIGN KEY (suhde_id) REFERENCES suhteet(suhde_id),
    FOREIGN KEY (lahde_id) REFERENCES lahteet(lahde_id)
);

CREATE TABLE rippikirjamerkinnat (
    merkinta_id VARCHAR(10) PRIMARY KEY,
    havainto_id VARCHAR(10) NOT NULL,
    merkinta_tyyppi VARCHAR(100) NOT NULL,
    paivamaara VARCHAR(10),
    vuosi INTEGER,
    merkinta_lahteessa VARCHAR(255),
    tulkinta VARCHAR(255),
    muuta TEXT,

    FOREIGN KEY (havainto_id) REFERENCES havainnot(havainto_id)
);

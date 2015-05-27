----------------------------
--usuwamy poprzednie tabele
----------------------------
begin
  for i in (select 'drop table '||table_name||' cascade constraints' tbl from user_tables) 
  loop
     execute immediate i.tbl;
  end loop;
end;

--DROP TABLE Dzial CASCADE CONSTRAINTS;
--DROP TABLE Towar  CASCADE CONSTRAINTS;
--DROP TABLE Pracownik CASCADE CONSTRAINTS;
--DROP TABLE Transakcja CASCADE CONSTRAINTS;
--DROP TABLE Opinie CASCADE CONSTRAINTS;

CREATE TABLE Dzial
  (
    id        NUMBER(7) PRIMARY KEY ,
    Nazwa     VARCHAR2(25),
    Kierownik NUMBER(7)
  );
CREATE TABLE Towar
  (
    id    NUMBER(7) PRIMARY KEY ,
    Nazwa VARCHAR2(25),
    Dzial NUMBER(7),
    Cena FLOAT(7),
    Opinia NUMBER(7),
    Ilosc  NUMBER(7)
  );
CREATE TABLE Pracownik
  (
    id       NUMBER(7) PRIMARY KEY ,
    Imie     VARCHAR2(25),
    Nazwisko VARCHAR2(25),
    Dzial    NUMBER(7),
    Pensja FLOAT(7)
  );
CREATE TABLE Transakcja
  (
    id    NUMBER(7) PRIMARY KEY ,
    Towar NUMBER(7),
    cena_jednostkowa FLOAT(7),
    Ilosc NUMBER(7),
    Suma FLOAT(7),
    Sprzedawca NUMBER(7),
    Opinia     NUMBER(7)
  );

CREATE TABLE Opinia
  (
    id       NUMBER(7) PRIMARY KEY,
    Ocena    NUMBER(1),
    Imie     VARCHAR(25),
    Nazwisko VARCHAR(25),
    Tresc    VARCHAR(25)
  );
  
CREATE TABLE Log
  ( 
  Data DATE, 
  ID_triggera NUMBER(7)
  );  
  
ALTER TABLE Dzial ADD CONSTRAINT fk_dzial FOREIGN KEY (Kierownik) REFERENCES Pracownik(id) ;
ALTER TABLE Towar ADD CONSTRAINT fk_towar FOREIGN KEY (dzial) REFERENCES dzial(id) ;
ALTER TABLE Towar ADD CONSTRAINT fk_towar2 FOREIGN KEY (opinia) REFERENCES opinia(id) ;
ALTER TABLE Pracownik ADD CONSTRAINT fk_pracownik FOREIGN KEY (dzial) REFERENCES dzial(id) ;
ALTER TABLE Transakcja ADD CONSTRAINT fk_transakcja FOREIGN KEY (towar) REFERENCES towar(id);
ALTER TABLE Transakcja ADD CONSTRAINT fk_transakcja_1 FOREIGN KEY (Sprzedawca) REFERENCES Pracownik(id);

INSERT INTO Dzial VALUES(1,"Chemia domowa",1 );
INSERT INTO TOWAR VALUES  (1, 'CD', 1, 2, 1, 2  );
INSERT INTO Pracownik VALUES  (2, 'Janusz', 'Nowak', 2, 2000  );
INSERT INTO transakcja VALUES  (1, 1, 199.9999, 2, 2, 1);
INSERT INTO opinia VALUES  (1, 5, "Andrey", "Kalishek", "Bardzo super sklep");


----------------------------
--usuwamy poprzednie tabele
----------------------------
--begin
--  for i in (select 'drop table '||table_name||' cascade constraints' tbl from user_tables) 
--  loop
--     execute immediate i.tbl;-

--  end loop;
--end;

DROP TABLE Dzial CASCADE CONSTRAINTS;
DROP TABLE Towar  CASCADE CONSTRAINTS;
DROP TABLE Pracownik CASCADE CONSTRAINTS;
DROP TABLE Transakcja CASCADE CONSTRAINTS;
DROP TABLE Opinia CASCADE CONSTRAINTS; 
Drop table Log CASCADE CONSTRAINTS;


ALTER TABLE Towar DROP CONSTRAINT fk_towar; 
ALTER TABLE Opinia DROP CONSTRAINT fk_opinia; 
ALTER TABLE Pracownik DROP CONSTRAINT fk_pracownik; 
ALTER TABLE Transakcja DROP CONSTRAINT fk_transakcja; 
ALTER TABLE Transakcja DROP CONSTRAINT fk_transakcja_1; 

DROP TRIGGER trigger_towar; 
DROP TRIGGER trigger_pracownik;
Drop trigger trigger_dzial;
Drop trigger trigger_transakcja;
Drop trigger trigger_opinia;




CREATE TABLE Dzial
  (
    idD        NUMBER(7) PRIMARY KEY ,
    Nazwa     VARCHAR2(25),
    Kierownik NUMBER(7)
  );
  
  
CREATE TABLE Towar
  (
    idT    NUMBER(7) PRIMARY KEY ,
    Nazwa VARCHAR2(25),
    Dzial NUMBER(7),
    Cena FLOAT(7),
   
    Ilosc  NUMBER(7)
  );
CREATE TABLE Pracownik
  (
    idP       NUMBER(7) PRIMARY KEY ,
    Imie     VARCHAR2(25),
    Nazwisko VARCHAR2(25),
    Dzial    NUMBER(7),
    Pensja FLOAT(7)
  );
CREATE TABLE Transakcja
  (
    idTra    NUMBER(7) PRIMARY KEY ,
    Towar NUMBER(7),
    cena_jednostkowa FLOAT(7),
    Ilosc NUMBER(7),
    Suma FLOAT(7),
    Sprzedawca NUMBER(7)
   
  );

CREATE TABLE Opinia
  (
    idO       NUMBER(7) PRIMARY KEY,
    Ocena    NUMBER(1),
    Imie     VARCHAR2(25),
    Nazwisko VARCHAR2(25),
    Tresc    VARCHAR2(50),
    idT    NUMBER(7)
  );
  

CREATE TABLE Log
  ( 
  Data DATE, 
  wiadomosc VARCHAR2(50)
  );  
  
--inserty
INSERT INTO Dzial VALUES(1,'Chemia domowa',1 );
INSERT INTO Dzial VALUES(2,'Chemia gospodarcza',1 );
INSERT INTO Dzial VALUES(3,'Bielizna',1 );
INSERT INTO Dzial VALUES(4,'Leki',1 );
INSERT INTO Dzial VALUES(5,'Artykuly dla zwierzat',1 );
INSERT INTO Dzial VALUES(6,'Papierosy i Alkohol',1 );

 --TOWAR(idT  Nazwa  Dzial   Cena   Opinia   Ilosc)  

INSERT INTO TOWAR VALUES  (100, 'Zel pod prysznic', 1, 1.99,10); 
INSERT INTO TOWAR VALUES  (101, 'Cif', 2, 2.99, 20 ); 
INSERT INTO TOWAR VALUES  (102, 'Majtki meskie XXL', 3, 7.99, 5 ); 
INSERT INTO TOWAR VALUES  (103, 'Ibum', 4, 8.15, 12 ); 
INSERT INTO TOWAR VALUES  (104, 'Karma dla kota', 5, 9.15,20 ); 
INSERT INTO TOWAR VALUES  (105, 'LM Blue', 6, 14.30 , 12 ); 


--Pracownik    idP          Imie         Nazwisko    Dzial      Pensja 
INSERT INTO Pracownik VALUES (1, 'Janusz', 'Nowak', 1, 2000);  
INSERT INTO Pracownik VALUES (2, 'Andrzej', 'Kowalski', 2, 2000);  
INSERT INTO Pracownik VALUES (3, 'Piotr', 'Badura', 3, 2000);  
INSERT INTO Pracownik VALUES (4, 'Iwona', 'Malak', 4, 2000);  
INSERT INTO Pracownik VALUES (5, 'Joanna', 'Grzyb', 5, 2000);  
INSERT INTO Pracownik VALUES (6, 'Barbara', 'Stawska', 6, 2000);  

--Transakcja  idTra Towar cena_jednostkowa Ilosc  Suma  Sprzedawca 
INSERT INTO TRANSAKCJA VALUES (100, 100, 1.99, 1, 1.99,1);  
INSERT INTO TRANSAKCJA VALUES (101, 101, 2.99, 1, 2.99,1);  
INSERT INTO TRANSAKCJA VALUES (102, 102, 7.99, 1, 7.99,1);  
INSERT INTO TRANSAKCJA VALUES (103, 103, 8.15, 1, 8.15,1);  
INSERT INTO TRANSAKCJA VALUES (104, 104, 9.15, 1, 9.15,1);  
INSERT INTO TRANSAKCJA VALUES (105, 105, 14.30, 1, 14.30,1);  

--Opinia  idO    Ocena   Imie  Nazwisko   Tresc  idT
INSERT INTO OPINIA VALUES (1,5,'Janusz','Kowalski','Super �el',100);  

INSERT INTO OPINIA VALUES (2,5,'Piotr','Salapata','Cif taki jak zawsze',101);  
INSERT INTO OPINIA VALUES (3,4,'Kinga','Wawrzyniak','Idealne majtki',102);  
INSERT INTO OPINIA VALUES (4,3,'Bartosz','Galecki','Co� nie dzialaja te tableki',103);  
INSERT INTO OPINIA VALUES (5,5,'Janina','Woods','Kotek jest przeszcz�sliwy',104);  
INSERT INTO OPINIA VALUES (6,1,'Anna','Warchol','Drogie te fajki',105);  
INSERT INTO OPINIA VALUES (7,5,'Andrzej','Piekarski','Super �el na moje wlosy',100); 

  
  
--ALTER TABLE Dzial ADD CONSTRAINT fk_dzial FOREIGN KEY (Kierownik) REFERENCES Pracownik(idP) ;
ALTER TABLE Towar ADD CONSTRAINT fk_towar FOREIGN KEY (dzial) REFERENCES dzial(idD) ;
--ALTER TABLE Towar ADD CONSTRAINT fk_towar2 FOREIGN KEY (opinia) REFERENCES opinia(idO) ;
ALTER TABLE Opinia ADD CONSTRAINT fk_opinia FOREIGN KEY (idT) REFERENCES Towar(idT) ;
ALTER TABLE Pracownik ADD CONSTRAINT fk_pracownik FOREIGN KEY (dzial) REFERENCES dzial(idD) ;
ALTER TABLE Transakcja ADD CONSTRAINT fk_transakcja FOREIGN KEY (towar) REFERENCES towar(idT);
ALTER TABLE Transakcja ADD CONSTRAINT fk_transakcja_1 FOREIGN KEY (Sprzedawca) REFERENCES Pracownik(idP);


CREATE OR REPLACE  TRIGGER trigger_towar
BEFORE INSERT OR UPDATE
  ON TOWAR
FOR EACH ROW
BEGIN
if(inserting)
then
INSERT INTO LOG
VALUES
(SYSDATE,'dowano nowy towar');
end if;
if(updating)
then
  INSERT INTO LOG
  VALUES
  (SYSDATE,'aktualizacja danych towaru');
end if;
end;

/

CREATE OR REPLACE  TRIGGER trigger_pracownik
BEFORE INSERT OR UPDATE
  ON PRACOWNIK
FOR EACH ROW
BEGIN
if(inserting)
then
INSERT INTO LOG
VALUES
(SYSDATE,'dodano nowego pracownika');
end if;
if(updating)
then
  INSERT INTO LOG
  VALUES
  (SYSDATE,'aktualizacja danych pracownika');
end if;
end;

/

CREATE OR REPLACE  TRIGGER trigger_dzial
BEFORE INSERT OR UPDATE
  ON dzial
FOR EACH ROW
BEGIN
if(inserting)
then
INSERT INTO LOG
VALUES
(SYSDATE,'dodano nowy dzial');
end if;
if(updating)
then
  INSERT INTO LOG
  VALUES
  (SYSDATE,'aktualizacja danych dzialu');
end if;
end;

/

CREATE OR REPLACE  TRIGGER trigger_transakcja
BEFORE INSERT OR UPDATE
  ON transakcja
FOR EACH ROW
BEGIN
if(inserting)
then
INSERT INTO LOG
VALUES
(SYSDATE,'dodano nowa transakcje');
end if;
if(updating)
then
  INSERT INTO LOG
  VALUES
  (SYSDATE,'aktualizacja transakcji');
end if;
end;

/

CREATE OR REPLACE  TRIGGER trigger_opinia
BEFORE INSERT OR UPDATE
  ON opinia
FOR EACH ROW
BEGIN
if(inserting)
then
INSERT INTO LOG
VALUES
(SYSDATE,'dodano nowa opinie');
end if;
if(updating)
then
  INSERT INTO LOG
  VALUES
  (SYSDATE,'aktualizacja opinii');
end if;
end;

--test trigera
--select * from USER_TRIGGERS;
--UPDATE TOWAR SET Cena=2.99 WHERE idT=100;
--select * from log;


---as
Select t.idT as "Numer Towaru",t.nazwa as "Nazwa produktu", o.TRESC as "Tresc Opinii" from Towar t join opinia o on (t.idT=o.idT); 
Select d.NAZWA, t.nazwa from dzial d join towar t on( d.IDD=t.dzial);




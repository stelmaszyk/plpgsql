-- Utwórz w języku PL/pgSQL funkcję FahrToCels (temperatura REAL) służącą do
-- przeliczania temperatury ze skali Fahrenheita do skali Celsjusza. Obliczenia powinny
-- odbywać się według następującego wzoru:
--  temperatura Celsjusz = (temperatura Fahrenheit -32) *5/9
-- Następnie sprawdź działanie funkcji FahrToCels
-- select FahrToCels(100);

CREATE OR REPLACE FUNCTION FahrToCels(temperatura REAL) RETURNS REAL AS $$
DECLARE
  tempCelc REAL;
BEGIN
  tempCelc = (temperatura - 32) * 5 / 9;
  return tempCelc;
END
$$ LANGUAGE PLPGSQL;

------------------------------------------------------
--
-- 2. Utwórz w języku PL/pgSQL funkcję NEWFILM(id_filmu INTEGER, tytul VARCHAR(20),
-- rok_produkcji INTEGER, cena REAL) służącą do wstawienia nowego rekordu do tabeli
-- FILMY. Funkcja powinna zwracać wartość tekstową:
--  "OK", jeżeli wstawianie rekordu odbędzie się bez zgłoszenia wyjątku
--  "BLEDNY ID", jeżeli podczas próby wstawienia rekordu zostanie zgłoszony wyjątek
-- UNIQUE_VIOLATION
-- Następnie sprawdź działanie funkcji NEWFILM():
-- select NEWFILM(1, 'Ida', 2013, 10);
-- select NEWFILM(20, 'Ida', 2013, 10);

CREATE OR REPLACE FUNCTION NEWFILM(id_filmu INTEGER, tytul VARCHAR(20), rok_produkcji INTEGER, cena REAL) RETURNS VARCHAR AS $$
DECLARE
wynik varchar(5) := 'OK';
BEGIN
INSERT INTO FILMY VALUES(id_filmu, tytul, rok_produkcji, cena);
RETURN wynik;
EXCEPTION
WHEN UNIQUE_VIOLATION THEN
RAISE EXCEPTION 'BLEDNY ID';
RETURN 'BLEDNY ID';
END;
$$ LANGUAGE PLPGSQL;

--------------------------------------------------------aaa-

-- 3. Utwórz wyzwalacz UPPER_NAMES i związaną z nim procedurę wyzwalaną
-- UPPER_NAMES_FUN, który każdemu nowo wstawianemu do tabeli PRACOWNICY
-- rekordowi zamieni imię i nazwisko na pisane wielkimi literami.
-- Następnie sprawdź działanie wyzwalacza:
-- insert into pracownicy values(10, 'Jan', 'Kowalski', 'Poznan', 100);
-- select * from pracownicy where id_pracownika=10;

CREATE OR REPLACE FUNCTION UPPER_NAMES_FUN() RETURNS TRIGGER AS $$
DECLARE
  UPid INTEGER;
  UPimie VARCHAR;
  UPnazwisko VARCHAR;
  UPmiasto VARCHAR;
BEGIN
  UPid = UPPER(SELECT id_pracownika from pracownicy);
  UPimie = UPPER(select imie from pracownicy);
  UPnazwisko = UPPER(select nazwisko from pracownicy);
  UPmiasto = UPPER(select miasto from pracownicy);
  INSERT INTO pracownicy VALUES(UPid, UPimie, UPnazwisko, UPmiasto);
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER UPPER_NAMES AFTER INSERT ON pracownicy
  EXECUTE PROCEDURE UPPER_NAMES_FUN(id_pracownika, imie, nazwisko, miasto);

-- Utwórz w języku PL/pgSQL funkcję HIRE(id_pracownika INT, imie VARCHAR, nazwisko
-- VARCHAR, miasto VARCHAR, pensja REAL) służącą do wstawienia nowego rekordu do
-- tabeli PRACOWNICY. Funkcja powinna zwracać wartość tekstową:
-- 
-- 
-- "OK", jeżeli wstawianie rekordu odbędzie się bez zgłoszenia wyjątku
-- "DUPLIKAT ID", jeżeli podczas próby wstawienia rekordu zostanie zgłoszony wyjątek
-- UNIQUE_VIOLATION

CREATE OR REPLACE FUNCTION HIRE(id_pracownika INT, imie VARCHAR, nazwisko VARCHAR, miasto VARCHAR, pensja REAL) RETURNS VARCHAR AS $$
BEGIN
  INSERT INTO PRACOWNICY VALUES (id_pracownika, imie, nazwisko, miasto, pensja);
  RETURN 'OK';
    EXCEPTION
      WHEN UNIQUE_VIOLATION THEN RAISE NOTICE 'Bledne ID';
      RETURN 'Blad';


END;
$$ LANGUAGE PLPGSQL;

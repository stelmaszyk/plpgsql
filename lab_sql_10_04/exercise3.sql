-- Utwórz wyzwalacz DOUBLE_SALARY i związaną z nim procedurę wyzwalaną
-- DOUBLE_SALARY_FUN, który każdemu nowo wstawianemu do tabeli PRACOWNICY
-- rekordowi podwoi wartość kolumny PENSJA.

CREATE OR REPLACE FUNCTION DOUBLE_SALARY_FUN(id_pracownika INT, imie VARCHAR, nazwisko VARCHAR, miasto VARCHAR, pensja REAL) RETURNS TRIGGER AS $$
DECLARE
  pensja2 REAL;
BEGIN
  pensja2:=pensja*2;
  RETURN pensja2;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER DOUBLE_SALARY AFTER INSERT ON PRACOWNICY
  EXECUTE PROCEDURE DOUBLE_SALARY_FUN(pensja);

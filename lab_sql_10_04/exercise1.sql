-- CREATE OR REPLACE FUNCTION PIT(nazwisko VARCHAR, pensja REAL, pit REAL) RETURNS REAL AS $$
-- BEGIN
--   IF pracownicy(pensja)<='85528' THEN
--     pit:=pensja * 0.82;
--     INSERT INTO pracownicy(pit);
--
--   ELSEIF pensja>'85528' THEN
--     pit:=pensja*0.68;
--     INSERT INTO pracownicy(pit);
--   END IF;
-- END;
-- $$ LANGUAGE PLPGSQL;
--

CREATE OR REPLACE FUNCTION PIT(dochod REAL) RETURNS REAL AS $$
DECLARE
  podatek REAL;
BEGIN
  IF dochod<=85528 THEN
    podatek:=dochod * 0.82 - 556.02;

  ELSEIF dochod>85528 THEN
    podatek:= 14839 + ((dochod - 85528)*0.68) ;

  END IF;
  RETURN podatek;
END;
$$ LANGUAGE PLPGSQL;

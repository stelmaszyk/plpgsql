--twórz relację AKTORZY_OPERACJE(data DATE, oper VARCHAR(20)), która posłuży do śledzenia operacji wykonywanych przez użytkownika.

create table AKTORZY_OPERACJE(data DATE, oper VARCHAR(20));


  --Utwórz wyzwalacz reagujący na operacje wprowadzania i usuwania krotek z relacji AKTORZY. Czas i rodzaj każdej operacji wykonywanej na relacji AKTORZY powinien być zapisywany w relacji AKTORZY_OPERACJE. Przetestuj działanie wyzwalacza.

CREATE OR REPLACE FUNCTION oper_add() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO AKTORZY_OPERACJE('now', 'Dodany aktor');
  RETURN NEW;

END;

CREATE OR REPLACE FUNCTION oper_rm(data DATE, oper VARCHAR) RETURNS TRIGGER AS $$
  INSERT INTO AKTORZY_OPERACJE('now', 'Usuniety aktor');
  RETURN NEW;
END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER oper_add AFTER INSERT ON aktorzy
    FOR EACH ROW EXECUTE PROCESURE oper_add();

CREATE TRIGGER oper_rm AFTER DELETE ON AKTORZY
    FOR EACH ROW EXECUTE PROCEDURE oper_rm();

--- WERSJA ROBOCZa - FUNKCJE SĄ DO POŁĄCZENIA, TRIGGERY TEŻ DO POŁĄCZENIA

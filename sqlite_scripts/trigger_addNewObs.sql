create trigger if not exists addNewObs
after insert on historicObservations_cooking
BEGIN
INSERT INTO historicObservations SELECT * FROM historicObservations_cooking;
DELETE from historicObservations_cooking;
--VACUUM;
END;
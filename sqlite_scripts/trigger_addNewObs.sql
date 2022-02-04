create trigger if not exists addNewObs
after update on historicObservations_cooking
BEGIN
INSERT INTO historicObservations SELECT * FROM historicObservations_cooking;
DELETE from historicObservations_cooking;
--VACUUM;
END;
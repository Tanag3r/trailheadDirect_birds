CREATE TRIGGER MODISprop1_dictUpdate
AFTER INSERT ON "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking"
BEGIN
insert into earthdata_dictionary
select locId,file from "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking" as MODISprop1
WHERE MODISprop1.locId not in (SELECT locId from earthdata_dictionary)
;
END
;
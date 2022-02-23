CREATE TRIGGER MODIStype3_dictUpdate
AFTER INSERT ON "MCD12Q1-006-LC-Type3-Statistics.csv_MODIS_cooking"
BEGIN
insert into earthdata_dictionary
select locId,file from "MCD12Q1-006-LC-Type3-Statistics.csv_MODIS_cooking" as MODIStype3
WHERE MODIStype3.locId not in (SELECT locId from earthdata_dictionary)
;
END
;
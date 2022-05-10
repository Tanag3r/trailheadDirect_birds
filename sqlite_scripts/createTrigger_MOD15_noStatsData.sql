CREATE TRIGGER "MOD15_noStatsData"
AFTER INSERT ON "MOD15A2H-006-FparLai-QC-lookup.csv_MODIS_cooking"
BEGIN
INSERT INTO "MOD15A2H-006-Statistics.csv_MODIS_cooking"
SELECT 
	(select max(stats."index") from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as stats)+1 as "index",
	"MOD15A2H_006_FparStdDev_500m_doy2019033_aid0001" as "File Name",
	"Fpar_500m" as Dataset,
	"aid0001" as aid,
	"1975-01-01" as "Date",
	0.0 as "Count",
	0.0 as Minimum,
	0.0 as Maximum,
	"(0.0,0.0)" as "Range",
	0.0 as Mean,
	0.0 as "Standard Deviation",
	0.0 as "Variance",
	0.0 as "Upper Quartile",
	0.0 as "Upper 1.5 IQR",
	0.0 as Median,
	0.0 as "Lower 1.5 IQR",
	0.0 as "Lower Quartile",
	lookup.locId as locId,
	lookup.latestUpdate as latestUpdate
from "MOD15A2H-006-FparLai-QC-lookup.csv_MODIS_cooking" as lookup
where lookup.Value = 157
and lookup.locId not in (select distinct stats2.locId from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as "stats2")
;
END

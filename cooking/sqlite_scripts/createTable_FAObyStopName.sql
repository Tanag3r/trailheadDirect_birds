--Cooked FAO land cover type for each stopName
DROP VIEW "main"."FAO_by_stopName";
CREATE VIEW 'FAO_by_stopName'
AS

select 
	--Hotspots.locName,
	--Hotspots.locId,
	Hotspots.StopName,
	--MCD12Q1Prop1.Date,
	sum(MCD12Q1Prop1."(1) Barren")/3 as 'Barren',
	sum(MCD12Q1Prop1."(3) Water Bodies")/3 as 'Water Bodies',
	sum(MCD12Q1Prop1."(11) Evergreen Needleleaf Forest")/3 as 'Evergreen Needleleaf Forest',
	sum(MCD12Q1Prop1."(12) Evergreen Broadleaf Forests")/3 as 'Evergreen Broadleaf Forests',
	sum(MCD12Q1Prop1."(21) Open Forests")/3 as 'Open Forests',
	sum(MCD12Q1Prop1."(15) Mixed Broadleaf/Needleleaf Forests")/3 as 'Mixed Broadleaf/Needleleaf Forests',
	sum(MCD12Q1Prop1."(22) Sparse Forests")/3 as 'Spare Forests',
	sum(MCD12Q1Prop1."(31) Dense Herbaceous")/3 as 'Dense Herbaceous',
	sum(MCD12Q1Prop1."(32) Sparse Herbaceous")/3 as 'Sparse Herbaceous',
	sum(MCD12Q1QAQC."0")/3 as 'cleanPixels'
from Hotspots 

left outer join "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking" as MCD12Q1Prop1 on MCD12Q1Prop1.locId = Hotspots.locId
left outer join "MCD12Q1-006-QC-Statistics-QA.csv_MODIS_cooking" as MCD12Q1QAQC on MCD12Q1Prop1.locId = MCD12Q1QAQC.locId
--where StopName = 'MargaretsWay'
group by StopName
;
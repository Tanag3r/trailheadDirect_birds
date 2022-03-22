--DROP VIEW "main"."FAO_by_locId";
--CREATE VIEW 'FAO_by_locId'
--AS
select
	Hotspots.locName,
	Hotspots.locId,
	--MCD12Q1Prop1.Date,
	round((avg(MCD12Q1Prop1."(1) Barren")/avg(MCD12Q1QAQC."0")),2) as 'Barren',
	round((avg(MCD12Q1Type3."(10) Urban and Built-up Lands")/avg(MCD12Q1QAQC."0")),2) as 'Urban',
	round((avg(MCD12Q1Type3."(1) Grasslands")/avg(MCD12Q1QAQC."0")),2) as 'Grasslands',
	round((avg(MCD12Q1Type3."(4) Savannas")/avg(MCD12Q1QAQC."0")),2) as 'Savannas',
	round((avg(MCD12Q1Prop1."(3) Water Bodies")/avg(MCD12Q1QAQC."0")),2) as 'waterBodies',
	round((avg(MCD12Q1Prop1."(11) Evergreen Needleleaf Forest")/avg(MCD12Q1QAQC."0")),2) as 'evergreenNeedleleafForest',
	round((avg(MCD12Q1Prop1."(12) Evergreen Broadleaf Forests")/avg(MCD12Q1QAQC."0")),2) as 'evergreenBroadleafForests',
	round((avg(MCD12Q1Prop1."(21) Open Forests")/avg(MCD12Q1QAQC."0")),2) as 'openForests',
	round((avg(MCD12Q1Prop1."(15) Mixed Broadleaf/Needleleaf Forests")/avg(MCD12Q1QAQC."0")),2) as 'mixedBroadleafandNeedleleafForests',
	round((avg(MCD12Q1Type3."(6) Deciduous Broadleaf Forests")/avg(MCD12Q1QAQC."0")),2) as 'deciduousBroadleafForests',
	round((avg(MCD12Q1Prop1."(22) Sparse Forests")/avg(MCD12Q1QAQC."0")),2) as 'sparseForests',
	round((avg(MCD12Q1Prop1."(31) Dense Herbaceous")/avg(MCD12Q1QAQC."0")),2) as 'denseHerbaceous',
	round((avg(MCD12Q1Prop1."(32) Sparse Herbaceous")/avg(MCD12Q1QAQC."0")),2) as 'sparseHerbaceous'

from Hotspots 

left outer join "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking" as MCD12Q1Prop1 on Hotspots.locId = MCD12Q1Prop1.locId
left outer join "MCD12Q1-006-LC-Type3-Statistics.csv_MODIS_cooking" as MCD12Q1Type3 on Hotspots.locId = MCD12Q1Type3.locId
left outer join "MCD12Q1-006-QC-Statistics-QA.csv_MODIS_cooking" as MCD12Q1QAQC on MCD12Q1Prop1.locId = MCD12Q1QAQC.locId


group by MCD12Q1Prop1.locId,locName
order by Hotspots.locId
;
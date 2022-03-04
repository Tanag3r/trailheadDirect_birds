--Cooked FAO land cover type for each stopName
select 
	--Hotspots.locName,
	--Hotspots.locId,
	Hotspots.StopName,
	MCD12Q1Prop1.Date,
	avg(MCD12Q1Prop1."(1) Barren") as 'Barren',
	avg(MCD12Q1Prop1."(3) Water Bodies") as 'Water Bodies',
	avg(MCD12Q1Prop1."(11) Evergreen Needleleaf Forest") as 'Evergreen Needleleaf Forest',
	avg(MCD12Q1Prop1."(12) Evergreen Broadleaf Forests") as 'Evergreen Broadleaf Forests',
	avg(MCD12Q1Prop1."(21) Open Forests") as 'Open Forests',
	avg(MCD12Q1Prop1."(15) Mixed Broadleaf/Needleleaf Forests") as 'Mixed Broadleaf/Needleleaf Forests',
	avg(MCD12Q1Prop1."(22) Sparse Forests") as 'Spare Forests',
	avg(MCD12Q1Prop1."(31) Dense Herbaceous") as 'Dense Herbaceous',
	avg(MCD12Q1Prop1."(32) Sparse Herbaceous") as 'Sparse Herbaceous',
	avg(MCD12Q1QAQC."0") as 'cleanPixels'
from Hotspots 

left outer join "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking" as MCD12Q1Prop1 on MCD12Q1Prop1.locId = Hotspots.locId
left outer join "MCD12Q1-006-QC-Statistics-QA.csv_MODIS_cooking" as MCD12Q1QAQC on MCD12Q1Prop1.locId = MCD12Q1QAQC.locId

--where StopName = 'MargaretsWay'
group by StopName,MCD12Q1Prop1.Date
;
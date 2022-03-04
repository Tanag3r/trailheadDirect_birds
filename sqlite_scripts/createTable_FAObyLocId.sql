--Cooked FAO land cover type for each locId
select
	Hotspots.locName,
	Hotspots.locId,
	--MCD12Q1Prop1.Date,
	round((avg(MCD12Q1Prop1."(1) Barren")/avg(MCD12Q1QAQC."0")),2) as 'Barren',
	round((avg(MCD12Q1Prop1."(3) Water Bodies")/avg(MCD12Q1QAQC."0")),2) as 'Water Bodies',
	MCD12Q1Prop1."(3) Water Bodies" as 'Water',
	round((avg(MCD12Q1Prop1."(11) Evergreen Needleleaf Forest")/avg(MCD12Q1QAQC."0")),2) as 'Evergreen Needleleaf Forest',
	round((avg(MCD12Q1Prop1."(12) Evergreen Broadleaf Forests")/avg(MCD12Q1QAQC."0")),2) as 'Evergreen Broadleaf Forests',
	round((avg(MCD12Q1Prop1."(21) Open Forests")/avg(MCD12Q1QAQC."0")),2) as 'Open Forests',
	round((avg(MCD12Q1Prop1."(15) Mixed Broadleaf/Needleleaf Forests")/avg(MCD12Q1QAQC."0")),2) as 'Mixed Broadleaf/Needleleaf Forests',
	round((avg(MCD12Q1Prop1."(22) Sparse Forests")/avg(MCD12Q1QAQC."0")),2) as 'Spare Forests',
	round((avg(MCD12Q1Prop1."(31) Dense Herbaceous")/avg(MCD12Q1QAQC."0")),2) as 'Dense Herbaceous',
	round((avg(MCD12Q1Prop1."(32) Sparse Herbaceous")/avg(MCD12Q1QAQC."0")),2) as 'Sparse Herbaceous',
	round(avg(MCD12Q1QAQC."0"),2) as 'cleanPixels',
	MCD12Q1QAQC."0" as 'Pixels'
from Hotspots 

left outer join "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking" as MCD12Q1Prop1 on Hotspots.locId = MCD12Q1Prop1.locId
left outer join "MCD12Q1-006-QC-Statistics-QA.csv_MODIS_cooking" as MCD12Q1QAQC on MCD12Q1Prop1.locId = MCD12Q1QAQC.locId

--where StopName = 'MargaretsWay'
group by MCD12Q1Prop1.locId,locName
order by Hotspots.locId
;
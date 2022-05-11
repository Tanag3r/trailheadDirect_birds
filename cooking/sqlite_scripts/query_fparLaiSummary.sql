WITH "fparLaiSummary" as (
SELECT
	fpar.Date as "readingDate",
	fpar.Mean as "fparMean",
	(lead(fpar.Mean,1) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLead",
	(lag(fpar.Mean,1) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLag",
	laiMean,
	laiLead,
	laiLag,
	fpar.locId as "locId",
	(select habitatLabel from Hotspots where Hotspots.locId=fpar.locId) as "habitatLabel"
from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as fpar
left join
	(select
		leafArea.locId as "lai_locId",
		leafArea."Date" as "lai_date",
		CASE WHEN leafArea.Mean <= 0 THEN 0.1 ELSE leafArea.Mean END as "laiMean",
		(lead(leafArea.Mean,1) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLead",
		(lag(leafArea.Mean,1) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLag"
	from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as leafArea where leafArea.Dataset = 'Lai_500m' order by leafArea.locId desc,leafArea."Date" asc) 
as lai on lai.lai_locId = fpar.locId and lai.lai_date = fpar.Date
where fpar.Dataset = 'Fpar_500m'
and readingDate not like '19%'
order by fpar.locId desc,readingDate asc
)
select
	readingDate,
	locId,
	habitatLabel,
	CASE WHEN 
		laiMean-laiLead >=3 AND laiMean-laiLag >=3 THEN ((laiLead+laiLag)/2)
		else LaiMean end as "laiMean",
	CASE WHEN
		fparMean-fparLead >=0.3 AND fparMean-fparLag >=0.3 THEN ((fparLead+fparLag)/2)
		else fparMean end as "fparMean"
from fparLaiSummary
where habitatLabel = 7
;


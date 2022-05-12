WITH "fparLaiSummary" as (
SELECT
	fpar.Date as "readingDate",
	fpar.Mean as "fparMean",
	(lead(fpar.Mean,1) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLead",
	(lead(fpar.Mean,2) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLead2",
	(lag(fpar.Mean,1) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLag",
	(lag(fpar.Mean,2) over(order by fpar.locId desc,fpar."Date" asc)) as "fparLag2",
	laiMean,
	laiLead,
	laiLead2,
	laiLag,
	laiLag2,
	goodReads,
	badReads,
	deadPixels,
	fpar.locId as "locId",
	(select habitatLabel from Hotspots where Hotspots.locId=fpar.locId) as "habitatLabel"
from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as fpar
left join
	(select
		leafArea.locId as "lai_locId",
		leafArea."Date" as "lai_date",
		CASE WHEN leafArea.Mean = 0.0 THEN leafArea.Mean+0.1 ELSE leafArea.Mean END as "laiMean",
		(lead(leafArea.Mean,1) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLead",
		(lead(leafArea.Mean,2) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLead2",
		(lag(leafArea.Mean,1) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLag",
		(lag(leafArea.Mean,2) over(order by leafArea.locId desc,leafArea."Date" asc)) as "laiLag2"
	from "MOD15A2H-006-Statistics.csv_MODIS_cooking" as leafArea where leafArea.Dataset = 'Lai_500m' order by leafArea.locId desc,leafArea."Date" asc) 
as lai on lai.lai_locId = fpar.locId and lai.lai_date = fpar.Date
left join
	(select qaqc.locId as "qa_locId",qaqc."Date" as "qa_date",qaqc.goodReads,qaqc.badReads,qaqc."157" as "deadPixels"
	from "MOD15A2H-006-FparLai-QC-Statistics-QA.csv_MODIS_cooking" as qaqc)
as qa on qa.qa_locId=fpar.locId AND qa.qa_date=fpar.Date
where fpar.Dataset = 'Fpar_500m'
and readingDate not like '19%'
order by fpar.locId desc,readingDate asc
)
select
	readingDate,
	locId,
	habitatLabel,
	goodReads,
	badReads,
	CASE WHEN 
		laiMean-laiLead >=3 AND laiMean-laiLag >=3 THEN ((laiLead+laiLead2+laiLag2+laiLag)/4)
		when deadPixels >= goodReads and ((laiLead+laiLag)/2)!= 0 then ((laiLead+laiLead2+laiLag2+laiLag)/4)
		when badReads >=goodReads THEN ((laiLead+laiLead2+laiLag2+laiLag)/4)
		when laiMean = 0 then ((laiLead+laiLead2+laiLag2+laiLag)/4)
		else laiMean end as "adj_laiMean",
	CASE WHEN
		fparMean-fparLead >=0.3 AND fparMean-fparLag >=0.3 THEN ((fparLead+fparLead2+fparLag2+fparLag)/4)
		when deadPixels >= goodReads and ((fparLead+fparLag)/2)!=0 then ((fparLead+fparLead2+fparLag2+fparLag)/4)
		when badReads >= goodReads THEN ((fparLead+fparLead2+fparLag2+fparLag)/4)
		when fparMean = 0 then ((fparLead+fparLead2+fparLag2+fparLag)/4)
		else fparMean end as "adj_fparMean"
from fparLaiSummary
where habitatLabel = 2
;


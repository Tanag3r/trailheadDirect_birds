with habitatAbundance as (
select
	date(obsDt) as "obsDt",
	(strftime('%Y',obsDt)||'-'||strftime('%W',obsDt)) as "year_week",
	round(avg(howMany),3) as "habitatVolume",
	(total(round(avg(howMany),3)) over(partition by strftime('%Y',obsDt)||'-'||strftime('%W',obsDt))) as "volume_allHabitats",
	(avg(howMany) over(PARTITION BY strftime('%Y',obsDt))) as "annualAvgAbd",
	habitatLabel 
from historicObservations as hsob
left join (select locId,habitatLabel from Hotspots) as "labels" on hsob.locId=labels.locId
where speciesCode = 'westan'
group by year_week,habitatLabel
)
select obsDt,year_week,
habitatLabel,
--selection ratio as a function of weekly observations
round((habitatVolume/volume_allHabitats),3) as "weekly_selectionRatio_",
--selection ratio as a function of the annual relative abundance
round((habitatVolume/annualAvgAbd),3) as "annual_selectionRatio_"
from habitatAbundance
where habitatLabel = 2
order by obsDt asc
;

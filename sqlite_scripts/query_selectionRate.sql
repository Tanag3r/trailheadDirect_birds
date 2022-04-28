with habitatAbundance as (
select
	date(obsDt) as "obsDt",
	(strftime('%Y',obsDt)||'-'||strftime('%W',obsDt)) as "year_week",
	round(avg(howMany),0) as "habitatVolume",
	(total(round(avg(howMany),0)) over(partition by strftime('%Y',obsDt)||'-'||strftime('%W',obsDt))) as "volume_allHabitats",
	habitatLabel 
from historicObservations as hsob
left join (select locId,habitatLabel from Hotspots) as "labels" on hsob.locId=labels.locId
where speciesCode = 'westan'
group by year_week,habitatLabel
)
select obsDt,year_week,habitatVolume,round((habitatVolume/volume_allHabitats),2) as "selectionRatio_"
from habitatAbundance
where habitatLabel = 2
;

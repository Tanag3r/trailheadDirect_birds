select
	strftime('%Y',obsDt) as "year",
	strftime('%W',obsDt) as "WoY",
	(howMany/(avg(howMany) over (PARTITION by strftime('%Y',obsDt)))) as "relativeAbundance",
	habitatLabel 
from historicObservations
left join (select locId,habitatLabel from Hotspots) as "labels" on historicObservations.locId=labels.locId
where speciesCode = 'westan'
ORDER by habitatLabel,year asc,WoY asc
;
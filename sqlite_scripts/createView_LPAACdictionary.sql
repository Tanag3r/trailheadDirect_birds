CREATE VIEW 'lpdaac_dictionary'
AS

select 
	locId,File,
	case 
		when File like 'LC\_Prop1%' escape '\' then 'LC_Prop1' 
		when File like 'LC\_Type3%' escape '\' then 'LC_Type3'
		end as 'LPDAACkey' 
from "MCD12Q1-006-LC-Prop1-Statistics.csv_MODIS_cooking"
UNION
select
	locId,File,
	case 
		when File like 'LC\_Prop1%' escape '\' then 'LC_Prop1' 
		when File like 'LC\_Type3%' escape '\' then 'LC_Type3' 
		end as 'LPDAACkey' 
from "MCD12Q1-006-LC-Type3-Statistics.csv_MODIS_cooking"
;




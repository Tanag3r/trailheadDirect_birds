DROP VIEW "main"."lpdaac_dictionary";
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
UNION
select
	locId,Dataset as 'File',
	case
		when Dataset like 'Fpar\_500m%' escape '\' then 'Fpar_500m'
		when Dataset like 'FparStdDev\_500m%' escape '\' then 'FparStdDev_500m'
		when Dataset like 'Lai\_500m%' escape '\' then 'Lai_500m'
		when Dataset like 'LaiStdDev\_500m%' escape '\' then 'LaiStdDev_500m'
		end as 'LPDAACkey'
from "MOD15A2H-006-Statistics.csv_MODIS_cooking";
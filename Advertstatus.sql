declare @Total int
declare @Accepted int

select @Total=count(*), @Accepted=sum(case LastState when 0 then 0 else 1 end)
from v_ClientAdvertisementStatus 
where AdvertisementID='SPS201CE'

select LastAcceptanceStateName as C013, count(*) as C015, 
      ROUND(100.0*count(*)/@Total,1) as C016,
AdvertisementID
from v_ClientAdvertisementStatus 
where AdvertisementID='SPS201CE'
group by LastAcceptanceStateName, AdvertisementID

select LastStateName as C017, count(*) as C015, 
       ROUND(100.0*count(*)/@Accepted,1)  as C016,
AdvertisementID
from v_ClientAdvertisementStatus 
where AdvertisementID='SPS201CE' and LastState!=0
group by LastStateName, AdvertisementID
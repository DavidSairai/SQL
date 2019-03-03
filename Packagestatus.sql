select
SUBSTRING(dp.ServerNALPath, CHARINDEX('\\', dp.ServerNALPath) + 2, CHARINDEX('"]', dp.ServerNALPath) - CHARINDEX('\\', dp.ServerNALPath) - 3 ) AS C070, 
dp.SiteCode,
stat.SourceVersion,
pstat.UpdateTime,
stat.InstallStatus,
dp.PackageID
from v_DistributionPoint dp
left join v_PackageStatusDistPointsSumm stat on dp.ServerNALPath=stat.ServerNALPath
                                             and dp.PackageID=stat.PackageID
left join v_PackageStatus pstat on dp.ServerNALPath=pstat.PkgServer 
                                  and dp.PackageID=pstat.PackageID
where dp.PackageID= 'SPS000D1'
select
SUBSTRING(dp.ServerNALPath, CHARINDEX('\\', dp.ServerNALPath) + 2, CHARINDEX('"]', dp.ServerNALPath) - CHARINDEX('\\', dp.ServerNALPath) - 3 ) AS C070, 
dp.SiteCode,
stat.SourceVersion,
pstat.UpdateTime,
stat.InstallStatus,
dp.PackageID
from v_DistributionPoint dp
left join v_PackageStatusDistPointsSumm stat on dp.ServerNALPath=stat.ServerNALPath
                                             and dp.PackageID=stat.PackageID
left join v_PackageStatus pstat on dp.ServerNALPath=pstat.PkgServer 
                                  and dp.PackageID=pstat.PackageID
where dp.PackageID='SPS000D1'
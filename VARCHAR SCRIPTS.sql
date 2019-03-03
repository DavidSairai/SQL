select * from uc_instoresetup
update uc_instoresetup
set
MSQueueDirectIn = 'DIRECT=OS:FOSWORCESTER\private$\AR015087InBound',
MSQueueDirectCon = 'DIRECT=OS:FOSWORCESTER\private$\015087Con'


select * from uc_hhdevice

update uc_hhdevice
set
DfltArchiveDirectory = '\\FOSWORCESTER\StockTakes\Archive',
DfltInputDirectory = '\\FOSWORCESTER\StockTakes\Data1\015087'

select * from fos_settings_pos
where type = 'version'

Update fos_settings_pos
set description = '1.6.68 SERVICE PACK AR2015.1'
where type = 'version'
**************************************************************

Select transbalanceid from uc_transbalance order by transbalanceid desc

**********************************************************************************
********************************************************
REMOVE PKG IN A LOOP ON DP

1.Go to the distmgr inbox on the DP that you have issue with

Look for the .PCK file for the package and delete it.

e.g ABC001D2.PCK 

2.Backup the SCCM DB and then run the following queries:

Delete from pkgstatus where SiteCode = 'SEC' and ID = 'ABC001D2'

DELETE from PkgServers where SiteCode =  'SEC' and PkgID =  'ABC001D2'

***********************************************************************
SELECT * from uc_syncdistribution (nolock)
where siteserver like '%manda%'
*****************************************************************
ALTER DATABASE ar000963
SET MULTI_USER;
GO
************************************************************************

sync '000881'

*******************************************************************
STORE TIME CLOSE

Select transbalanceid from uc_transbalance 
where transbalanceid like '%oct%'
order by transbalanceid desc

***************************************************************
FOS_Windows7_TakeOn '010094'

*************************************************************

--USE IN SQLHOBO on ARSUPPORT DB ->davidsa
use arsupport --
go
select * from arsupport..all_servers --(ALL_SERVERS VIEW)
where dbservername like 'a%' 
or dbservername like 'd%' 
or dbservername like 'e%'
or dbservername like 'c%'
or dbservername like 'f%' 
or dbservername like 'h%'
or dbservername like 'l%'
or dbservername like 'm%'
or dbservername like 's%'
or dbservername like 'r%'
or dbservername like 't%'
and DBSERVERNAME not like 'T0%'
and DBSERVERNAME not like 'T3%'
--or dbservername like '---

******************************************************************
Shows Number of workstations
select * From fos_workstation
************************************************************************
select * from uc_syncdistribution (nolock)
where rowguid = '5F8AA82A-9AB4-44A3-ACE9-A604A4F69E89'
/*
 = '000273'

*/


begin tran

update uc_syncdistribution
set dbservername = 'FOSUMTATA', //OLD SERVER NAME
msqueuedirectin = 'DIRECT=OS:FOSUMTATA\private$\AR000273InBound', //CHANGE FROM NEW SERVER *ADM TO OLD SERVER
transactionserver = 'W000273ADM', //OLD ADMIN
rowstatus = rowstatus | 2048 //CHANGES ISYNCDIRTY FLAG
where rowguid = '4B1BCF31-B277-449B-9934-F646FA8E35FA' //UNIQUE ROW ID

commit
*******************************************************************************

USE AR4Common
 GO
DBCC CHECKDB (AR4Common)
 GO
 BACKUP DATABASE [AR4Common] TO DISK = N'C:\SQLbackup\AR4Common_201407230658.bak' 
WITH Name = 'AR4Common',  STATS = 10,  FORMAT

*********************************************************************************

USE [AR4HO]
GO
/****** Object:  StoredProcedure [dbo].[SYNC]    Script Date: 09/03/2014 07:28:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER    PROCEDURE [dbo].[SYNC]  
  
 @BranchID varchar(6)  
  
AS  
  
begin

SELECT RTRIM(s1.SyncDistributionID) AS "Branch Number", RTRIM(s1.DBServerName) AS "Server Name", RTRIM(s1.TransactionServer) AS "Admin Workstation",   
 RTRIM(s1.[Name]) AS "Branch Name", RTRIM(s1.SiteServer) AS "Site Server",RTRIM(s2.[Name]) AS "Distribution Server",   
 CASE s1.IsDeleted   
   WHEN 0 THEN 'Store Open'  
     ELSE 'Store Closed'  
 END AS "Status",  
 s1.originid as BranchID,  
 bd.BrandID,
 br.EFTEnabled, br.RefundRemoteLoad, br.RepairsEnabled, br.AuthManualCard, br.Name  , s1.*
FROM UC_SyncDistribution s1  
JOIN UC_SyncDistribution s2 on s2.rowguid = s1.SourceDSSID  
JOIN UC_Branch br on br.RowGUID = s1.OriginID  
JOIN UC_Brand bd on bd.RowGUID = br.BrandID
WHERE s1.SyncDistributionID LIKE '%'+@BranchID  
order by s1.DBServerName, s1.SyncDistributionID

end
******************************************************************************************
================================================================================================================

select 'truncate table AR020338..' + name +  ';'
from sysobjects
where type = 'U'
and name in
	(
'UC_CasualEmployee', 'UC_CasualPayment', 'UC_Cellproduct', 'UC_CustPlanPmt', 'UC_CustPlanPmtDet',
'UC_CustPlanRefund', 'UC_CustPlanRefDet', 'UC_CustPmtInf', 'UC_CustRefInf', 'UC_GiftReg',
'UC_GiftRegDet', 'UC_IBTIn', 'UC_IBTInDetail', 'UC_IBTOut', 'UC_IBTOutDetail',
'UC_InsuranceClaim', 'UC_ItemAdjustment', 'UC_ItemAdjDetail', 'UC_ItemReceipt',
'UC_ItemRecDetail', 'UC_ItemReturn', 'UC_ItemRetDetail', 'UC_LoyaltyCustomer', 'UC_Note',
'UC_NoteDetail', 'UC_PCBudgetMaint', 'UC_PCBudgetDetail', 'UC_PCCredit', 'UC_PCCreditDetail',
'UC_PCIssue', 'UC_PCIssueDetail', 'UC_PCVoucher', 'UC_PCVoucherDetail', 'UC_PosInf',
'UC_POSTransaction', 'UC_POSTranDet', 'UC_Repair', 'UC_RepairDet', 'UC_RepairNotes',
'UC_RepairPVCfg', 'UC_RepairPVCfgDet', 'UC_RepairQuote', 'UC_RepairQuoteDet', 'UC_RepairRecall',
'UC_RepairRecallDet', 'UC_RepairReceipt', 'UC_RepairReceiptDet', 'UC_RepairRO', 'UC_RepairRODet',
'UC_SDAPOSTransaction', 'UC_SDACustPlanPmtDet', 'UC_SDACustPlanPmt', 'UC_SDACustPlanRefDet', 'UC_SDAPOSInf',
'UC_SDACustPlanRefund', 'UC_SDAExportInfo', 'UC_SDAImportLog', 'UC_SDAPOSTranDet', 'UC_SDATenderDetail',
'UC_SDATenderProp', 'UC_SDATender', 'UC_Tender', 'UC_TenderDetail', 'UC_TenderBanking',
'UC_TenderBankingDet', 'UC_TenderCashup', 'UC_TenderCashupDet', 'UC_TenderLift', 'UC_TenderLiftDetail',
'UC_TenderProp', 'UC_TransactionNbr', 'UC_User', 'UC_WorkOrder', 'UC_WorkOrderHist',
'UC_WorkOrderHistDet', 'UC_Workstation', 'UC_WorkstationDet', 'UC_Store', 'UC_Transbalance', 'UC_Transbalancedet'
	)
*******************************************************************************************************************
================================================================================================

/*
SELECT * from uc_syncdistribution (nolock)
where syncdistributionid like '330%'

SELECT * from uc_syncdistribution (nolock)
where siteserver like 'FOSNORTHMALL8%'
*/
================================================================================================
--If the user forgot the password or deleted themselves.
--Run this script

select us.isdeleted, us.userid, us.name, rp.roleid, us.password, us.maxlogins
from uc_user us
left join uc_userrole ro on us.rowguid = ro.userid
left join uc_role rp on rp.rowguid = ro.roleid
where us.[name] like '%Lelanie%'
order by us.userid

--To check if any sales person was deleted 
--if isdeleted = 1 (that sales person is deleted )
--if isdeleted = 0 (that sales person still exist)
**************************************************************************************************************************

--If you get cannot insert duplicate key row in object...with PK contstraint;
--when you run the below script when adding the administrator in the database. 


When the administrator/admin_temp/ceb/manager does not exist on the database

-- This is to check if all roles don't exist
select * from uc_user
where userid in ('admin_temp','administrator')
---------------------------------------------------------------------------------------------

--check that this rowguid for the administrator does not exist against another user, namely a store user.
select * from uc_user 
where rowguid = '26084707-85A1-4817-80C0-42DE56F73BF0'     

-- delete this rowguid from the table
delete from uc_user 
where rowguid = '26084707-85A1-4817-80C0-42DE56F73BF0'            --default rowguid for the administrator
----------------------------------------------------------------------------------------------

-- check this rowguid against uc_userrole, if there delete from uc_userrole
-- once completed then run the below script to create the administrator.

select * from uc_userrole
where userid = '26084707-85A1-4817-80C0-42DE56F73BF0'

delete from uc_userrole
where userid = '26084707-85A1-4817-80C0-42DE56F73BF0'
-----------------------------------------------------------------------------------------------

--Creating the administrator in the database

delete
from uc_userrole
where userid in
(
select rowguid
from uc_user
where userid in
('admin_temp'))
GO

delete
from uc_user
where userid in
('admin_temp')
GO


insert    UC_User
(              RowGUID
,               OriginID
,               UserID
,               Name
,               CardNoXRef
,               CommPct
,               InsertID
,               IntegratedNTLogon
,               IsGlobal
,               MembershipID1
,               MembershipID
,               MaxLogins
,               MHLCanShare
,               MHLFixedInsert
,               MHLMoneyBag
,               MHLOwnInsert
,               NTDomain
,               Password
,               PasswordCardNo
,               Status
,               NoteID
,               RowStatus
,               CrDateTime
,               CrProg
,               CrUser
,               LmDateTime
,               LmProg
,               LmUser)

select    '{26084707-85A1-4817-80C0-42DE56F73BF0}', NULL, 'admin_temp', 'admin_temp'
                                , '', 0, 'admin_temp', -1, NULL, NULL, NULL, 20, -1, -1, 0, 0, '', '', NULL, NULL
                                , NULL, 1, '13 Mar 2003', 'GenMRD', 'admin_temp', '13 Mar 2003', 'GenMRD', 'admin_temp'

GO

insert    UC_UserRole
(              RowGUID
,               OriginID
,               RoleID
,               UserID
,               NoteID
,               RowStatus
,               CrDateTime
,               CrProg
,               CrUser
,               LmDateTime
,               LmProg
,               LmUser)

select                    '{17D83993-7465-4ADB-B1BF-A2F6226BA0B2}', NULL, '{12D5F73A-FFE8-491B-B87D-234791BED22D}'
                                , '{26084707-85A1-4817-80C0-42DE56F73BF0}', NULL, 1, '03 Oct 2001', 'GenMRD', 'Antoinette'
                                , '03 Oct 2001', 'GenMRD', 'Antoinette'
union select       '{3252BF46-E1D6-49A0-9419-D68C57BE3E33}', NULL, '{919BBF88-4561-45CF-907C-16F378EEF8A0}'
                                , '{26084707-85A1-4817-80C0-42DE56F73BF0}', NULL, 1, '03 Oct 2001', 'GenMRD', 'Antoinette'
                                , '03 Oct 2001', 'GenMRD', 'Antoinette'
union select       '{73FD7BA1-BF6D-4A76-8270-8A6A07AC4E74}', NULL, '{9510FA0B-19B9-44F3-B6B8-ADB24FBC81A0}'
                                , '{26084707-85A1-4817-80C0-42DE56F73BF0}', NULL, 1, '03 Oct 2001', 'GenMRD', 'Antoinette'
                                , '03 Oct 2001', 'GenMRD', 'Antoinette'
union select       '{77EB7758-AC76-4E56-9CE3-7F5A611CE931}', NULL, '{BB2C2A18-3B37-4EAD-8C57-DF6F0BCDFD77}'
                                , '{26084707-85A1-4817-80C0-42DE56F73BF0}', NULL, 1, '03 Oct 2001', 'GenMRD', 'Antoinette'
                                , '03 Oct 2001', 'GenMRD', 'Antoinette'
GO
****************************************************************************************************************
SORT OUT FAILING SCCM PACKAGES

---Delete from pkgstatus where SiteCode = '3FZ' and ID = 'C0100056'

---DELETE from PkgServers where SiteCode =  '3FZ' and PkgID =  'C0100056'

---Select * from  pkgstatus where SiteCode = '3FZ' and ID = 'C0100056'

---select * from PkgServers where SiteCode =  '3FZ' and PkgID =  'C0100056'

---update pkgstatus set Status = 2 where id = 'C0100056' and sitecode = '3FZ' and type = 1

----update pkgstatus set SourceVersion = 0 where id = 'C0100056' and sitecode = '3FZ' and type = 1
*****************************************************************************************************************************************

select 'truncate table AR020338..' + name +  ';'
from sysobjects
where type = 'U'
and name in
	(
'UC_CasualEmployee', 'UC_CasualPayment', 'UC_Cellproduct', 'UC_CustPlanPmt', 'UC_CustPlanPmtDet',
'UC_CustPlanRefund', 'UC_CustPlanRefDet', 'UC_CustPmtInf', 'UC_CustRefInf', 'UC_GiftReg',
'UC_GiftRegDet', 'UC_IBTIn', 'UC_IBTInDetail', 'UC_IBTOut', 'UC_IBTOutDetail',
'UC_InsuranceClaim', 'UC_ItemAdjustment', 'UC_ItemAdjDetail', 'UC_ItemReceipt',
'UC_ItemRecDetail', 'UC_ItemReturn', 'UC_ItemRetDetail', 'UC_LoyaltyCustomer', 'UC_Note',
'UC_NoteDetail', 'UC_PCBudgetMaint', 'UC_PCBudgetDetail', 'UC_PCCredit', 'UC_PCCreditDetail',
'UC_PCIssue', 'UC_PCIssueDetail', 'UC_PCVoucher', 'UC_PCVoucherDetail', 'UC_PosInf',
'UC_POSTransaction', 'UC_POSTranDet', 'UC_Repair', 'UC_RepairDet', 'UC_RepairNotes',
'UC_RepairPVCfg', 'UC_RepairPVCfgDet', 'UC_RepairQuote', 'UC_RepairQuoteDet', 'UC_RepairRecall',
'UC_RepairRecallDet', 'UC_RepairReceipt', 'UC_RepairReceiptDet', 'UC_RepairRO', 'UC_RepairRODet',
'UC_SDAPOSTransaction', 'UC_SDACustPlanPmtDet', 'UC_SDACustPlanPmt', 'UC_SDACustPlanRefDet', 'UC_SDAPOSInf',
'UC_SDACustPlanRefund', 'UC_SDAExportInfo', 'UC_SDAImportLog', 'UC_SDAPOSTranDet', 'UC_SDATenderDetail',
'UC_SDATenderProp', 'UC_SDATender', 'UC_Tender', 'UC_TenderDetail', 'UC_TenderBanking',
'UC_TenderBankingDet', 'UC_TenderCashup', 'UC_TenderCashupDet', 'UC_TenderLift', 'UC_TenderLiftDetail',
'UC_TenderProp', 'UC_TransactionNbr', 'UC_User', 'UC_WorkOrder', 'UC_WorkOrderHist',
'UC_WorkOrderHistDet', 'UC_Workstation', 'UC_WorkstationDet', 'UC_Store', 'UC_Transbalance', 'UC_Transbalancedet'
	)

=======================================================================================================================
EXCEL TIPS
REMOVE START OF CHARACTER
=RIGHT(A1, LEN(A1)-1)
REMOVE END OF CHARACTER
=LEFT(A1, LEN(A1)-3)

COUNT TOTAL OF TERMIANLS
=COUNTIF($A$1:A2000,A1)


================================================================================================



/*
SELECT * from uc_syncdistribution (nolock)
where syncdistributionid like '330%'

SELECT * from uc_syncdistribution (nolock)
where siteserver like 'FOSNORTHMALL8%'
*/
================================================================================================
--If the user forgot the password or deleted themself.
--Run this script

select us.isdeleted, us.userid, us.name, rp.roleid, us.password, us.maxlogins
from uc_user us
left join uc_userrole ro on us.rowguid = ro.userid
left join uc_role rp on rp.rowguid = ro.roleid
where us.[name] like '%Lelanie%'
order by us.userid

--To check if any sales person was deleted 
--if isdeleted = 1 (that sales person is deleted )
--if isdeleted = 0 (that sales person still exist)

declare @AuthListLocalID as int
select @AuthListLocalID=CI_ID from v_AuthListInfo where CI_UniqueID=@AuthListID

select CI_UniqueID as AuthorizationListID, 
Title as AuthorizationListName 
from v_AuthListInfo where CI_UniqueID=@AuthListID

select 
	
	BulletinID as BulletinID,
	Title as Title,
	NumPresent as Present,
	NumMissing as Missing,
	NumNotApplicable as NotApplicable, 
	NumUnknown as Unknown,
	NumTotal as Total,
	PCompliant=case when NumTotal<>0 then CAST((NumPresent+NumNotApplicable)*100.0/NumTotal as numeric(5,2)) else 0.0 end,
	PNotCompliant=case when NumTotal<>0 then CAST((NumMissing)*100.0/NumTotal as numeric(5,2)) else 0.0 end, 
	PUnknown=case when NumTotal<>0 then CAST((NumUnknown)*100.0/NumTotal as numeric(5,2)) else 0.0 end,
	@CollID as CollectionID,
	UniqueUpdateID=ui.CI_UniqueID
from v_CIRelation cir 
join  v_UpdateInfo ui on cir.ToCIID = ui.CI_ID
join (v_CICategories_All catall join v_CategoryInfo catinfo on catall.CategoryInstance_UniqueID = catinfo.CategoryInstance_UniqueID and catinfo.CategoryTypeName='Company') 
	on catall.CI_ID=ui.CI_ID
left join v_CITargetedCollections col on col.CI_ID=ui.CI_ID and col.CollectionID=@CollID
join v_UpdateSummaryPerCollection us on us.CI_ID=ui.CI_ID and us.CollectionID=@CollID
where cir.FromCIID=@AuthListLocalID and cir.RelationType=1

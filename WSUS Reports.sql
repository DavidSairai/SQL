-- Find computers within a target group that need updates

-- which have been approved for install for at least N days

USE SUSDB


DECLARE @TargetGroup nvarchar(30)


DECLARE @Days int


SELECT @TargetGroup = 'Test Machines'


SELECT @Days = 7


 

-- Find all computers in the given @TargetGroup

SELECT vComputerTarget.Name


FROM PUBLIC_VIEWS.vComputerGroupMembership


INNER JOIN PUBLIC_VIEWS.vComputerTarget on vComputerGroupMembership.ComputerTargetId = vComputerTarget.ComputerTargetId


INNER JOIN PUBLIC_VIEWS.vComputerTargetGroup on vComputerGroupMembership.ComputerTargetGroupId = vComputerTargetGroup.ComputerTargetGroupId


WHERE

vComputerTargetGroup.Name = @TargetGroup


-- And only select those for which an update is approved for install, the

-- computer status for that update is either 2 (not installed), 3 (downloaded),

-- 5 (failed), or 6 (installed pending reboot), and

-- the update has been approved for install for at least @Days

AND EXISTS


(

select * from


PUBLIC_VIEWS.vUpdateEffectiveApprovalPerComputer


INNER JOIN PUBLIC_VIEWS.vUpdateApproval on vUpdateApproval.UpdateApprovalId = vUpdateEffectiveApprovalPerComputer.UpdateApprovalId


INNER JOIN PUBLIC_VIEWS.vUpdateInstallationInfoBasic on vUpdateInstallationInfoBasic.ComputerTargetId = vComputerTarget.ComputerTargetId


WHERE

vUpdateEffectiveApprovalPerComputer.ComputerTargetId = vComputerTarget.ComputerTargetId


AND vUpdateApproval.Action = 'Install'


AND vUpdateInstallationInfoBasic.UpdateId = vUpdateApproval.UpdateId


AND vUpdateInstallationInfoBasic.State in (2, 3, 5, 6)


AND DATEDIFF (day, vUpdateApproval.CreationDate, CURRENT_TIMESTAMP) > @Days


)
USE [HQDB]
GO

CREATE NONCLUSTERED INDEX 
[_dta_index_InventoryTransferLog] ON [dbo].[InventoryTransferLog] 
(
	[ID] ASC
)
INCLUDE ( [ItemID],
[DetailID],
[Quantity],
[DateTransferred],
[StoreID],
[DBTimeStamp],
[AutoID],
[ReferenceID],
[ReasonCodeID],
[CashierID],
[Type],
[ReferenceEntryID],
[Cost],
[BatchNumber]) 
WITH 
	(
		PAD_INDEX  = OFF, 
		STATISTICS_NORECOMPUTE  = OFF, 
		SORT_IN_TEMPDB = OFF, 
		IGNORE_DUP_KEY = OFF, 
		DROP_EXISTING = OFF, 
		ONLINE = OFF, 
		ALLOW_ROW_LOCKS  = ON, 
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
GO



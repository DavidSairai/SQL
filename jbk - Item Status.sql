--- DROP VIEW RP_ViewItemStatus	

CREATE VIEW RP_ViewItemStatus AS
SELECT
	Store.Name AS StoreName,
	Store.ID AS StoreID,
	Department.Name as DepartmentName,
	Department.Code as DepartmentCode,
	Category.Name as CategoryName,
	Category.Code as CategoryCode,
	Item.ItemLookupCode AS ItemLookupCode,
	ItemClass.ItemLookUpCode AS MatrixCode,
	Item.Cost as Cost,
	Item.MSRP as MSRP,
	Item.BinLocation AS ItemBinLocation,
	Item.Description AS ItemDescription,
	Item.ExtendedDescription AS ExtendedDescription,
	Item.SubDescription1 AS SubDescription1,
	Item.SubDescription2 AS SubDescription2,
	Item.SubDescription3 AS SubDescription3,
	Serial.SerialNumber AS SerialNumber,
	Serial.SerialNumber2 AS SerialNumber2,
	Serial.SerialNumber3 AS SerialNumber3,
	Cashier.Name AS CashierName,
	InventoryTransferLog.ReferenceID AS ReferenceID,
	InventoryTransferLog.ReferenceEntryID AS ReferenceEntryID,
	InventoryTransferLog.Type AS Type,
	ReasonCode.Description AS ReasonCodeDescription,
	InventoryTransferLog.Quantity AS Quantity,
	InventoryTransferLog.ComputedQuantity AS SOH,
	InventoryTransferLog.DateTransferred AS DateTransferred,
	PurchaseOrder.PONumber AS PONumber,
	ItemDynamic.SnapShotCost AS StoreCost,
	[TransactionEntry].Cost AS SalesCost,
	[TransactionEntry].Quantity AS SalesQuantity,
	CASE InventoryTransferlog.Type WHEN 2 THEN InventoryTransferLog.ReferenceID ELSE NULL END AS TransactionNumber

	FROM InventoryTransferLog
	LEFT JOIN Item WITH(NOLOCK) ON InventoryTransferLog.ItemID = Item.ID
	LEFT JOIN ItemClass WITH(NOLOCK) ON InventoryTransferLog.ItemID = Item.ID
	LEFT JOIN Department WITH(NOLOCK) ON Item.DepartmentID = Department.ID
	LEFT JOIN Category ON Item.CategoryID = Category.ID
	LEFT JOIN Store WITH(NOLOCK) ON InventoryTransferLog.StoreID = Store.ID
	LEFT JOIN ItemDynamic WITH(NOLOCK) ON  ItemDynamic.ItemID = Item.ID And ItemDynamic.StoreID = Store.ID
	LEFT JOIN [TransactionEntry] WITH(NOLOCK) ON TransactionEntry.ItemID = Item.ID And TransactionEntry.StoreID = Store.ID
	LEFT JOIN Serial WITH(NOLOCK) ON InventoryTransferLog.DetailID = Serial.ID AND InventoryTransferLog.StoreID = Serial.StoreID
	LEFT JOIN Cashier WITH(NOLOCK) ON InventoryTransferLog.CashierID = Cashier.ID 
	AND InventoryTransferLog.StoreID = Cashier.StoreID
	LEFT JOIN ReasonCode WITH(NOLOCK) ON InventoryTransferLog.ReasonCodeID = ReasonCode.ID
	LEFT JOIN PurchaseOrder WITH(NOLOCK) ON InventoryTransferLog.ReferenceID = PurchaseOrder.ID
	AND (InventoryTransferLog.Type = 1 OR InventoryTransferLog.Type = 3)
	AND InventoryTransferLog.StoreID =PurchaseOrder.StoreID
	WHERE Item.ItemType <> 9
	
	UNION ALL
	
	SELECT
	Store.Name as StoreName,
	Store.ID as StoreID,
	Department.Name as DepartmentName,
	Department.Code as DepartmentCode,
	Category.Name as CategoryName,
	Category.Code as CategoryCode,
	Item.ItemLookupCode AS ItemLookupCode,
	ItemClass.ItemLookUpCode AS MatrixCode,
	Item.Cost as Cost,
	Item.MSRP as MSRP,
	Item.BinLocation AS ItemBinLocation,
	Item.Description AS ItemDescription,
	Item.ExtendedDescription AS ExtendedDescription,
	Item.SubDescription1 AS SubDescription1,
	Item.SubDescription2 AS SubDescription2,
	Item.SubDescription3 AS SubDescription3,
	Serial.SerialNumber AS SerialNumber,
	Serial.SerialNumber2 AS SerialNumber2,
	Serial.SerialNumber3 AS SerialNumber3,
	Cashier.Name AS CashierName,
	TransactionEntry.TransactionNumber AS ReferenceID,
	TransactionEntry.ID AS ReferenceEntryID,
	99 AS Type,
	ReasonCode.Description AS ReasonCodeDescription,
	- TransactionEntry.Quantity AS Quantity,
	Item.Quantity AS SOH,
	[Transaction].Time AS DateTransferred,
	'' AS PONumber,
	ItemDynamic.SnapShotCost AS StoreCost,
	[TransactionEntry].Cost AS SalesCost,
	[TransactionEntry].Quantity AS SalesQuantity,
	[Transaction].TransactionNumber AS TransactionNumber
	
	FROM TransactionEntry
	LEFT JOIN Item WITH(NOLOCK) ON TransactionEntry.ItemID = Item.ID
	LEFT JOIN Department WITH(NOLOCK) ON Item.DepartmentID = Department.ID
	LEFT JOIN Category ON Item.CategoryID = Category.ID
	LEFT JOIN Store WITH(NOLOCK) ON TransactionEntry.StoreID = Store.ID
	LEFT JOIN ItemDynamic WITH(NOLOCK) ON  ItemDynamic.ItemID = Item.ID And ItemDynamic.StoreID = Store.ID
	LEFT JOIN [Transaction] WITH(NOLOCK) ON TransactionEntry.TransactionNumber = [Transaction].TransactionNumber AND 
	[Transaction].StoreID = Store.ID
	LEFT JOIN Serial WITH(NOLOCK) ON TransactionEntry.DetailID = Serial.ID AND Serial.StoreID = Store.ID
	LEFT JOIN Cashier WITH(NOLOCK) ON [Transaction].CashierID = Cashier.ID AND Cashier.StoreID = Store.ID
	LEFT JOIN ReasonCode WITH(NOLOCK) ON TransactionEntry.ReturnReasonCodeID = ReasonCode.ID
	WHERE Item.ItemType <> 9
SELECT *
FROM TransactionEntry, PurchaseOrder With (NoLock)
		INNER JOIN 	[Transaction] WITH(NOLOCK) ON TransactionEntry.TransactionNumber = [Transaction].TransactionNumber
		AND TransactionEntry.StoreID = [Transaction].StoreID 
		INNER JOIN 	Batch WITH(NOLOCK) ON [Transaction].BatchNumber = Batch.BatchNumber AND [Transaction].StoreID = Batch.StoreID
		LEFT JOIN PurchaseOrderEntry ON PurchaseOrder.ID = PurchaseOrderEntry.PurchaseOrderID AND PurchaseOrder.StoreID = PurchaseOrderEntry.StoreID 
		INNER JOIN PurchaseOrder AS RefPO With (NoLock) ON PurchaseOrder.OriginPOID = RefPO.ID AND PurchaseOrder.StoreId = RefPO.StoreID 
		LEFT JOIN PurchaseOrder AS RefParentPO With (NoLock) ON PurchaseOrder.ParentPoID = RefParentPO.ID AND PurchaseOrder.StoreId = RefParentPO.StoreID
		LEFT JOIN Store ON PurchaseOrder.StoreID = Store.ID
		LEFT JOIN Item ON PurchaseOrderEntry.ItemID = Item.ID
		LEFT JOIN Department WITH(NOLOCK) ON Item.DepartmentID = Department.ID 
		LEFT JOIN Category WITH(NOLOCK) ON Item.CategoryID = Category.ID
		
		/*UNION 
		
		INNER JOIN [Transaction] WITH(NOLOCK) ON TransactionEntry.TransactionNumber = [Transaction].TransactionNumber AND TransactionEntry.StoreID = [Transaction].StoreID
		*/
declare @sql nvarchar(1000)

if ( left( replace( convert( varchar, SERVERPROPERTY('productversion') ), '.', '' ), 2 ) = '80' ) 
begin
	set @sql = 'create view fossyscols as select * from syscolumns'
end 
else
begin
	set @sql = 'create view fossyscols as select 
		   sc.[name], [id], [xtype], [typestat], [xusertype],
		   [length], [xprec], [xscale], [colid],
		   [xoffset], [bitpos], [reserved], [colstat],
		   [cdefault], [domain], [number],
		   [colorder], case is_identity when 0 then NULL else x01000000010000000100000003 end as autoval,
		   [offset], [collationid], [language],
		   [status], [type], [usertype], [printfmt],
		   [prec], sc.[scale], [iscomputed], [isoutparam],
		   [isnullable], [collation], [tdscollation]
		    from syscolumns sc
		    join sys.columns scv on ( sc.id = scv.object_id and sc.name = scv.name )'
end

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fossyscols]') and OBJECTPROPERTY(id, N'IsView') = 1)
begin
	exec sp_executesql @sql
end

if not exists (select * from AR4Common..sysobjects where name = 'fossyscols')
begin
	exec AR4Common.dbo.sp_executesql @sql
end


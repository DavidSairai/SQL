--- BY DFS
--- TO GET DB TBLE SIZE AND NUMBER OF ROWS
/*CREATE PROCEDURE RP_DB_SIZE
AS
*/
--- UNCOMMENT THE ROW ABOVE IF YOU PLAN TO RUN THIS IN FUTURE. STORE THE PROC IN THE DB FOR EXEC
--- RUN --> EXEC RP_DB_SIZE IN NEW QUERY WINDOW

declare @RowCount int, @tablename varchar(100)
declare @Tables TABLE
(
	PK int IDENTITY(1,1),
	tablename varchar(100),
	processed bit
)
INSERT into @Tables (tablename)

SELECT TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE' 
and TABLE_NAME not like 'dt%' order by TABLE_NAME asc
	declare @Space TABLE
(
name varchar(100), rows nvarchar(100), reserved varchar(100), data varchar(100), index_size varchar(100), unused varchar(100)
)

select top 1 @tablename = tablename from @Tables where processed is null

SET @RowCount = 1
	WHILE (@RowCount <> 0)
		BEGIN
			insert into @Space exec sp_spaceused @tablename
			update @Tables set processed = 1 where tablename = @tablename
			select top 1 @tablename = tablename from @Tables where processed is null
			SET @RowCount = @@RowCount
		END

UPDATE @Space set data = replace(data, ' KB', '')
update @Space set data = convert(int, data)/1000
update @Space set data = data + ' MB'
update @Space set reserved = replace(reserved, ' KB', '')
update @Space set reserved = convert(int, reserved)/1000
update @Space set reserved = reserved + ' MB'

select * from @Space order by convert(int, replace(data, ' MB', '')) desc
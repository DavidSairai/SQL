DECLARE @DatabaseName	sysname, @vID int, @command varchar(8000) 

--DROP TABLE #TempDB

SELECT Identity(INT) as vID ,Name
	Into #TempDB
FROM master..sysdatabases
WHERE Name LIKE 'AR%'
;

WHILE (Select Count(1) FROM #TempDB) > 0
BEGIN;

	Select @vID =MIN(vID) FROM #TempDB

	SELECT  @DatabaseName=Name
	FROM #TempDB 
	WHERE vID = @vID 

	SET @command = ''
	SET @command =

	'
	USE ' + @DatabaseName +
	' select
			DBName,
			name,
			[filename],
			size as ''Size(MB)'',
			usedspace as ''UsedSpace(MB)'',
			(size - usedspace) as ''AvailableFreeSpace(MB)'',
			(usedspace/10000)*100 AS ''%Used of 10GB''
	from       
	(   
	SELECT
	db_name(s.database_id) as DBName,
	s.name AS [Name],
	s.physical_name AS [FileName],
	(s.size * CONVERT(float,8))/1024 AS [Size],
	(CAST(CASE s.type WHEN 2 THEN 0 ELSE CAST(FILEPROPERTY(s.name, ''SpaceUsed'') AS float)* CONVERT(float,8) END AS float))/1024 AS [UsedSpace],
	s.file_id AS [ID]
	FROM
	sys.filegroups AS g
	INNER JOIN sys.master_files AS s ON ((s.type = 2 or s.type = 0) and s.database_id = db_id() and (s.drop_lsn IS NULL)) AND (s.data_space_id=g.data_space_id)
	) DBFileSizeInfo'

	EXEC(@command)

	DELETE FROM #TempDB WHERE vID=@vID

END;

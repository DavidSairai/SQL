set nocount on      
set quoted_identifier on 
set arithabort on 

declare @DBName varchar(128)      
declare @DBFetchStatus int      

declare curAllDatabases cursor for      
   select Name from master..sysdatabases      
    where name not in ( 'tempdb', 'msdb' )      
      and name not like '%TRG'      

open curAllDatabases       
      
fetch next from curAllDatabases into @DBName      
set @DBFetchStatus = @@fetch_status      
   
while ( @DBFetchStatus = 0 ) begin      
   exec ( 'BACKUP DATABASE [' + @DBName + '] TO DISK = N''' + @DBName + '.bak''
            WITH FORMAT, INIT, NAME = N''' + @DBName + '-Full Database Backup'''  ) 

   fetch next from curAllDatabases into @DBName      
      set @DBFetchStatus = @@fetch_status      

end -- while not end of Databases      
   
deallocate curAllDatabases      
   
set nocount off
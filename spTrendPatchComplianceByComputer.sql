BEGIN TRAN

GO
-- Rename the table to backup the data
exec sp_rename 'TREND_WindowsCompliance_ByComputer', 'TREND_WindowsCompliance_ByComputer_old'

GO

-- Drop the procedure and execute it to create the tables
drop procedure spTrendPatchComplianceByComputer

GO

create procedure spTrendPatchComplianceByComputer
	@collectionguid as uniqueidentifier = '01024956-1000-4cdb-b452-7db0cff541b6',
	@force as int = 0
as

if (not exists(select 1 from sys.objects where name = 'PM_TRENDS2_TEMP' and type = 'U'))
begin
CREATE TABLE [dbo].[PM_TRENDS2_TEMP](
	[_ResourceGuid] [uniqueidentifier] NOT NULL,
	[Computer Name] [varchar](250) NOT NULL,
	[Compliance] [numeric](6, 2) NULL,
	[Applicable (Count)] [int] NULL,
	[Installed (Count)] [int] NULL,
	[Not Installed (Count)] [int] NULL,
	[Restart Pending] [varchar](3) NOT NULL,
	[_DistributionStatus] [nvarchar](16) NULL,
	[_OperatingSystem] [nvarchar](128) NULL,
	[_StartDate] [datetime] NULL,
	[_EndDate] [datetime] NULL,
) ON [PRIMARY]
end

if (not exists(select 1 from sys.objects where type = 'U' and name = 'TREND_WindowsCompliance_ByComputer'))
begin
	CREATE TABLE [dbo].[TREND_WindowsCompliance_ByComputer](
		[_Exec_id] [int] NOT NULL,
		[CollectionGuid] [uniqueidentifier] NOT NULL,
		[_Exec_time] [datetime] NOT NULL,
		[Percent] int NOT NULL,
		[Computer #] int NOT NULL,
		[% of Total] money NOT NULL
	) ON [PRIMARY]

	CREATE UNIQUE CLUSTERED INDEX [IX_TREND_WindowsCompliance_ByComputer] ON [dbo].[TREND_WindowsCompliance_ByComputer] 
	(
		[CollectionGuid] ASC,
		[Percent] ASC,
		[_exec_id] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = 
OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

end

-- PART II: Get data into the trending table if no data was captured in the last 23 hours
if (select MAX(_exec_time) from TREND_WindowsCompliance_ByComputer where collectionguid = @collectionguid) <  dateadd(hour, -23, getdate()) or ((select COUNT(*) from TREND_WindowsCompliance_ByComputer where collectionguid = @collectionguid) = 0) or (@force = 1)
begin

-- Get the compliance by update to a 'temp' table
truncate table PM_TRENDS2_TEMP
insert into PM_TRENDS2_TEMP
exec spPMWindows_ComplianceByComputer
							@OperatingSystem = '%',
							@DistributionStatus = 'active',
							@FilterCollection = @collectionguid,
							@StartDate = '1990-08-21T00:00:00',
							@EndDate = '2020-12-31',
							@pCulture = 'en-gb',
							@TrusteeScope = '{2e1f478a-4986-4223-9d1e-b5920a63ab41}',
							@VendorGuid	= '00000000-0000-0000-0000-000000000000',
							@CategoryGuid = '00000000-0000-0000-0000-000000000000'

declare @id as int
	set @id = (select MAX(_exec_id) from TREND_WindowsCompliance_ByComputer where collectionguid = @collectionguid)

declare @total as float
	set @total = (select COUNT(*) from PM_TRENDS2_TEMP)

insert into TREND_WindowsCompliance_ByComputer
select (ISNULL(@id + 1, 1)), @CollectionGuid as CollectionGuid, GETDATE() as '_Exec_time', CAST(compliance as decimal) as 'Percentile', COUNT(*) as 'Computer #', cast((CAST(count(*) as float) / @total) * 100 as money) as '% of Total'
  from PM_TRENDS2_TEMP
 group by CAST(compliance as decimal)
 order by CAST(compliance as decimal)

end

 select *
   from TREND_WindowsCompliance_ByComputer
  where _exec_id = (select max(_exec_id) from TREND_WindowsCompliance_ByComputer where collectionguid = @collectionguid)
    and collectionguid = @collectionguid

GO

exec spTrendPatchComplianceByComputer @CollectionGuid='6410074B-FFFF-FFFF-FFFF-0C8803328385'

GO

insert TREND_WindowsCompliance_ByComputer ([_Exec_id], [CollectionGuid], [_Exec_time], [Percent], [Computer #], [% of Total])
select [_Exec_id], '311E8DAE-2294-4FF2-B9EF-B3D6A84183CB' as 'CollectionGuid', [_Exec_time], [Percent], [Computer #], [% of Total] from TREND_WindowsCompliance_ByComputer_old



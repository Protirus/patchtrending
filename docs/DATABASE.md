# Database

The SMP will have some `Tables` and `Stored Procedures` added to it when you install **PatchTrending**.

---

See original [Connect](https://www.symantec.com/connect/) Article: [{CWoC} Patch Trending Stored Procedures](https://www.symantec.com/connect/downloads/cwoc-patch-trending-stored-procedures).

## Introduction

The ability to track information over time, aka trending, is not yet a big part of the SMP and solution, and for many good reasons (just consider the count of data points you may want to trend - add the possibility to filter by OU or collections and multiple this by 365 to store data just for a year and you have in your hand something that could be considered as data explosion).

However it is a key part of monitoring and tracking Patch Management compliance over time.

To this avail I have already published a set of articles [1][2][3], and another download [4] to create reports that basically run the trending logic and an executable that generates a semi-static web-site (i.e. all content is generated onto static files on the server, but we still use Javascript to load data dynamically on the client browser).

Today I am grouping the report SQL into self-contained stored procedures, so your reports won't need to be so long and will be much easier to understand. I have also added common feature that make them easier to use for our specific trending needs.

File list:

- [spTrendInactiveComputers.sql](..\spTrendInactiveComputers.sql)
- [spTrendPatchComplianceByComputer.sql](..\spTrendPatchComplianceByComputer.sql)
- [spTrendPatchComplianceByUpdate.sql](..\spTrendPatchComplianceByUpdate.sql)

Features:

- `@CollectionGuid` = 'uniqueidentifier'
- `@Force` = 0 | 1

## Custom collection guid (`@CollectionGuid`):
This parameter allows you to specify which *CollectionGuid* will be used when executing the Patch Management stored procedures. 

If nothing is specified we will use the default '`01024956-1000-4cdb-b452-7db0cff541b6`', which is the '**Windows Computers with Software Update Plug-in Installed**'.

This is useful if the monitored scope is different from the default collection, for example if your Server patching is done differently and you want to cater only for workstations in your patch trending, or if you have a custom filter used in the Software Update policies.

***Usage:***

```sql
exec spTrendPatchComplianceByComputer @collectionguid = '29bafad0-1a60-4796-b260-4e6f3633afae'
```

```sql
exec spTrendPatchComplianceByUpdate @collectionguid = '29bafad0-1a60-4796-b260-4e6f3633afae'
```

***Caution!*** If you are using a custom collection guid make sure you do not call the procedure without the parameter - as this would change the base on which the trending is done. Actually, if you are in this situation, the best is to change the default value to match your filter guid. This will avoid any potential mishaps if you need to run the trending procedure out of the normal operation.

## Force recording (`@Force`)
By default each of the procedure will record a new dataset if the last dataset was records more 23 hours prior. This is to make sure we capture the data once per day (and accommodates for tiny variations in the report run time that could cause recording not to take place if we had selected 24 hours).

However sometime you will need the report to run within the 23 hours period after the last execution. For example if for x reasons a nightly execution failed to run on schedule, and you ran the report manually in the morning.

Without the ability to force the recording to take place the coming night you could be missing a daily snapshot, which over months of data recording is not a huge deal, however when running a report for the past week for example having the latest data can be quite important.

***Usage:***

```sql
exec spTrendPatchComplianceByUpdate @force = 1
```

```sql
exec spTrendInactiveComputers @force = 1
```

### Features Availability:
Not all features are available on all procedure, so here's a table listing capabilities:


| Procedure         | @CollectionGuid | @Force |
|----------------------------------|-----|-----|
| `spTrendInactiveComputers`         | No  | Yes |
| `spTrendPatchComplianceByComputer` | Yes | Yes |
| `spTrendPatchComplianceByUpdate`   | Yes | Yes |

So you could run the following:

```sql
exec spTrendPatchComplianceByComputer @collectionguid = '29bafad0-1a60-4796-b260-4e6f3633afae', @force = 1
```

```sql
exec spTrendPatchComplianceByUpdate @collectionguid = '29bafad0-1a60-4796-b260-4e6f3633afae', @force = 1
```

```sql
exec spTrendInactiveComputers @force = 1
```

But not:

```sql
exec spTrendInactiveComputers @force = 1, @collectionguid = '29bafad0-1a60-4796-b260-4e6f3633afae'
```

as it would cause an SQL error.

## References
- [1] [Adding Patch Compliance Trending Capacity to SMP is as Simple as Running a Report Daily :D](https://www-secure.symantec.com/connect/articles/adding-patch-compliance-trending-capacity-smp-simple-running-report-daily-d)
- [2] [Adding Compliance by Computer Trending to Your SMP](https://www-secure.symantec.com/connect/articles/adding-compliance-computer-trending-your-smp) 
- [3] [{CWoC} Patch trending: Inactive computer trending report](https://www-secure.symantec.com/connect/articles/cwoc-patch-trending-inactive-computer-trending-report)
- [4] [{CWoc} Patch Trending SiteBuilder](https://www-secure.symantec.com/connect/downloads/cwoc-patch-trending-sitebuilder)

---

**Release 17** from the [ReleaseNotes](RELEASENOTES.md) mentions some of this.

See the code for the full `sql`.

- [clean_all.sql](..\clean_all.sql)
- [spTrendInactiveComputers.sql](..\spTrendInactiveComputers.sql)
- [spTrendPatchComplianceByComputer.sql](..\spTrendPatchComplianceByComputer.sql)
- [spTrendPatchComplianceByUpdate.sql](..\spTrendPatchComplianceByUpdate.sql)
- [upgrade.sql](..\upgrade.sql)
- [zBackup_TREND_Tables.sql](..\zBackup_TREND_Tables.sql)

Tables
```
TREND_InactiveComputerCounts
TREND_InactiveComputer_Current
TREND_InactiveComputer_Previous
TREND_WindowsCompliance_ByComputer
TREND_WindowsCompliance_ByUpdate
```

```
TREND_InactiveComputerCounts_old
TREND_InactiveComputer_Current_old
TREND_InactiveComputer_Previous_old
TREND_WindowsCompliance_ByComputer_old
TREND_WindowsCompliance_ByUpdate_old
```

Stored Procedures
```
spTrendInactiveComputers
spTrendPatchComplianceByComputer
spTrendPatchComplianceByUpdate
```

# Database

The SMP will have some `Tables` and `Stored Procedures` added to it when you install PatchTrending.

---

See [{CWoC} Patch Trending Stored Procedures](https://www.symantec.com/connect/downloads/cwoc-patch-trending-stored-procedures) until ported here.

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

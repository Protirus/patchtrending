# {CWoC} Patch Trending

![](https://img.shields.io/badge/language-c%23-green.svg)
![](https://img.shields.io/badge/tag-smp-yellow.svg)
![](https://img.shields.io/badge/tag-symantec-yellow.svg)
![](https://img.shields.io/badge/tag-patch-yellow.svg)

Patch Trending for ![SMP](docs/images/smp.png) Symantec Management Platform

---

There are also some **Docs**

- [Build](/docs/BUILD.md)

[//]: # (- [Build Errors](/docs/BUILDERRORS.md)

- [Config](/docs/CONFIG.md)
- [Database](/docs/DATABASE.md)
- [Logs](/docs/LOGS.md)
- [New Version](/docs/NEWVERSION.md)
- [Release Notes](/docs/RELEASENOTES.md)
- [Sample Site](/docs/SAMPLESITE.md)
- [SiteBuilder](/docs/SITEBUILDER.md)
- [Switches](/docs/SWITCHES.md)

---

## Install

`PatchTrending-#.exe /install`

This will install the Stored Procedures (See [Database](/docs/DATABASE.md) for more info).

There might be issues with the command

`PatchTrending-#.exe /upgrade`

Instead just run the following manually in SSMS.


```sql
exec spTrendInactiveComputers @force = 1
exec spTrendPatchComplianceByComputer @force = 1
exec spTrendPatchComplianceByUpdate @force = 1
```

This will create the Tables necessary for the `PatchTrending-#.exe /collectdata` to run. You can create a new Task in the SMP to run this daily or 3 separate Tasks which run each SP on its own.

Finally create a final nightly Task to build the site: `PatchTrending-#.exe /buildsite`

See [SiteBuilder](/docs/SITEBUILDER.md) for full instructions.

The default install directory is

`C:\Program Files\Altiris\Notification Server\Web\PatchTrending\`

This will then allow you to see it in a Web Browser.
`
http://<your_smp_name>/altiris/ns/patchtrending`

---

Original [PatchTrending](https://github.com/somewhatsomewhere/patchtrending) from [Ludovic Ferre
](https://www.symantec.com/connect/user/ludovic-ferre)

>[END OF "SUPPORT" NOTICE]

>Hello everyone, after close to 5 years maintaining various tools around Symantec Connect this legacy is turning to be more of a burden than anything else.
>It's still is a great set of tool and they all have their use, but as such I'm not going to maintain them anymore.
>The source code for this tool may still change over time, and can be found on Github: https://github.com/somewhatsomewhere?tab=repositories

>[/END OF "SUPPORT" NOTICE]

---

Check the [WIKI](https://github.com/Protirus/patchtrending/wiki) or the following Symantec Connect Articles

- [{CWoC} Patch Trending SiteBuilder](https://www.symantec.com/connect/downloads/cwoc-patch-trending-sitebuilder)

- [Adding Patch Trending to Your Symantec Management Platform Step by Step Guide](https://www.symantec.com/connect/articles/adding-patch-trending-your-symantec-management-platform-step-step-guide)

- [{CWoC} Patch Trending Stored Procedures](https://www.symantec.com/connect/downloads/cwoc-patch-trending-stored-procedures)

- [{CWoC} Patch Trending: Adding Patch Compliance Trending Capacity to SMP is as Simple as Running a Report Daily](https://www.symantec.com/connect/articles/cwoc-patch-trending-adding-patch-compliance-trending-capacity-smp-simple-running-report-dai)
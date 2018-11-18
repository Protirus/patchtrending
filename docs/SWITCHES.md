# Switches

> Welcome to the Patch Trending SiteBuilder. Here are the currently supported command line arguments:

Command **buildsite**

`/buildsite`
    
> This option is required if you want the tool to output the Patch Trending site, based on the `SiteConfig.txt` file.

Output

`.`

---

Command **collectdata**

`/collectdata`
    
> Run the trending procedure for each site that is enabled on the `siteconfig.txt`.

Output

`.`

---

Command **collectionguid=**

`/collectionguid=`
    
> When this option is used the Patch Trending site will be generated for the provided collection guid.

Output

`.`

---

Command **install**

`/install`

> This command line installs the pre-requisite stored procedures to the Symantec CMDB and terminates.

Output

`.`

---

Command **upgrade**

`/upgrade`

> Upgrade the database objects and _data_ from the previous schema to the latest version which adds a `CollectionGuid` in various location.

Output

`.`

---

Command **write-all**

`/write-all`

> This command line will prevent static html and css files from being written to disk. This allows you to customise the site look and feel to better suit your needs.

Output

`.`

---

Command **?** or **help**

`/? || /help`

> This command line prints out this help message and terminates.

Output

`.`

---

Command ***version**

`/version`

Output

`.`

---

## Config

Configuration files names and content:

See [SiteConfig.txt](..\SiteConfig.txt)

`SiteConfig.txt:`
    
> The site config file contains a a list of line seperated sites that should be built upon `/buildsite` invocations, or for which data will be collected upon `/collectdata` invocations.
        
> The root site is created under the working directory, whilst other sites will be created in a directory named using the site-name field.
        
>  Here's a sample file with explanation of each fields:

Example:

```
# Lines started with # are not process
#
# Fields descripitions:
# enabled (1 | 0), collectionguid, site-name (comma not allowed), site-description, root-site (only one allowed)
#

1, 01024956-1000-4cdb-b452-7db0cff541b6, AllComputers2, All computers with the Software Update plugin installed, 1
1, 01024956-1000-4cdb-b452-7db0cff541b6, AllComputers, All computers with the Software Update plugin installed, 0
1, b677c36f-8cf8-4c57-aa6f-f11948e128c7, Windows-Servers, All windows servers, 0
1, 66167acf-2484-4244-92fb-a2ffaa5aebd2, Windows-Desktops, All Windows Desktops, 0
0, 3faa8b67-250b-42ad-8186-fe2f49a9e707, Windows-64-bit, All Windows 64-bit systems, 0
1, 8afb27a1-5dc7-43ca-a88c-8391252f5b7b, Windows-32-bit, All Windows 32-bit systems, 0
```

As a table for better display:

| enabled (1 / 0) | collectionguid | site-name (comma not allowed) | site-description | root-site (only one allowed) |
|-----------------|----------------|-------------------------------|------------------|------------------------------|
| 1 | *Guid* | AllComputers | All computers with the Software Update plugin installed | 0 |

---

See [SiteLayout.txt](..\SiteLayout.txt)


Example:

`SiteLayout.txt`:

```
microsoft-2015-april, ms15-031, ms15-032, ms15-033, ms15-034, ms15-035, ms15-036, ms15-037, ms15-038, ms15-039, ms15-040, ms15-041, ms15-042
microsoft-2015-march, ms15-018, ms15-019, ms15-020, ms15-021, ms15-022, ms15-023, ms15-024, ms15-025, ms15-026, ms15-027, ms15-028, ms15-029, ms15-030
microsoft-2015-february, ms15-009, ms15-010, ms15-011, ms15-012, ms15-013, ms15-014, ms15-015, ms15-016, ms15-017
microsoft-2015-january, ms15-001, ms15-002, ms15-003, ms15-004, ms15-006, ms15-007, ms15-008
microsoft-2014-december, ms14-080, ms14-081, ms14-082, ms14-083, ms14-084, ms14-085, ms14-086, ms14-087, ms14-088, ms14-089, ms14-090, ms14-091, ms14-092, ms14-093, ms14-094, ms14-095, ms14-096, ms14-097, ms14-098, ms14-099
microsoft-2014-november, ms14-064, ms14-065, ms14-066, ms14-067, ms14-068, ms14-069, ms14-070, ms14-071, ms14-072, ms14-073, ms14-074, ms14-075, ms14-078, ms14-079
microsoft-2014-october, ms14-056, ms14-057, ms14-058, ms14-059, ms14-060, ms14-061, ms14-062, ms14-063
microsoft-2014-september, ms14-052, ms14-053, ms14-054, ms14-055
```
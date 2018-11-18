# Release Notes

## Release 17
* Note that version 17 is available for 8.0 and 8.1. If you want to run this in 7.6 or 7.5, please use the Github version and run the `build.bat` *

This is the last and final release of the Patch Trending tool. Note that the DB schema is _not_ compatible with previous versions and will require you to start afresh (i.e. delete all the stored procedures and tables created by the tool, unless the `/upgrade` feature works for you - but it proved so problematic that the version 17 had been in production a number of year before being pushed out here to all users).

We have a few key features now integrated into the tool:

- Installation of the SQL stored procedure is now fully automated (/install)
- Execution of the stored procedure to collect the data is also automaed (/collectdata)

Now, going back to the potential issues with `/upgrade`. If it doesn't work you'll have to stored your existing data somewhere else in the CDMB (rename the table) and possibly restore the data once the DB schema has been upgrade. It's not all that hard after all :D.

Here is some SQL code to help you start from scratch (**note that this will delete _all_ existing trending objects and the contained data**):

```sql
drop table TREND_InactiveComputerCounts
drop table TREND_InactiveComputer_Current
drop table TREND_InactiveComputer_Previous
drop table TREND_WindowsCompliance_ByComputer
drop table TREND_WindowsCompliance_ByUpdate

drop table TREND_InactiveComputerCounts_old
drop table TREND_InactiveComputer_Current_old
drop table TREND_InactiveComputer_Previous_old
drop table TREND_WindowsCompliance_ByComputer_old
drop table TREND_WindowsCompliance_ByUpdate_old

drop procedure spTrendInactiveComputers
drop procedure spTrendPatchComplianceByComputer
drop procedure spTrendPatchComplianceByUpdate
```

## Release 15
**This release contains a major codefix, a minor codefix and two important new features and a minor CLI change**:

- Code fix (1): Modified the `getbulletin.html` page to ensure it loads charts properly under various Internet Explorer versions (tested on Version 8, 9 and 10)
- Code fix (2): Modified `getbulletin.html` to verify whether trending data exists or not for the requested entry. If not the message 'No data is available...' is displayed.
- Feature (1): Added command line option `/write-all` to prevent the following static pages from being over-written with each site builder invocation (i.e. they will only be overwritten if you invoke '`sitebuilder.exe /write-all`'):

  - inactive-computers.html
  - compliance-by-computer.html
  - getbulletin.html
  - webpart-fullview.html
  - menu.css
  - help.html
  - javascript/helper.js

> You will notice that this feature include the `menu.css`. This will allow you to customise the look and feel of the site without loosing your work in between all execution. The same is true for the html pages, as you can now customise them further without the risk of loosing them.

- Feature (2): Added a new html page name '`webpart-fullview.html`'. This page is a copy of `getbulletin.html` without the site navigation. It is designed to be used inside the SMP console right-click actions inside a virtual window.
- CLI change: Added a standard message to display all valid option when invoking the executable with the help paremeter (`/?` or `--help`)

## Release 14
Adding the stored procedure code inside the site builder to simplify the installation process. The command line invocation is simple: '`sitebuilder.exe /install`'.

***Note!*** This will reset the stored procedures to default if they were customized.

## Release 13
Added some information in the help section. Also generalized the menu to all pages and changes some of the pages linking. One important feature is that the site layout file is now optional, as the site navigation does not depend on customised pages. Also fixed a fair few problems.

## Release 12
Version 12 is here with massive amount of changes. A full release note article will be published soon, but here's a short list of additions / improvements: all dates are not ISO based and displayed on the graphs using the MMM dd (for example 2013-07-14 is displayed Jul 14). We have a new site layout that lists all Microsoft bulletins by month, all the way to January 2009, we now have a site map, headers (linked or not) on all stub pages, a navigation tool, a help center (empty for now), we filter out superseded / inactive updates / bulletins from the site, we added a Compliance by Computer page that use a range selector and we have used the same range selector in the bulletin / update page (`getbulletin.html`).

## Release 11
Added Inactive computer trending pages. One page is added to the custom compliance view, and if the data exist a graph is added to the landing page, beside the compliance by computer graph if you have this trending enable, or on its own (see the 2 screenshots added above).

## Release 10
Added two troubleshooting pages to list the top 10 bulletins with most changes up (net increase in installed updates)  and down (net increase in vulnerable count). Also took some times to re-order the html pages generated. In this manner the browser will display the html content before it tries to build up the graphs in javascript. Finally I added page title to all generated html pages for additional clarity on the site.

## Release 9
Fixed the landing page search function. It will now only redirect to the `getbulletin.html` page if we can find data for the user input (bulletin name).

## Release 8c
Added compliance by computer graphics. This is a single graphs that shows on the landing page if you have enabled Compliance by Computer trending reports (awaiting release here on Connect). The graphs is of Candlestick type and shows data as illustrated above. With enough trending done you will see single line going thru the boxes. This is because we display the historical low, histroical high and changes since the previous data capture.

Note that you can use this version without having the Compliance by Computer report running, as this is an optional add-on.

## Release 6c
Fixed a problem with Internet Explorer support. The pages now render properly for IE 8.0 and above. It may work with IE 7 but was not tested yet.

## Release 6b
Switched the compliance data to be computed from the installed versus applicable datasets, thus reducing the amount of SQL queries executed by half.

## Release 6
Introduced vulnerable count on the Installed vers Applicable graphs. This gives us 3 lines (curves) that are easy to comprehend as you can see from the sample above.

## Release 5b
Corrected some performance issues from the previous build and added instrumentation. The site builder now logs entry in the Altiris Logs and will indicate the count of html and js pages generated as well as the count of SQL queries it ran. During the performance issue troubleshooting we considered using a single Databasecontext entry but this was a wrong lead. The problem was database performance as the use of code based stop watch indicated. This was fixed by a non-clustered index on the table to keep track of data by updates.

## Release 5
Refactored the graph per update generation. Added the link to the bulletin update page on the bulletin view and on the various aggregate pages.

## Release 4
Introduced the Updates per bulletin pages. This pages are crafted for all the bulletins found in the trending table, and each page is named after the bulletin (escaped by replacing dot and hyphens with underscore.

## Release 3
Introduced the global compliance graphs on the landing page. This makes the first look at the site very powerful, as we get compliance levels for the entire estate.

There were no prior release (or production use) of the tool.
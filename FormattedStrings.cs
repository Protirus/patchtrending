using System;
using System.Collections.Generic;
using System.Text;

namespace Symantec.CWoC.PatchTrending {
    class FormattedStrings {
        public static string sql_get_bulletin_data = @"
                         select Convert(varchar(255), max(_Exec_time), 127) as 'Date', SUM(installed) as 'Installed', SUM(Applicable) as 'Applicable'
                           from TREND_WindowsCompliance_ByUpdate
                          where Bulletin = '{0}'
                          group by _Exec_id order by date";

        public static string sql_get_update_data = @"
                         select Convert(varchar(255), _Exec_time, 127) as 'Date', installed as 'Installed', Applicable as 'Applicable'
                           from TREND_WindowsCompliance_ByUpdate
                          where [update] = '{0}' and bulletin = '{1}' ";
        public static string html_footer = @"
                <p>This site is generated from a customizable site layout file. It includes graphs (installed
                versus applicable and compliance in %) for bulletins that are active. It does not take into account the 
                targetted computers, so you could have very low compliance level whilst the bulletin is not targetting 
                the complete environment.</p>
                <h4 style=""text-align: center"">Generated by {{CWoC}} Patch Trending SiteBuilder {0} on {1}. <a href='sitemap.html'>sitemap<a/></h4>";
        public static string js_CandleStickData = "[{0}, {1}, {2}, {3}, {4}, "
                + "'<div style=\"font-family: Arial; font-size: 14px; text-align: center;\">{0}% compliant:</div>"
                + "<div style=\"font-family: Arial; font-size: 12px;\">"
                + "<p> <b>{3} computers ({5}% of total)</b> </p>"
                + "<p> Min = {1}, Prev = {2}, Max = {4}</p></div>'],\n";
        public static string html_BulletinPage = @"<html>
    <head>
        <title>{0}</title>
    </head>
    <body>
        {1}
        <script type='text/javascript' src='https://www.google.com/jsapi'></script>
        <script type='text/javascript' src='javascript/helper.js'></script>
        {2}
        <script type='text/javascript' src='javascript/{3}.js'></script>
        <script type='text/javascript'>
            google.load('visualization', '1', {{packages:['corechart']}});
            google.setOnLoadCallback(drawChart);
        </script>
    </body>
</html>";

    }
}

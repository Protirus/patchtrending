# New Version

When a new ![SMP](smp.png) SMP version is released you will need to update the [build.bat](..\build.bat) file.

You will likely only need to up `#` in the following code but it's best practice to search the GAC for the following dlls to make sure the folder name is correct.

The `GAC` (`C:\Windows\Microsoft.NET\assembly\GAC_MSIL`)

In [build.bat](..\build.bat) we have some variables

`set acm=Altiris.Common`

`acm` is used on

`set atrscm=%acm%\%ver1%\%acm%`

which is using `ver1` and this is the value that needs to be checked/updated.

`set ver1=v4.0_8.5.3073.0__d516cb311cfb6e4f`

So

- Altiris.Common

The full path would be `C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Altiris.Common\v4.0_8.5.3073.0__d516cb311cfb6e4f\Altiris.Common.dll`

---

Add a new line at the top

`if "%1"=="#" goto build-#`

then add a new section

```bat
:build-8.5

set build=8.5
set gac=C:\Windows\Microsoft.NET\assembly\GAC_MSIL
set csc=@c:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe
set ver1=v4.0_8.5.3073.0__d516cb311cfb6e4f

goto build
```

---

Next update the Version Number in [PatchTrending.cs](https://github.com/Protirus/patchtrending/blob/master/PatchTrending.cs#L127)

`public static string version = "version 18";`

Now you can run the [BUILD](BUILD.md) to create your new versions.
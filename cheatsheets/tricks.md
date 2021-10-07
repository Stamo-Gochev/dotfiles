# Tricks

## Update all git repositories in a directory
```
for i in */.git; do ( echo $i; echo "============="; cd $i/..; git stash; git checkout master; git pull --rebase; ); done
```

## Empty recycle bin


`rd /s %systemdrive%\$Recycle.bin`

## Disable Hibernate mode on Windows

`powercfg -h off`

## Stylus regex
`https?:\/\/(?!((www\\.)?(teams\.microsoft\.com))).*`
"https?:\\/\\/(?!((www\\\\.)?(github\\.com))).*"

## Chrome extensions
Quick Tabs - https://chrome.google.com/webstore/detail/quick-tabs/jnjfeinjfmenlddahdjdmgpbokiacbbb?hl=en


## NVM for Windows
Files are stored in:
C:\Program Files\nodejs\node_modules

### Changing versions does not work
Rename `nodejs` folder to `nodejsx` to clear the path for nvm:
https://github.com/coreybutler/nvm-windows/issues/321#issuecomment-382396940

## Livereload script
<script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>

## XAMPP
When used together with skype, remap port 80 to 8080: https://stackoverflow.com/questions/18300377/xampp-apache-error-apache-shutdown-unexpectedly

## JavaScript bookmarklet
https://superuser.com/questions/279107/add-a-bookmarklet-in-google-chrome
Add a bookmark with text `javascript: <minified-code>"

## Docker
### Delete `\ProgramData\docker` folder on Windows

https://bit.ly/2ywANbJ
```
$ cd C:\ProgramData\docker
$ takeown /R /F *
$ ICACLS * /T /Q /C /RESET
```

## Links
Create a junction
```
mklink /J Link Target
```

## Windows ProgramData folder junction

<details>
  <summary>Instructions</summary>
  
  ```
  Reference: https://www.vastorigins.com/2021/01/moving-programdata-folders-to-other.html
  
  Moving ProgramData Folders To Other Drive Using Windows 10
Friday, January 01, 2021

I don't know where I'm going from here, but I promise it won't be boring.
— David Bowie.

Hey guys, recently my C: drive became full, and it came to my mind that its hard to move files to a new SSD1 if I buy new one.

So it got me into thinking what are the things I can do to remove and free up space in my C: drive?

The first thing that comes up, is using the tool Disk Cleanup bundled with Windows 10. It only freed up 10Gb of data, then I check all the folder size which contains the largest amount of data.

The result was my user account and the ProgramData folder.
Here are the things I did in order to move ProgramData contents to my other spare drive.

DISCLAIMER: Before doing this on your machine please test and research first each command before executing on your machine / production environment.

First, I copied and mirrored the ProgramData folder structure and ACL’s2 using the command robocopy. The /MIR flag tells robocopy to retain security settings and state of file.

> robocopy /XJ /MIR "C:\ProgramData" "D:\ProgramData"
  
You could also use this other command flags, this command is non-destructive unlike the mirror flag. The mirror flag deletes the file at destination while this just overwrites and retain if missing in source.

> robocopy /xj /s /copyall C:\ProgramData D:\ProgramData
  
After everything’s done copying, you start creating junction links and symlinks3 from your spare drive (for me its the D: drive). The %~NA tells the batch command it will only get the base folder name, and the %~A gets the whole absolute path. The command below will only create directory junctions to begin with:

> FOR /D %A IN ("D:\ProgramData\*") DO (MKLINK /J "C:\ProgramData\%~NA" "%~A")
  
This next command, specifically create symbolic links to file from source to destination.

> FOR %A IN ("D:\ProgramData\*") DO (MKLINK "C:\ProgramData\%~NXA" "%~A")
  
Then after that restart your machine, and ensure everything’s working fine. I think some folders like Microsoft and Packages should be excluded in copying and making junctions.
  ```
  
</details>


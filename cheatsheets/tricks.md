# Tricks

## Update all git repositories in a directory
```
for i in */.git; do ( echo $i; echo "============="; cd $i/..; git stash; git checkout master; git pull --rebase; ); done
```

## Empty recycle bin


`rd /s %systemdrive%\$Recycle.bin`

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

# Tricks

## Update all git repositories in a directory
```
for i in */.git; do ( echo $i; echo "============="; cd $i/..; git stash; git checkout master; git pull --rebase; ); done
```

## Empty recycle bin


`rd /s %systemdrive%\$Recycle.bin`

## Stylus regex
`https?:\/\/(?!((www\\.)?(teams\.microsoft\.com))).*`

## Chrome extensions
Quick Tabs - https://chrome.google.com/webstore/detail/quick-tabs/jnjfeinjfmenlddahdjdmgpbokiacbbb?hl=en


## NVM for Windows
Files are stored in:
C:\Program Files\nodejs\node_modules

## Livereload script
<script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>

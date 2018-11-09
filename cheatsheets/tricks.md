# Tricks

## Update all git repositories in a directory
```
for i in */.git; do ( echo $i; cd $i/..; git stash; git checkout master; git pull --rebase; ); done
```

## Empty recycle bin


`rd /s %systemdrive%\$Recycle.bin`

## Stylus regex
`https?:\/\/(?!((www\\.)?(teams\.microsoft\.com))).*`

## Chrome extensions
Quick Tabs - https://chrome.google.com/webstore/detail/quick-tabs/jnjfeinjfmenlddahdjdmgpbokiacbbb?hl=en

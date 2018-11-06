# Tricks

## Update all git repositories in a directory
```
for i in */.git; do ( echo $i; cd $i/..; git stash; git checkout master; git pull --rebase; ); done
```

## Empty recycle bin

rd /s %systemdrive%\$Recycle.bin

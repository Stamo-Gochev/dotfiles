# Cmder cheatsheet

## Creating multiple tabs on startup

1. Create the desired configuration by splitting and rearranging tabs.
2. Go to `Settings -> Startup -> Auto save/restore opened tabs`

**Note:** You can manually set the opened tabs as:
```
-cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i

-cur_console:fs1T76H -cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i

-cur_console:bs1T50V -cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i

> -cur_console:bs2T45H -cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i

-cur_console:bs4T50V -cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i

-cur_console:b -cur_console:d:C:\cmder "C:\Program Files\Git\bin\sh.exe" --login -i
```
## Tasks
### git bash

"C:\Program Files\Git\bin\sh.exe" --login -i

### zsh

C:\Users\e30\.babun\cygwin\bin

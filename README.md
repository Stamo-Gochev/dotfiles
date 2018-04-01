# Instructions

## How to install

### Linux
Open a bash console and run the following command:
```
bash install.sh
```
**Note:** Use `bash` and not `sh` as it will probably target `/bin/dash`, which does not support the substitution from "_" to ".".

### Windows
Make symbolic links (make sure to pass an existing dir as the `mklink` command will fail silently):

Open PowerShell and run the following script:
```
dotfiles.ps1
```

Otherwise, manually symlink the necessary files:
```
mklink .gitconfig D:\GitHub\ide-settings\_gitconfig
mklink .gitignore D:\GitHub\ide-settings\_gitignore
mklink .vimrc D:\GitHub\ide-settings\_vimrc
mklink .aliases D:\GitHub\ide-settings\_aliases
mklink .bash_profile D:\GitHub\ide-settings\_bash_profile
mklink .bashrc D:\GitHub\ide-settings\_bashrc
mklink .zshrc D:\GitHub\ide-settings\_zshrc
mklink .inputrc D:\GitHub\ide-settings\_inputrc
 ```
## Cygwin (babun)

### Vim

Installing Vim plugins fires errors like:
```
Not an editor command: ^M
```
That's caused by Vimscript files that have Windows-style CR-LF line endings when used on Linux. Open the corresponding file(s) in Vim and convert them to Unix-style endings via:
```
:w ++ff=unix
```

Alternatively use `dos2unix` to convert the line endings (use `pact` as package manager in babun):
```
pact dos2unix
```
[https://github.com/VundleVim/Vundle.vim/issues/333](https://github.com/VundleVim/Vundle.vim/issues/333)

Alternatively, clone the Vundle repo [https://github.com/VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim) without `autocrlf` in `.gitconfig`

### Vim colors in Cmder and zsh

Vim is preconfigured with some colors in `babun\cygwin\etc\vimrc` file, which should be left blank:

[https://github.com/babun/babun/issues/78](https://github.com/babun/babun/issues/78)

Set the following lines in `.vimrc` to prevent Cmder highlighting of some words:
```
syntax on
set background=dark
```














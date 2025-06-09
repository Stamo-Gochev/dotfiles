# Sync settings
```
{"Token":"","Gist":"c3fadfb006fc3f96dd1c9c50694828de","Migrated":true,"ProxyIP":null,"ProxyPort":null}

public gist id:
c3fadfb006fc3f96dd1c9c50694828de
```

# Debug Rake task

```javascript
{
    "name": "MVC wrappers",
    "type": "Ruby",
    "request": "launch",
    "cwd": "${workspaceRoot}",
    "program": "C:/Ruby193/bin/rake",
    // "useBundler": true,
    "args": [
        "generate:mvc_6:wrappers"
    ]
}
```
from https://github.com/rubyide/vscode-ruby/wiki/1.-Debugger-Installation
### Install Ruby Dependencies
Debugging in this extension implements the [ruby debug ide protocol](http://debug-commons.rubyforge.org/protocol-spec.html) to allow VS Code to communicate with ruby debug, it requires `ruby-debug-ide` to be installed on your machine. This is also how RubyMine/NetBeans implement debugging by default.

- If you are using JRuby or Ruby v1.8.x (`jruby`, `ruby_18`, `mingw_18`)
  * `gem install ruby-debug-ide`, the latest version is `0.6.0`. Make sure `ruby-debug-base` is installed together with ruby-debug-ide`.
- If you are using Ruby v1.9.x (`ruby_19`, `mingw_19`)
  * `gem install ruby-debug-ide`, the latest version is `0.6.0`. Make sure `ruby-debug-base19x` is installed together with `ruby-debug-ide`.
- If you are using Ruby v2.x
  * `gem install ruby-debug-ide -v 0.6.0` or higher versions
  * `gem install debase -v 0.2.1` or higher versions

### Add VS Code config to your project
Go to the debugger view of VS Code and hit the gear icon. Choose Ruby or Ruby Debugger from the prompt window, then you'll get the sample launch config in `.vscode/launch.json`



# Debug Gulp task

Make sure to set the global path to gulp in `launch.json` as the local reference from `node_modules` is not working. Also, use lowercase letter for the drive, e.g. `c:/work/...` instead of `C:/work/...` if the debug console throws an error like:

>Program path uses differently cased character as file on disk; this might result in breakpoints not being hit.



```javascript
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Gulp task",
            //"program": "C:/Users/gochev/AppData/Roaming/npm/gulp",
            "program": "${workspaceRoot}/node_modules/gulp/bin/gulp.js",
            "args": [
                "taskName"
            ]
        },
        {
            "type": "node",
            "request": "launch",
            "name": "Launch Program",
            "program": "${workspaceFolder}/Gulpfile.js"
        }
    ]
}
```

# Debug Jest tests

```
# https://stackoverflow.com/questions/33247602/how-do-you-debug-jest-tests

# 1. go to chrome://inspect
# 2. add the test folder as a workspace in Chrome DevTools

# for linux
# alias jtn="node --inspect-brk node_modules/.bin/jest --runInBand"
# alias jtndb="ndb node --inspect-brk node_modules/.bin/jest --runInBand"
# for windows
alias jtn="node --inspect-brk node_modules/jest/bin/jest.js --runInBand --config jest.config.json"
alias jtnw="node --inspect-brk node_modules/jest/bin/jest.js --runInBand --config jest.config.json --watch --no-cache"
alias jtndbw="ndb node --inspect-brk node_modules/jest/bin/jest.js --runInBand --config jest.config.json --watch --no-cache"
alias jd="ndb node --inspect-brk node_modules/jest/bin/jest.js --runInBand --config jest.config.json --watch"
```

https://github.com/Microsoft/vscode-recipes/tree/master/debugging-jest-tests

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Jest All",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": ["--runInBand"],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen",
      "disableOptimisticBPs": true,
      "windows": {
        "program": "${workspaceFolder}/node_modules/jest/bin/jest",
      }
    },
    {
      "type": "node",
      "request": "launch",
      "name": "Jest Current File",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": [
        "${fileBasenameNoExtension}",
        "--config",
        "jest.config.js"
      ],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen",
      "disableOptimisticBPs": true,
      "windows": {
        "program": "${workspaceFolder}/node_modules/jest/bin/jest",
      }
    }
  ]
}
```

Add this to `package.json`:
```json
"jest": {
   "testEnvironment": "node"
}
```


# Themes
**Note:** For some reason the new location is at:
```
C:\Users\{name}\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions
```

```
cd C:\Users\gochev\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions
mklink /D theme-monokai-best-2 d:\work\github\dotfiles\visual-studio-code\theme-monokai-best-2\

cd C:\Users\gochev\AppData\Local\Programs\Microsoft VS Code Insiders\resources\app\extensions
mklink /D theme-monokai-best-2 d:\work\github\dotfiles\visual-studio-code\theme-monokai-best-2\

C:\Users\gochev\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions>
mklink /D theme-monokai-best-2 d:\work\github\dotfiles\visual-studio-code\theme-monokai-best-2\

Linux Mint
sudo cp -r theme-monokai-best/ /usr/share/code/resources/app/extensions
```

# Extensions
```
Extensions Added:
  advanced-new-file v1.2.0
  Align v0.2.0
  Angular2 v6.1.1
  auto-close-tag v0.5.6
  auto-rename-tag v0.0.15
  autoimport v1.5.3
  bracket-pair-colorizer v1.0.55
  calculate v2.0.0
  change-case v1.0.0
  code-settings-sync v2.9.2
  color-highlight v2.3.0
  compulim-vscode-closetag v1.1.0
  copy-word v0.4.1
  cpptools v0.17.4
  createGUID v0.0.2
  csharp v1.15.2
  datetime v1.0.5
  EditorConfig v0.12.4
  erb v0.0.1
  extension-manager v0.0.5
  githistory v0.4.1
  gitignore v0.5.0
  gitlens v8.3.3
  highlight-trailing-white-spaces v0.0.2
  home-end-fix v0.0.1
  html-css-class-completion v1.17.1
  html-snippets v0.2.1
  htmltagwrap v0.0.7
  iis-express v1.1.0
  imagepreview v0.5.1
  indenticator v0.6.0
  JavaScriptSnippets v1.6.0
  join-lines v0.2.2
  jquerysnippets v0.0.1
  jsrefactor v2.13.0
  language-vscode-javascript-angular2 v0.0.11
  launcher v0.0.4
  lorem-ipsum v1.2.0
  mdhelper v0.0.11
  move-fast v0.1.0
  new-cmd v0.2.0
  npm-intellisense v1.3.0
  package-watcher v0.0.2
  path-intellisense v1.4.2
  prettify-json v0.0.3
  project-manager v0.25.2
  Puppet v0.0.4
  quicksnippet v0.0.1
  quokka-vscode v1.0.128
  RelativePath v1.4.0
  ruby v0.0.6
  Ruby v0.18.0
  searchdocsets-vscode v1.0.1
  simple-react-snippets v1.1.1
  slack v0.0.14
  solargraph v0.17.4
  sort-lines v1.7.0
  TabSpacer v1.0.2
  taskbuttons v0.0.2
  Theme-Blackboard v0.0.2
  Theme-monokai-best v0.0.2
  theme-obsidian v0.3.1
  Theme-peel v0.0.2
  Theme-TomorrowKit v0.1.4
  Theme-TwoStones v0.0.2
  trailing-spaces v0.2.11
  useful-react-snippets v1.4.4
  view-in-browser v0.0.5
  vim v0.12.0
  vscode-auto-open-markdown-preview v0.0.4
  vscode-autohotkey v0.2.2
  vscode-babel-coloring v0.0.4
  vscode-color v0.4.5
  vscode-css-formatter v1.0.1
  vscode-file-peek v1.0.1
  vscode-great-icons v2.1.32
  vscode-icons v7.23.0
  vscode-import-cost v2.7.1
  vscode-javac v0.1.1
  vscode-language-babel v0.0.14
  vscode-new-file v4.0.2
  vscode-open-in-github v1.3.1
  vscode-open-in-github v1.7.0
  vscode-qrcode v0.2.0
  vscode-sort v0.2.5
  vscode-surround v0.0.2
  vscode-svgviewer v1.4.4
  vsliveshare v0.3.246
  wallaby-vscode v1.0.86
  xml v2.2.0
  ```
# Other extensions
(not tracked by the sync plugin)
vscode-scrolloff

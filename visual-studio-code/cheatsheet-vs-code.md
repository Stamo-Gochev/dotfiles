# Sync settings
```
{"Token":"","Gist":"54b0a0207c3d4e3afd26f9ca9af8e0ed","Migrated":true,"ProxyIP":null,"ProxyPort":null}
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
            "program": "C:/Users/gochev/AppData/Roaming/npm/gulp",
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
# Themes
```
cd C:\Program Files\Microsoft VS Code\resources\app\extensions
mklink /D theme-monokai-best D:\GitHub\ide-settings\visual-studio-code\theme-monokai-best

C:\Program Files\Microsoft VS Code\resources\app\extensions>mklink /D theme-monokai-best D:\GitHub\ide-settings\visual-studio-code\theme-monokai-best

Linux Mint
sudo cp -r theme-monokai-best/ /usr/share/code/resources/app/extensions 
```


# Remap keys in VsCodeVim
```javascript
//Custom settings

"editor.wordWrap": "on",

"editor.autoIndent": true,

"editor.cursorBlinking": "solid",

// Zoom the font of the editor when using mouse wheel and holding Ctrl
"editor.mouseWheelZoom": true,

// Remove trailing auto inserted whitespace
"editor.trimAutoWhitespace": true,

"files.trimTrailingWhitespace": true,

//Vim
"vim.otherModesKeyBindings": [{
	"before": ["o"],
	"after": ["<up>"]
}, {
	"before": ["l"],
	"after": ["<down>"]
}, {
	"before": ["k"],
	"after": ["<left>"]
}, {
	"before": [";"],
	"after": ["<right>"]
}],

"vim.insertModeKeyBindingsNonRecursive": [{
	"before": ["k", "k"],
	"after": ["<esc>"]
}],

"vim.otherModesKeyBindingsNonRecursive": [{
	"before": ["j"],
	"after": ["o"]
}],
"vim.leader": "<space>",
"vim.handleKeys":{
	"<C-a>": false,
	"<C-f>": false
},
"workbench.colorTheme": "monokai-best",
```

# Visual Studio

Highlight words with margin extension:
- occurrence color (blue) - 30, 121, 210
- select background color - 255, 128, 128
- select border color - 255, 0, 0

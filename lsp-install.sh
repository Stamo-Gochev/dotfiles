#!/usr/bin/env bash
set -euo pipefail

# LSP Server Installer
# Installs all language servers defined in lsp-config.json globally.

command_exists() {
    command -v "$1" &>/dev/null
}

require() {
    if ! command_exists "$1"; then
        echo "ERROR: '$1' is required but not installed. Skipping dependent installs." >&2
        return 1
    fi
}

echo "==> Installing LSP servers..."

# --- npm-based ---
if require npm; then
    echo "-> typescript-language-server"
    npm install -g typescript-language-server typescript

    echo "-> pyright (pyright-langserver)"
    npm install -g pyright

    echo "-> yaml-language-server"
    npm install -g yaml-language-server

    echo "-> vscode-langservers-extracted (json, html, css)"
    npm install -g vscode-langservers-extracted

    echo "-> bash-language-server"
    npm install -g bash-language-server

    echo "-> intelephense"
    npm install -g intelephense

    echo "-> vue-language-server"
    npm install -g @vue/language-server

    echo "-> docker-langserver"
    npm install -g dockerfile-language-server-nodejs

    echo "-> angular-language-server"
    npm install -g @angular/language-server

    echo "-> astro-ls"
    npm install -g @astrojs/language-server

    echo "-> graphql-language-service"
    npm install -g graphql-language-service-cli

    echo "-> ansible-language-server"
    npm install -g @ansible/ansible-language-server

    echo "-> svelte-language-server"
    npm install -g svelte-language-server

    echo "-> tailwindcss-language-server"
    npm install -g @tailwindcss/language-server
fi

# --- Go-based ---
if require go; then
    echo "-> gopls"
    go install golang.org/x/tools/gopls@latest

    echo "-> sqls"
    go install github.com/sqls-server/sqls@latest
fi

# --- Rust-based ---
if require rustup; then
    echo "-> rust-analyzer"
    rustup component add rust-analyzer
elif require cargo; then
    echo "-> rust-analyzer (via cargo)"
    cargo install rust-analyzer
fi

# --- Ruby-based ---
if require gem; then
    echo "-> ruby-lsp"
    gem install ruby-lsp
fi

# --- Elixir-based ---
if require mix; then
    echo "-> elixir-ls"
    ELIXIR_LS_DIR="${HOME}/.elixir-ls"
    mkdir -p "$ELIXIR_LS_DIR"
    git clone https://github.com/elixir-lsp/elixir-ls.git "$ELIXIR_LS_DIR" 2>/dev/null || \
        git -C "$ELIXIR_LS_DIR" pull
    ( cd "$ELIXIR_LS_DIR" && mix deps.get && mix compile && mix elixir_ls.release2 -o "$ELIXIR_LS_DIR/release" )
    ln -sf "${ELIXIR_LS_DIR}/release/language_server.sh" "${HOME}/.local/bin/elixir-ls"
    echo "  Installed to ${HOME}/.local/bin/elixir-ls"
fi

# --- Scala (Metals via Coursier) ---
if ! command_exists metals; then
    echo "-> metals (Scala)"
    if command_exists cs; then
        cs install metals
    elif command_exists brew; then
        brew install coursier/formulas/coursier && cs install metals
    else
        echo "WARNING: Install Coursier first: https://get-coursier.io, then run: cs install metals" >&2
    fi
else
    echo "-> metals already installed, skipping"
fi

# --- Kotlin ---
if ! command_exists kotlin-language-server; then
    echo "-> kotlin-language-server"
    if command_exists brew; then
        brew install kotlin-language-server
    else
        INSTALL_DIR="${HOME}/.local/bin"
        mkdir -p "$INSTALL_DIR"
        KLS_VERSION=$(curl -fsSL https://api.github.com/repos/fwcd/kotlin-language-server/releases/latest | grep -Po '"tag_name": "\K[^"]*')
        curl -fsSL "https://github.com/fwcd/kotlin-language-server/releases/download/${KLS_VERSION}/server.zip" \
            -o /tmp/kotlin-language-server.zip
        unzip -o /tmp/kotlin-language-server.zip -d "${HOME}/.kotlin-language-server"
        ln -sf "${HOME}/.kotlin-language-server/server/bin/kotlin-language-server" "${INSTALL_DIR}/kotlin-language-server"
        echo "  Installed to ${INSTALL_DIR}/kotlin-language-server"
    fi
else
    echo "-> kotlin-language-server already installed, skipping"
fi

# --- PowerShell Editor Services ---
if ! command_exists pwsh; then
    echo "WARNING: pwsh (PowerShell) not found. Install PowerShell first, then re-run this script." >&2
else
    echo "-> powershell-editor-services"
    PSES_DIR="${HOME}/.powershell-editor-services"
    mkdir -p "$PSES_DIR"
    PSES_VERSION=$(curl -fsSL https://api.github.com/repos/PowerShell/PowerShellEditorServices/releases/latest | grep -Po '"tag_name": "\K[^"]*')
    curl -fsSL "https://github.com/PowerShell/PowerShellEditorServices/releases/download/${PSES_VERSION}/PowerShellEditorServices.zip" \
        -o /tmp/PowerShellEditorServices.zip
    unzip -o /tmp/PowerShellEditorServices.zip -d "$PSES_DIR"
    echo "  Installed to ${PSES_DIR} — update the 'args' in lsp-config.json to point to Start-EditorServices.ps1"
fi

# --- sourcekit-lsp (Swift) ---
if ! command_exists sourcekit-lsp; then
    echo "-> sourcekit-lsp"
    if command_exists brew; then
        brew install swift
        echo "  sourcekit-lsp is bundled with the Swift toolchain."
    else
        echo "WARNING: sourcekit-lsp is bundled with the Swift toolchain." >&2
        echo "  Download Swift from: https://swift.org/download" >&2
    fi
else
    echo "-> sourcekit-lsp already installed, skipping"
fi

# --- .NET-based ---
if require dotnet; then
    echo "-> roslyn-language-server (csharp-ls)"
    # csharp-ls is an open-source Roslyn-based LSP server.
    # If using Microsoft's official Roslyn LSP, install the C# VS Code extension
    # and point the command to its bundled server binary instead.
    dotnet tool install --global csharp-ls || dotnet tool update --global csharp-ls

    echo "-> fsautocomplete (F#)"
    dotnet tool install --global fsautocomplete || dotnet tool update --global fsautocomplete
fi

# --- clangd (C/C++) ---
if ! command_exists clangd; then
    echo "-> clangd"
    if command_exists apt-get; then
        sudo apt-get install -y clangd
    elif command_exists brew; then
        brew install llvm && brew link llvm
    elif command_exists pacman; then
        sudo pacman -S --noconfirm clang
    elif command_exists dnf; then
        sudo dnf install -y clang-tools-extra
    else
        echo "WARNING: Could not install clangd automatically. Install it via your system package manager." >&2
    fi
else
    echo "-> clangd already installed, skipping"
fi

# --- marksman (Markdown) ---
if ! command_exists marksman; then
    echo "-> marksman"
    if command_exists brew; then
        brew install marksman
    else
        # Download latest release binary from GitHub
        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        ARCH=$(uname -m)
        if [[ "$ARCH" == "x86_64" ]]; then ARCH="x64"; fi
        BINARY="marksman-${OS}-${ARCH}"
        INSTALL_DIR="${HOME}/.local/bin"
        mkdir -p "$INSTALL_DIR"
        curl -fsSL "https://github.com/artempyanykh/marksman/releases/latest/download/${BINARY}" \
            -o "${INSTALL_DIR}/marksman"
        chmod +x "${INSTALL_DIR}/marksman"
        echo "  Installed to ${INSTALL_DIR}/marksman — ensure it is on your PATH."
    fi
else
    echo "-> marksman already installed, skipping"
fi

# --- jdtls (Java) ---
if ! command_exists jdtls; then
    echo "-> jdtls"
    if command_exists brew; then
        brew install jdtls
    elif command_exists pip3; then
        pip3 install --user jdtls
    elif command_exists apt-get; then
        # jdtls is not in standard apt repos; install via pip as fallback
        pip3 install --user jdtls
    else
        echo "WARNING: Could not install jdtls automatically." >&2
        echo "  Download from: https://download.eclipse.org/jdtls/milestones/" >&2
        echo "  Or run: pip3 install jdtls" >&2
    fi
else
    echo "-> jdtls already installed, skipping"
fi

# --- lemminx (XML) ---
if ! command_exists lemminx; then
    echo "-> lemminx (XML)"
    if command_exists brew; then
        brew install lemminx
    else
        INSTALL_DIR="${HOME}/.local/bin"
        mkdir -p "$INSTALL_DIR"
        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        ARCH=$(uname -m)
        if [[ "$ARCH" == "x86_64" ]]; then ARCH="amd64"; fi
        LEMMINX_VERSION=$(curl -fsSL https://api.github.com/repos/eclipse/lemminx/releases/latest | grep -Po '"tag_name": "\K[^"]*')
        curl -fsSL "https://github.com/eclipse/lemminx/releases/download/${LEMMINX_VERSION}/lemminx-${OS}.zip" \
            -o /tmp/lemminx.zip
        unzip -o /tmp/lemminx.zip -d "$INSTALL_DIR"
        chmod +x "${INSTALL_DIR}/lemminx"
        echo "  Installed to ${INSTALL_DIR}/lemminx"
    fi
else
    echo "-> lemminx already installed, skipping"
fi

# --- Terraform ---
if ! command_exists terraform-ls; then
    echo "-> terraform-ls"
    if command_exists brew; then
        brew install hashicorp/tap/terraform-ls
    elif command_exists apt-get; then
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt-get update && sudo apt-get install -y terraform-ls
    else
        echo "WARNING: Install terraform-ls from: https://github.com/hashicorp/terraform-ls/releases" >&2
    fi
else
    echo "-> terraform-ls already installed, skipping"
fi

# --- Haskell (via GHCup) ---
if ! command_exists haskell-language-server-wrapper; then
    echo "-> haskell-language-server"
    if command_exists ghcup; then
        ghcup install hls
    elif command_exists brew; then
        brew install haskell-language-server
    else
        echo "WARNING: Install GHCup first: https://www.haskell.org/ghcup, then run: ghcup install hls" >&2
    fi
else
    echo "-> haskell-language-server already installed, skipping"
fi

echo ""
echo "Done. Verify installs with: typescript-language-server --version, pyright --version, gopls version, metals --version, etc."

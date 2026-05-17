grep_with_params()
{
    grep --color -HIRn "$1" --exclude-dir=node_modules --include="$2" .
}

install_stamo_skills()
{
    local installer="/d/work/github/ai-skills/install-stamo-skills.ps1"
    local installer_win
    local working_dir_win
    local exit_code

    if [ ! -f "$installer" ]; then
        echo "ERROR: installer not found at $installer" >&2
        return 1
    fi

    if ! command -v cygpath >/dev/null 2>&1; then
        echo "ERROR: cygpath is required to run iss from Git Bash on Windows." >&2
        return 1
    fi

    installer_win="$(cygpath -w "$installer")"
    working_dir_win="$(cygpath -w "$PWD")"

    if [[ ! "$installer_win" =~ ^[A-Za-z]:\\ ]]; then
        echo "ERROR: failed to convert installer path to Windows format: $installer_win" >&2
        return 1
    fi

    if [[ ! "$working_dir_win" =~ ^[A-Za-z]:\\ ]]; then
        echo "ERROR: failed to convert working directory to Windows format: $working_dir_win" >&2
        return 1
    fi

    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$installer_win" -WorkingDir "$working_dir_win"
    exit_code=$?

    if [ $exit_code -ne 0 ]; then
        echo "ERROR: install-stamo-skills.ps1 failed with exit code $exit_code" >&2
    fi

    return $exit_code
}

install_stamo_skills_linux()
{
    local installer="/d/work/github/ai-skills/install-stamo-skills.sh"

    if [ ! -f "$installer" ]; then
        echo "ERROR: installer not found at $installer" >&2
        return 1
    fi

    bash "$installer"
}

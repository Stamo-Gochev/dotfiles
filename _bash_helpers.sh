grep_with_params()
{
    grep --color -HIRn "$1" --exclude-dir=node_modules --include="$2" .
}

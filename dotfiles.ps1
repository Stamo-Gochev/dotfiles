# helper functions
function not-exist { -not (Test-Path $args) }
Set-Alias !exist not-exist -Option "Constant, AllScope"
Set-Alias exist Test-Path -Option "Constant, AllScope"

Function Create-SymLink ($link, $target)
{
	if (exist $link)
	{
		# hack for symlink testing
		if (Test-ReparsePoint $link)
		{
			Write-Host "Updating symlink to $link to be $target"
			Remove-SymLink $link
			invoke-expression "cmd /c mklink $link $target"
		}
		else
		{
			Write-Host "WARNING: $link exists but is not a symlink. Skipping."
		}
	}
	else
	{
		invoke-expression "cmd /c mklink $link $target"
	}
}

function Test-ReparsePoint([string]$path) {
  $file = Get-Item $path -Force -ea 0
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

Function Create-DirJunction ($link, $target)
{
	if (exist $link)
	{
		if (Test-ReparsePoint $link)
		{
			Write-Host "Updating directory junction $link to $target"
			invoke-expression "cmd /c rmdir `"$link`""
			invoke-expression "cmd /c mklink /J `"$link`" `"$target`""
		}
		else
		{
			Write-Host "WARNING: $link exists but is not a junction. Skipping."
		}
	}
	else
	{
		invoke-expression "cmd /c mklink /J `"$link`" `"$target`""
	}
}

Function Remove-SymLink ($link)
{
	if (exist $link)
	{
		if (Test-ReparsePoint $target)
		{
			Write-Host "WARNING: Deleting symlink to $link."
			invoke-expression "cmd /c del $link"
		}
		else
		{
			Write-Host "The path $link is not a symlink. Skipping."
		}
	}
	else
	{
		Write-Host "The path $link does not exist."
	}
}

Function Get-Current-Directory
{
    $scriptInvocation = (Get-Variable MyInvocation -Scope 1).Value
    return Split-Path $scriptInvocation.MyCommand.Path
}

# install

Write-Host "Installing dotfiles on Windows"

$script_path=Get-Current-Directory
Write-Host "Starting from $script_path"

$file_objects = dir | where {-Not $_.PsIscontainer -AND $_.name -match "_" }

$home_dir=$Env:userprofile
Write-Host "Moving to $home_dir"
Set-Location -Path $home_dir

foreach ($file_object in $file_objects)
{
	# convert _gitconfig to .gitconfig
	$link = $file_object.Name.Remove(0, 1).Insert(0, ".")
	$target=$script_path + "\" + $file_object.Name

	Write-Host "Link: $link"
	Write-Host "Target: $target"

	Create-SymLink $link $target
}

# github copilot: symlink contents of copilot/ into ~/.copilot/
$copilot_dir = Join-Path $home_dir ".copilot"
if (-not (Test-Path $copilot_dir))
{
	New-Item -ItemType Directory -Path $copilot_dir | Out-Null
}

$copilot_source = Join-Path $script_path "copilot"
foreach ($item in Get-ChildItem $copilot_source)
{
	$link = Join-Path $copilot_dir $item.Name
	$target = $item.FullName

	Write-Host "Link: $link"
	Write-Host "Target: $target"

	if ($item.PSIsContainer)
	{
		Create-DirJunction $link $target
	}
	else
	{
		Create-SymLink $link $target
	}
}

Write-Host "Done"


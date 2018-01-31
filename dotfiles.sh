#!/bin/bash

cutstring="DO NOT EDIT BELOW THIS LINE"

echo "Installing dotfiles"

# symlink _<file> to .<file>
for name in _*; do
	target="$HOME/${name/\_/\.}"

	if [ -e $target ]; then
		if [ ! -L $target ]; then
			cutline=`grep -n "$cutstring" "$target" | sed "s/:.*//"`

			if [[ -n $cutline ]]; then
				let "cutline = $cutline - 1"
				echo "Updating $target"

				head -n $cutline "$target" > update_tmp
				startline=`cat -n "$name" | sort -nr | cut -c8- | grep -n "$cutstring" | sed "s/:.*//"`

				if [[ -n $startline ]]; then
					tail -n $startline "$name" >> update_tmp
				else
					cat "$name" >> update_tmp
			fi

			mv update_tmp "$target"
        else
            echo "WARNING: $target exists but is not a symlink."
		fi
    fi
	else
		echo "Creating $target"

		if [[ -n `grep "$cutstring" "$name"` ]]; then
			cp "$PWD/$name" "$target"
		else
			ln -sf "$PWD/$name" "$target"
		fi
	fi
done

if [ ! -d "$HOME/.vim/bundle" ]; then
    echo "Installing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim  ~/.vim/bundle/Vundle.vim
    mkdir -p ~/.vim/backup
    vim +PluginInstall +qall
fi

echo "Done"
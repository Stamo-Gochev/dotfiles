# basic
sudo apt-get install curl
sudo apt-get install build-essential cmake
sudo apt-get install python3-dev python3-pip python3-tk python3-lxml python3-six

# dev

# used for apt-add-repository
sudo apt-get install python-software-properties software-properties-common
# install latest git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y

sudo apt-get install vim
sudo apt-get install ctags
sudo apt-get install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get install tmux
sudo apt-get install ack-grep
sudo apt-get install ag

# install latest node
sudo apt-get install nodejs
sudo apt-get install npm
sudo npm cache clean -f
# install helper tool n
sudo npm install -g n
# latest stable node
sudo apt-get install nvm
sudo n stable

# npm tools
sudo npm install -g git-open
sudo npm install -g npm-install-peers
sudo npm install -g lerna
sudo npm install -g webpack
sudo npm install -g webpack-dev-server
sudo npm install -g typescript
sudo npm install -g react
sudo npm install -g react-redux
sudo npm isntall -g redux
sudo apt-get install dconf-cli
sudo dpkg --configure -a
sudo apt-get install dconf-cli
# export with dconf dump /org/cinnamon/desktop/keybindings/ > dconf-settings.conf
# import with dconf load /org/cinnamon/desktop/keybindings/ < dconf-settings.conf

bash dotfiles.sh

# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
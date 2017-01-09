#!/bin/bash

#Author:ymc023
#Mail:ymc023@163.com 
#Platform:centos7&debian8
#Date:2016年02月04日 星期四 10时21分07秒

echo "vimIDE setup is running now......"
#apt
if which apt-get >/dev/null; then
    	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git
#yum
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel	
fi

#Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi
sudo easy_install -ZU autopep8 
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
mv -f ~/.vimrc ~/.vimrc_old
rm -rf ~/.vim/bundle/vundle
echo  "install bundle..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle


cp vimrc ~/.vimrc
cp -rf after/ ~/.vim/
cp -rf bundle/ ~/.vim/
cp -rf dict/ ~/.vim/
cp -rf ftdetect/ ~/.vim/
cp -rf indent/ ~/.vim/
cp -rf plugin/ ~/.vim/
cp -rf syntax/ ~/.vim/
cp -rf autoload/ ~/.vim/
cp -rf colors/ ~/.vim/
cp -rf doc/ ~/.vim/
cp -rf ftplugin/ ~/.vim/
cp -rf snippets/ ~/.vim/
cp -rf markdown.pl ~/.vim/

echo  "install plugin..."
echo  "Wait for minutes please..." >setuplog
echo  "请稍候......">>setuplog
vim  setuplog -c "PluginInstall" -c "q" -c "q" 
rm -rf setuplog

echo "OK.Congratulations!"


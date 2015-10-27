#!/bin/sh

if [ ! -d ~/dotfiles ]; then
  git clone git@github.com:bobchin/dotfiles.git ~/dotfiles
fi
pushd ~/dotfiles

git submodule init
git submodule update

for i in `ls -a`
do
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = ".gitmodules" ] && continue
  [ $i = ".vim" ] && continue
  [ $i = "README.md" ] && continue
  [ $i = "setup.sh" ] && continue
  [ $i = "antigen" ] && continue

  [ -a ~/$i ] || ln -s ~/dotfiles/$i ~/
done

vim -c ':NeoBundleInstall vimproc' -c ':q!' -c ':q!'
vim

popd

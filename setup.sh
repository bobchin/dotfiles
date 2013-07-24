#!/bin/sh

[[ -e ~/dotfiles ]] || git clone git@github.com:bobchin/dotfiles.git ~/dotfiles
pushd ~/dotfiles

git submodule init
git submodule update

for i in `ls -a`
do
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = ".gitmodules" ] && continue
  [ $i = "README.md" ] && continue
  [ $i = "setup.sh" ] && continue
  [ $i = "antigen" ] && continue
  ln -s ~/dotfiles/$i ~/
done

#vim -c ':NeoBundleInstall' -c ':q!' -c ':q!'
#if [ `uname` = "Darwin" ]; then
#  pushd ~/dotfiles/.vim/bundle/vimproc
#  make -f make_mac.mak
#  popd
#fi

popd

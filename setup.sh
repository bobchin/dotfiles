#!/bin/sh

DOTPATH=~/dotfiles
GITHUB_URL=git@github.com:bobchin/dotfiles.git
TARBALL=https://github.com/bobchin/dotfiles/archive/master.tar.gz

# ファイルのダウンロード
if [ ! -d ${DOTPATH} ]; then

  # git を使う場合
  if has "git"; then
    git clone --recursive ${GITHUB_URL} ${DOTPATH}

  # curl or wget
  elif has "curl" || has "wget"; then
    if has "curl"; then
      curl -L ${TARBALL}
    elif has "wget"; then
      wget -O ${TARBALL}
    fi | tar xv -

    # 解凍後リネーム
    mv -f dotfiles-master ${DOTPATH}

  else
    die "curl or wget required"
  fi
fi

# 配置処理
pushd ${DOTPATH}
if [ $? -ne 0 ]; then
  die "not found: ${DOTPATH}"
fi

git submodule init
git submodule update

for i in .??*
do
  [ $i = ".git" ] && continue
  [ $i = ".gitmodules" ] && continue

  [ -a ~/$i ] || ln -snfv ${DOTPATH}/$i ~/$i
done

vim -c ':NeoBundleInstall vimproc' -c ':q!' -c ':q!'
vim

popd

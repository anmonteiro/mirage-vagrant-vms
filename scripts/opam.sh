#!/bin/sh

set -ex

rm -rf ~/.config ~/bin ~/.opam
sudo apt-get install -y ocaml ocaml-native-compilers camlp4-extra # ocaml

mkdir ~/bin
export PATH=$HOME/bin:$PATH

sudo apt-get install -y unzip curl bubblewrap

DISTRO=$(cut -f 1 -d ' ' -s /etc/issue)
if [ "$DISTRO" = "Debian" ] ; then
    wget https://github.com/ocaml/opam/releases/download/2.0.2/opam-2.0.2-x86_64-linux -O opam
    sudo mv opam /usr/local/bin
    sudo chmod a+x /usr/local/bin/opam
else
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 630F626C9FD811EBC19DF0955B2D0C5561707B09
    sudo add-apt-repository ppa:avsm/ppa -y
    sudo apt-get update
fi

opam init --verbose --auto-setup --yes

eval $(opam config env)
rm -f Release.key

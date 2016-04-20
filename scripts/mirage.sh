#!/bin/sh

set -ex

sudo apt-get install -y libssl-dev pkg-config # required by many mirage apps

# update opam installation
opam switch $(opam switch | grep Official | tail -1 | awk '{print $3}')
eval $(opam config env)

# install mirage 
opam install mirage --yes

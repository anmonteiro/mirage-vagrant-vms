#!/bin/sh

set -ex

sudo apt-get install -y libssl-dev pkg-config libgmp-dev autoconf # required by many mirage apps

# update opam installation
# opam switch create 4.05.0 #$(opam switch | grep Official | tail -1 | awk '{print $3}')
eval $(opam config env)

# install mirage
opam install -y mirage
# opam pin add mirage git+https://github.com/anmonteiro/mirage#httpaf --yes
# opam pin add httpaf-mirage git+https://github.com/anmonteiro/httpaf#mirage --yes

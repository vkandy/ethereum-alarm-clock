#!/bin/bash
#
# Install solc 
#

set -e
set -u

if [ ! -e solc-versions/solidity-0.3.6/build/solc/solc ] ; then
    # cache not present (first run or cleared), perform full installation procedure
    wget -O solc.tar.gz "https://github.com/ethereum/solidity/archive/v0.3.6.tar.gz"
    install -d solc-versions
    cd solc-versions
    tar -zxvf ../solc.tar.gz
    cd solidity-0.3.6
    ./scripts/install_deps.sh
    mkdir -p build
    cd build
    cmake .. && make
    ln -fs $PWD/solc/solc ../../../solc-versions/solc-0.3.6
    chmod +x ../../../solc-versions/solc-0.3.6
    echo "Geth installed at $PWD/solc-0.3.6"
else
    # cached version present, just install package dependencies
    cd solc-versions
    cd solidity-0.3.6
    ls -al
    ./scripts/install_deps.sh
    echo "Geth already installed at $PWD/solc/solc-0.3.6"
fi

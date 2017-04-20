#!/bin/bash
#
# Install solc
#

set -e
set -u

# currently just one, should be the same as in `.travis.yml`, section `cache`
version="0.4.6"

if [ ! -e solc-versions/solidity-${version}/build/solc/solc ] ; then
    # cache not present (first run or cleared), perform full installation procedure
    wget "https://github.com/ethereum/solidity/archive/v${version}.tar.gz"
    install -d solc-versions
    cd solc-versions
    tar -zxvf ../v${version}.tar.gz
    cd solidity-${version}
    ./scripts/install_deps.sh
    mkdir -p build
    cd build
    cmake .. && make
    ln -fs $PWD/solc/solc ../../../solc-versions/solc-${version}
    chmod +x ../../../solc-versions/solc-${version}
    echo "Solidity compiler installed at $PWD/solc-${version}"
else
    # cached version present, just install package dependencies
    cd solc-versions
    find ./ # FIXME: debug "list all files", remove
    cd solidity-${version}
    ./scripts/install_deps.sh
    echo "Solidity compiler already installed at $PWD/solc/solc-${version}"
fi

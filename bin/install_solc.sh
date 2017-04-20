#!/bin/bash
#
# Install solc
#

set -e
set -u

if [ ! -e $SOLC_BINARY ] ; then
    # cache not present (first run or cleared), perform full installation procedure

    # pwd: .
    wget "https://github.com/ethereum/solidity/archive/v$SOLC_VERSION.tar.gz"
    install -d solc-versions
    cd solc-versions

    # pwd: ./solc-versions
    tar -zxvf ../v$SOLC_VERSION.tar.gz
    cd solidity-$SOLC_VERSION

    # pwd: ./solc-versions/solidity-$SOLC_VERSION
    ./scripts/install_deps.sh

    mkdir -p build
    cd build

    # pwd: ./solc-versions/solidity-$SOLC_VERSION/build
    cmake .. && make

    ln -fs $PWD/solc/solc $SOLC_BINARY
    chmod +x $SOLC_BINARY

    echo "Solidity compiler installed at $SOLC_BINARY"
else
    # cached version present, just install package dependencies
    echo "Solidity compiler already installed at $SOLC_BINARY"
    cd solc-versions/solidity-$SOLC_VERSION
    ./scripts/install_deps.sh
fi

# DEBUG
ls -l $SOLC_BINARY
file $SOLC_BINARY
ldd $SOLC_BINARY

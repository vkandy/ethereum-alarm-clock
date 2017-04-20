#!/bin/bash
#
# Install solc
#

set -e
set -u

if [ ! -e $SOLC_BINARY ] ; then
    echo "Solidity not present, performing full installation procedure..."

    mkdir -p solc-versions
    cd solc-versions

    # get sources, put in dir source-$SOLC_VERSION
    git clone --recurse-submodules --branch v$SOLC_VERSION --depth 50 \
        https://github.com/ethereum/solidity.git source-$SOLC_VERSION
    ./source-$SOLC_VERSION/scripts/install_deps.sh

    # get pre-built binaries, put in dir binary--$SOLC_VERSION
    wget https://github.com/ethereum/solidity/releases/download/v$SOLC_VERSION/solidity-ubuntu-trusty.zip
    unzip solidity-ubuntu-trusty.zip -d binary-$SOLC_VERSION

    echo "Solidity installed at $SOLC_BINARY"
else
    echo "Solidity already installed at $SOLC_BINARY, installing dependencies..."

    cd solc-versions
    ./source-$SOLC_VERSION/scripts/install_deps.sh
fi

# DEBUG
ls -l $SOLC_BINARY
file $SOLC_BINARY
ldd $SOLC_BINARY

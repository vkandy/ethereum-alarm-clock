#!/bin/bash
#
# Install solc
#

set -e
set -u

# conditionally fetch binaries/script, and put in Travis-cached dir
if [ ! -e $SOLC_BINARY ] ; then
    echo "Solidity not present, fetching binary and dependency installation script."

    mkdir -p solc-versions
    cd solc-versions

    # get pre-built binaries, put in $SOLC_BINARY_PATH
    wget "https://github.com/ethereum/solidity/releases/download/v$SOLC_VERSION/solidity-ubuntu-trusty.zip"
    unzip solidity-ubuntu-trusty.zip -d $SOLC_BINARY_PATH

    echo "Solidity compiler installed as $SOLC_BINARY"

    # get install_deps.sh script
    cd $SOLC_BINARY_PATH
    wget -O install_solc_deps.sh "https://github.com/ethereum/solidity/raw/v$SOLC_VERSION/scripts/install_deps.sh"
    chmod +x install_solc_deps.sh
fi

# unconditionally install deps
$SOLC_BINARY_PATH/install_solc_deps.sh

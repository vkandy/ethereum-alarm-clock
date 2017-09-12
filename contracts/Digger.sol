pragma solidity ^0.4.15;

contract Digger {
    /*
     * Recursively call this contracts code, each time extending the stack
     * depth by 1 until the stack depth has been extended by `n` levels.
     */
    function __dig(uint n) constant returns (bool) {
        if (n == 0) return true;
        assert(address(this).delegatecall(bytes4(sha3("__dig(uint256)")), n - 1));
    }
}

pragma solidity ^0.4.15;


/**
 * Safe math operations.
 */
library MathLib {
    /// 2**255 - 1
    uint constant INT_MAX = 57896044618658097711785492504343953926634992332820282019728792003956564819967;

    /**
     * @dev Subtracts b from a in a manner such that zero is returned when an underflow condition is met.
     * @param a LHS value
     * @param b RHS value
     * @return (a-b) if a is larger. Otherwise, 0.
     */
    function flooredSub(uint a, uint b) returns (uint) {
        if (b >= a) {
            return 0;
        }
        else {
            return a - b;
        }
    }

    /**
     * @dev Adds b to a in a manner that throws an exception when overflow conditions are met.
     * @param a LHS value
     * @param b RHS value
     * @return sum of both arguments
     */
    function safeAdd(uint a, uint b) returns (uint) {
        uint sum = a + b;
        assert(sum >= a);
        return sum;
    }

    /**
     * @dev Multiplies a by b in a manner that throws an exception when overflow conditions are met.
     * @param a LHS value
     * @param b RHS value
     * @return (a-b) if a is larger. Otherwise, 0.
     */
    function safeMultiply(uint a, uint b) returns (uint) {
        uint product = a * b;
        assert(b == 0 || product / b == a);
        return product;
    }

    /**
     * @dev Return the larger of a or b.  Returns a if a == b.
     * @param a LHS value
     * @param b RHS value
     * @return a or b.
     */
    function max(uint a, uint b) returns (uint) {
        if (a >= b) {
            return a;
        }
        else {
            return b;
        }
    }

    /**
     * @dev Return the larger of a or b.  Returns a if a == b.
     * @param a LHS value
     * @param b RHS value
     * @return a or b.
     */
    function min(uint a, uint b) returns (uint) {
        if (a <= b) {
            return a;
        }
        else {
            return b;
        }
    }

    /**
     * @dev Returns a represented as a signed integer in a manner that throw an
     * exception if casting to signed integer would result in a negative
     * number.
     * @param a an unsigned int
     * @return a signed int
     */
    function safeCastSigned(uint a) returns (int) {
        assert(a <= INT_MAX);
        return int(a);
    }
}

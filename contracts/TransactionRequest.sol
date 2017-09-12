pragma solidity ^0.4.15;


import {RequestLib} from "contracts/RequestLib.sol";
import {TransactionRequestInterface} from "contracts/TransactionRequestInterface.sol";
import {Digger} from "contracts/Digger.sol";


contract TransactionRequest is Digger, TransactionRequestInterface {
    using RequestLib for RequestLib.Request;

    /*
     *  addressArgs[0] - meta.owner
     *  addressArgs[1] - paymentData.donationBenefactor
     *  addressArgs[2] - txnData.toAddress
     *
     *  uintArgs[0]  - paymentData.donation
     *  uintArgs[1]  - paymentData.payment
     *  uintArgs[2]  - schedule.claimWindowSize
     *  uintArgs[3]  - schedule.freezePeriod
     *  uintArgs[4]  - schedule.reservedWindowSize
     *  uintArgs[5]  - schedule.temporalUnit
     *  uintArgs[7]  - schedule.windowSize
     *  uintArgs[6]  - schedule.windowStart
     *  uintArgs[8]  - txnData.callGas
     *  uintArgs[9]  - txnData.callValue
     *  uintArgs[10] - txnData.requiredStackDepth
     */
    function TransactionRequest(address[4] addressArgs,
    uint[11] uintArgs,
    bytes callData) {
        txnRequest.initialize(addressArgs, uintArgs, callData);
    }

    /*
     *  Allow receiving ether.  This is needed if there is a large increase in
     *  network gas prices.
     */
    function() {
    }

    RequestLib.Request txnRequest;

    /*
     *  Actions
     */
    function execute() public returns (bool) {
        return txnRequest.execute();
    }

    function cancel() public returns (bool) {
        return txnRequest.cancel();
    }

    function claim() public returns (bool) {
        return txnRequest.claim();
    }

    /*
     *  Data accessor functions.
     */
    //
    //  TODO: figure out why returning RequestLib.serialize() isn't working.
    //
    function requestData()
    constant
    returns (
        address[6],
        bool[3],
        uint[15],
        uint8[1]
    )
    {
        assert(txnRequest.serialize());
        return (
            txnRequest.serializedValues.addressValues,
            txnRequest.serializedValues.boolValues,
            txnRequest.serializedValues.uintValues,
            txnRequest.serializedValues.uint8Values
        );
    }

    function callData() constant returns (bytes) {
        return txnRequest.txnData.callData;
    }

    /*
     *  Pull based payment functions.
     */
    function refundClaimDeposit() public returns (bool) {
        return txnRequest.refundClaimDeposit();
    }

    function sendDonation() public returns (bool) {
        return txnRequest.sendDonation();
    }

    function sendPayment() public returns (bool) {
        return txnRequest.sendPayment();
    }

    function sendOwnerEther() public returns (bool) {
        return txnRequest.sendOwnerEther(0);
    }
}

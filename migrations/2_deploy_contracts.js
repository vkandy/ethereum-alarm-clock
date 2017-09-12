/**
 * Truffle deployment
 * @type {*|Object}
 */
let ExecutionLib = artifacts.require("./lib/ExecutionLib.sol"),
    MathLib      = artifacts.require("./lib/MathLib.sol"),
    PaymentLib   = artifacts.require("./lib/PaymentLib.sol");

let BlockScheduler = artifacts.require("./BlockScheduler.sol");


module.exports = function(deployer) {
    deployer.deploy(ExecutionLib);
    deployer.deploy(MathLib);
    deployer.deploy(PaymentLib);

    deployer.deploy(BlockScheduler);
};

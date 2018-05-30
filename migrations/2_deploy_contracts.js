//const Wrestling = artifacts.require("./Wrestling.sol")
const Handshake = artifacts.require("./Handshake.sol")

module.exports = function(deployer) {
	//deployer.deploy(Wrestling);
	deployer.deploy(Handshake);
};
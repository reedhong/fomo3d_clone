var PetCore = artifacts.require("./PetCore.sol");

module.exports = function(deployer, network, accounts) {
  console.log('network is '+network);
  console.log(accounts);
  console.log(accounts[0]);
  console.log('deploy PetCore contract to develop network, account address is '+accounts[0]);
  deployer.deploy(PetCore);
};

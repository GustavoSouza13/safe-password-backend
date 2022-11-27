var LoginApp = artifacts.require("./storage/LoginApp.sol");
var DependentContracts = artifacts.require("./storage/DependentContracts.sol");

var Proxy = artifacts.require("./proxy/Proxy.sol");
var LoginAppService = artifacts.require("./service/LoginAppService.sol");
var LoginAppStorage = artifacts.require("./storage/LoginAppStorage.sol");

module.exports = function(deployer) {
    deployer.deploy(LoginApp);
    deployer.deploy(DependentContracts);
    
    deployer.deploy(Proxy);
    deployer.deploy(LoginAppService);
    deployer.deploy(LoginAppStorage);
}
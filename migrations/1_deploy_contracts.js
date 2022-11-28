var LoginApp = artifacts.require("./storage/LoginApp.sol");
var DependentContracts = artifacts.require("./storage/DependentContracts.sol");
var DomainAbstract = artifacts.require("./storage/DomainAbstract.sol");

var Proxy = artifacts.require("./proxy/Proxy.sol");

var LoginAppService = artifacts.require("./service/LoginAppService.sol");
var DomainService = artifacts.require("./service/DomainService.sol");

var LoginAppStorage = artifacts.require("./storage/LoginAppStorage.sol");
var DomainStorage = artifacts.require("./storage/DomainStorage.sol");

module.exports = function(deployer) {
    deployer.deploy(LoginApp);
    deployer.deploy(DependentContracts);
    deployer.deploy(DomainAbstract);
    
    deployer.deploy(Proxy);

    deployer.deploy(LoginAppService);
    deployer.deploy(DomainService);

    deployer.deploy(LoginAppStorage);
    deployer.deploy(DomainStorage);
}
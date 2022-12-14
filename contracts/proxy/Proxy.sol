// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';

import '../LoginApp.sol';
import '../DomainAbstract.sol';

import '../service/LoginAppService.sol';
import '../service/DomainService.sol';

contract Proxy is DependentContracts, LoginApp, DomainAbstract {

    LoginAppService internal loginAppService;
    DomainService internal domainService;

    function registerUser(User calldata user) public {
        loginAppService.register(user);
    }

    function updateUser(User calldata user) public {
        loginAppService.updateUser(user);
    }

    function getEmptyUser() public view returns (User memory) {
        return loginAppService.getEmptyUser();
    }

    function getUser(address wallet) public view returns (User memory) {
        return loginAppService.getUser(wallet);
    }

    function login(address wallet, string memory password) public {
        loginAppService.login(wallet, password);
    }

    function registerDomain(Domain memory domain) public {
        domainService.register(domain);
    }

    function updateDomain(Domain memory domain) public {
        domainService.update(domain);
    }

    function deleteDomain(string memory domain) public {
        domainService.remove(domain);
    }

    function getDomainsOnly(address wallet) public view returns (string[] memory) {
        return domainService.getDomainsOnly(wallet);
    }

    function getPasswordByDomain(string memory localDomain, address wallet) public view returns (string memory) {
        return domainService.getPasswordByDomain(localDomain, wallet);
    }

    function loadDependencies() internal override {
        loginAppService = LoginAppService(address(this.getDependencieAddress('LoginAppService')));
        domainService = DomainService(address(this.getDependencieAddress('DomainService')));
    }
}
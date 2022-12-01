// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';

import '../DomainAbstract.sol';
import '../storage/DomainStorage.sol';

contract DomainService is DependentContracts, DomainAbstract {

    DomainStorage private domainStorage;

    event DomainRegister();
    

    function register(Domain memory domain) external {
        domainStorage.register(domain);
        emit DomainRegister();
    }

    function getDomainsOnly(address wallet) external view returns (Domain[] memory) {
        return domainStorage.getDomainsOnly(wallet);
    }

    function getPasswordByDomain(string memory localDomain, address wallet) external view returns (bytes32) {
        return domainStorage.getPasswordByDomain(localDomain, wallet);
    }

    function getTeste(address wallet) public returns (uint256) {
        return 0;
    }

    function loadDependencies() public override {
        domainStorage = DomainStorage(address(this.getDependencieAddress('DomainStorage')));
    }
}
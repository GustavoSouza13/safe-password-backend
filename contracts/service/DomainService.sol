// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';

import '../DomainAbstract.sol';
import '../storage/DomainStorage.sol';

contract DomainService is DependentContracts, DomainAbstract {

    DomainStorage private domainStorage;

    event DomainRegister();
    event DomainUpdated();

    function register(Domain memory domain) external {
        domainStorage.register(domain);
        emit DomainRegister();
    }

    function update(Domain memory domain) external {
        domainStorage.update(domain);
        emit DomainUpdated();
    }

    function getDomainsOnly(address wallet) external view returns (string[] memory) {
        return domainStorage.getDomainsOnly(wallet);
    }

    function getPasswordByDomain(string memory localDomain, address wallet) external view returns (string memory) {
        return domainStorage.getPasswordByDomain(localDomain, wallet);
    }

    function loadDependencies() internal override {
        domainStorage = DomainStorage(address(this.getDependencieAddress('DomainStorage')));
    }
}
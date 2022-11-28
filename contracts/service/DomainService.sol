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

    function getDomainsOnly() external view returns (Domain[] memory) {
        return domainStorage.getDomainsOnly();
    }

    function loadDependencies() public override {
        domainStorage = DomainStorage(address(dependencies['DomainStorage']));
    }
}
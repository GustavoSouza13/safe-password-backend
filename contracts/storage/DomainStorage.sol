// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DomainAbstract.sol';

contract DomainStorage is DomainAbstract {

    struct DomainsControl {
        uint256 total;
        Domain[] domains;
    }

    mapping(address => DomainsControl) domainsAddress;

    function register(Domain memory domain) external {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        domainsControl.total++;
        domainsControl.domains.push(domain);
    }

    function getDomainsOnly() external view returns (Domain[] memory) {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        Domain[] memory domains = new Domain[](domainsControl.total);

        for (uint256 i = 0; i < domainsControl.total; i++) {
            Domain memory domain = domainsControl.domains[i];
            domains[i] = Domain(domain.domain, bytes32(0));
        }

        return domains;
    }
}
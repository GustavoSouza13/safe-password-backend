// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DomainAbstract.sol';

contract DomainStorage is DomainAbstract {

    struct DomainsControl {
        uint256 total;
        mapping(uint256 => Domain) domains;
        mapping(string => uint256) domainsIndex;
    }

    mapping(address => DomainsControl) internal domainsAddress;

    function register(Domain memory domain) external {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        if (domainsControl.domainsIndex[domain.domain] > 0) {
            domainsControl.domains[domainsControl.domainsIndex[domain.domain]] = domain;
        } else {
            domainsControl.domainsIndex[domain.domain] = domainsControl.total;
            domainsControl.domains[domainsControl.total++] = domain;
        }
    }

    function update(Domain memory domain) external {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        domainsControl.domains[domainsControl.domainsIndex[domain.domain]] = domain;
    }

    function remove(string memory domain) external {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        domainsControl.domains[domainsControl.domainsIndex[domain]] = emptyDomain;
    }

    function getDomainsOnly(address wallet) external view returns (string[] memory) {
        DomainsControl storage domainsControl = domainsAddress[wallet];
        string[] memory domains = new string[](domainsControl.total);

        for (uint256 i = 0; i < domainsControl.total; i++) {
            Domain memory domain = domainsControl.domains[i];
            domains[i] = domain.domain;
        }

        return domains;
    }

    function getPasswordByDomain(string memory localDomain, address wallet) external view returns (string memory) {
        DomainsControl storage domainsControl = domainsAddress[wallet];
        for (uint256 i = 0; i < domainsControl.total; i++) {
            Domain memory domain = domainsControl.domains[i];
            if (equals(domain.domain, localDomain)) {
                return domain.password;
            }
        }

        return '';
    }

    function equals(string memory string1, string memory string2) internal pure returns (bool) {
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }
}
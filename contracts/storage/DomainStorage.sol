// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DomainAbstract.sol';

contract DomainStorage is DomainAbstract {

    struct DomainsControl {
        uint256 total;
        mapping(uint256 => Domain) domains;
    }

    mapping(address => DomainsControl) domainsAddress;

    function register(Domain memory domain) external {
        DomainsControl storage domainsControl = domainsAddress[tx.origin];
        domainsControl.domains[domainsControl.total++] = domain;
    }

    function getDomainsOnly(address wallet) external view returns (Domain[] memory) {
        DomainsControl storage domainsControl = domainsAddress[wallet];
        Domain[] memory domains = new Domain[](domainsControl.total);

        for (uint256 i = 0; i < domainsControl.total; i++) {
            Domain memory domain = domainsControl.domains[i];
            domains[i] = Domain(domain.domain, bytes32(0));
        }

        return domains;
    }

    function getPasswordByDomain(string memory localDomain, address wallet) external view returns (bytes32) {
        DomainsControl storage domainsControl = domainsAddress[wallet];
        for (uint256 i = 0; i < domainsControl.total; i++) {
            Domain memory domain = domainsControl.domains[i];
            if (equals(domain.domain, localDomain)) {
                return domain.password;
            }
        }

        return bytes32(0);
    }

    function equals(string memory string1, string memory string2) public pure returns (bool) {
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }
}
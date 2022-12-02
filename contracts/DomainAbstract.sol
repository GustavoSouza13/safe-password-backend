// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DomainAbstract {

    struct Domain {
        string domain;
        string password;
    }

    Domain internal emptyDomain = Domain('', '');

    function equals(Domain memory domain1, Domain memory domain2) external pure returns (bool) {
        return keccak256(abi.encodePacked(domain1.domain, domain1.password)) == keccak256(abi.encodePacked(domain2.domain, domain2.password));
    }
}
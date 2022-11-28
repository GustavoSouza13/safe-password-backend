// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DomainAbstract {

    struct Domain {
        string domain;
        bytes32 password;
    }

    Domain emptyDomain = Domain('', bytes32(0));

    function equals(Domain memory domain1, Domain memory domain2) public pure returns (bool) {
        return keccak256(abi.encodePacked(domain1.domain, domain1.password)) == keccak256(abi.encodePacked(domain2.domain, domain2.password));
    }
}
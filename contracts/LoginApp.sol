// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LoginApp {

    struct User {
        string name;
        string email;
        string wallet;
        bytes32 password;
    }

    User internal emptyUser = User('', '', '', bytes32(0));

    function equals(User memory user1, User memory user2) internal pure returns (bool) {
        return keccak256(abi.encodePacked(user1.name, user1.email, user1.wallet, user1.password)) == keccak256(abi.encodePacked(user2.name, user2.email, user2.wallet, user2.password));
    }
}
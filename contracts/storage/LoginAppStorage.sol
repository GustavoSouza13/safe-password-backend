// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../LoginApp.sol';

contract LoginAppStorage is LoginApp {
    
    mapping(bytes32 => User) private users;

    function findPassword(string memory username) public view returns (bytes32) {
        return users[sha256(abi.encodePacked(username))].password;
    }

    function register(User calldata user) public view returns (User memory) {
        return users[sha256(abi.encodePacked(user.name))];
    }
}
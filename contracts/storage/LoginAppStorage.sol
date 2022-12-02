// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../LoginApp.sol';

contract LoginAppStorage is LoginApp {
    
    mapping(bytes32 => User) private users;

    function register(User calldata user) external {
        users[sha256(abi.encodePacked(user.wallet))] = user;
    }

    function updateUser(User calldata user) external {
        users[sha256(abi.encodePacked(user.wallet))] = user;
    }

    function findUser(address wallet) external view returns (User memory) {
        return users[sha256(abi.encodePacked(wallet))];
    }
}
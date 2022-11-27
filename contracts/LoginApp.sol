// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LoginApp {

    struct User {
        string name;
        address wallet;
        bytes32 password;
        address localWallet;
    }

    User internal emptyUser = User('', address(0), bytes32(0), address(0));

    function equals(User memory user1, User memory user2) internal pure returns (bool) {
        return keccak256(abi.encodePacked(user1.name, user1.wallet, user1.password, user1.localWallet)) == keccak256(abi.encodePacked(user2.name, user2.wallet, user2.password, user2.localWallet));
    }
}
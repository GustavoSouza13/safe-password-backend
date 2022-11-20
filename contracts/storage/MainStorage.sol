// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../storage/LoginAppStorage.sol';

contract MainStorage {
    
    mapping(address => address[]) private logins;
}
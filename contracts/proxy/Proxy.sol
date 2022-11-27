// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';

import '../LoginApp.sol';
import '../service/LoginAppService.sol';

contract Proxy is DependentContracts, LoginApp {

    LoginAppService internal loginAppService;

    function register(User calldata user) public {
        loginAppService.register(user);
    }

    function updateUser(User calldata user) public {
        loginAppService.updateUser(user);
    }

    function login(address wallet, bytes32 password) public {
        loginAppService.login(wallet, password);
    }

    function getEmptyUser() public returns (User memory) {
        return loginAppService.getEmptyUser();
    }

    function getUser(address wallet) public returns (User memory) {
        return loginAppService.getUser(wallet);
    }

    function loadDependencies() public override {
        loginAppService = LoginAppService(address(dependencies['LoginAppService']));
    }
}
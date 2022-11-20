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

    function getEmptyUser() public view returns (User memory) {
        return loginAppService.getEmptyUser();
    }

    function getUser(address wallet) public view returns (User memory) {
        return loginAppService.getUser(wallet);
    }

    function getPassword(address wallet) public view returns (bytes32) {
        return loginAppService.getPassword(wallet);
    }

    function loadDependencies() public override {
        loginAppService = LoginAppService(address(dependencies['LoginAppService']));
    }
}
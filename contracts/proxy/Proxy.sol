// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';

import '../LoginApp.sol';
import '../service/LoginAppService.sol';

contract Proxy is DependentContracts, LoginApp {

    LoginAppService internal loginAppService;

    function register(User calldata user) public view returns (User memory) {
        return loginAppService.register(user);
    }

    function getPassword(string memory username) public view returns (bytes32) {
        return loginAppService.getPassword(username);
    }

    function loadDependencies() public override {
        loginAppService = LoginAppService(address(dependencies['LoginAppService']));
    }
}
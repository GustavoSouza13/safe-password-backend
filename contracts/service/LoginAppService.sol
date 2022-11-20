// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';
import '../LoginApp.sol';
import '../storage/LoginAppStorage.sol';

contract LoginAppService is DependentContracts, LoginApp {

    LoginAppStorage internal loginAppStorage;

    function register(User calldata user) public view returns (User memory) {
        return loginAppStorage.register(user);
    }

    function login(string memory username, bytes32 password) public view returns (string memory) {
        bytes32 storagePass = loginAppStorage.findPassword(username);
        require(password == storagePass, "Password not equal");
        return "passou";
    }

    function getPassword(string memory username) public view returns (bytes32) {
        try loginAppStorage.findPassword(username) returns (bytes32 pass) {
             return pass;
        } catch {
            return "deu erro";
        }
    }

    function loadDependencies() public override {
        loginAppStorage = LoginAppStorage(address(dependencies['LoginAppStorage']));
    }
}
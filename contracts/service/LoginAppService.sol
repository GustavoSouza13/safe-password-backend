// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';
import '../LoginApp.sol';
import '../storage/LoginAppStorage.sol';

contract LoginAppService is DependentContracts, LoginApp {

    LoginAppStorage internal loginAppStorage;

    event UserRegister (
        string teste
    );

    event UserAlredyRegister (
        string teste
    );

    function register(User calldata user) public {
        if (equals(loginAppStorage.findUser(user.wallet), emptyUser)) {
            loginAppStorage.register(user);
            emit UserRegister('registrou');
        } else {
            emit UserAlredyRegister('registrado ja estava');
        }
    }

    function getEmptyUser() public view returns (User memory) {
        return emptyUser;
    }

    function getUser(address wallet) public view returns (User memory) {
        return loginAppStorage.findUser(wallet);
    }


    // function login(string memory username, bytes32 password) public view returns (string memory) {
    //     User memory user = loginAppStorage.findUser(username);
    //     require(password == user.password, "Password not equal");
    //     return "passou";
    // }

    function getPassword(address wallet) public view returns (bytes32) {
        try loginAppStorage.findUser(wallet) returns (User memory user) {
             return user.password;
        } catch {
            return "deu erro";
        }
    }

    function loadDependencies() public override {
        loginAppStorage = LoginAppStorage(address(dependencies['LoginAppStorage']));
    }
}
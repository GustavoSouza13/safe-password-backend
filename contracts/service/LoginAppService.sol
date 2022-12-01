// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '../DependentContracts.sol';
import '../LoginApp.sol';
import '../storage/LoginAppStorage.sol';

contract LoginAppService is DependentContracts, LoginApp {

    LoginAppStorage internal loginAppStorage;

    event UserRegister(User user);
    event UserAlredyRegister();
    event UserNotFound();

    event AccessGranted(User user);
    event AccessDenied(string reason);
    

    function register(User calldata user) public {
        if (equals(loginAppStorage.findUser(user.wallet), emptyUser)) {
            loginAppStorage.register(user);
            emit UserRegister(user);
        } else {
            emit UserAlredyRegister();
        }
    }

    function updateUser(User calldata user) public {
        loginAppStorage.updateUser(user);
    }

    function login(address wallet, bytes32 password) public {
        User memory user = loginAppStorage.findUser(wallet);
        if (equals(user, emptyUser)) {
            emit UserNotFound();
        } else {
            if (password != user.password) {
                emit AccessDenied('invalid_password');
            } else {
                emit AccessGranted(user);
            }
            // require(password == user.password, "Password not equal");
            // emit AccessGranted();
        }
    }

    function getEmptyUser() public view returns (User memory) {
        return emptyUser;
    }

    function getUser(address wallet) public returns (User memory) {
        User memory user = loginAppStorage.findUser(wallet);
        if (equals(user, emptyUser)) {
            emit UserNotFound();
        } else {
            return user;
        }
    }

    // function getPassword(address wallet) public view returns (bytes32) {
    //     try loginAppStorage.findUser(wallet) returns (User memory user) {
    //          return user.password;
    //     } catch {
    //         return "deu erro";
    //     }
    // }

    function loadDependencies() public override {
        loginAppStorage = LoginAppStorage(address(this.getDependencieAddress('LoginAppStorage')));
    }
}
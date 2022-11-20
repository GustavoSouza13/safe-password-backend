// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DependentContracts {

    struct ContractInfo {
        string name;
        address _address;
    }

    uint256 public totalDependencies = 0;
    mapping(string => address) internal dependencies;

    function addDependencie(ContractInfo calldata contractInfo) public {
        if (keccak256(abi.encodePacked(contractInfo._address)) != keccak256(abi.encodePacked(dependencies[contractInfo.name]))) {
            if (keccak256(abi.encodePacked(dependencies[contractInfo.name])) == keccak256(abi.encodePacked(address(0)))) {
                totalDependencies++;
            }
            
            dependencies[contractInfo.name] = contractInfo._address;
        }
    }

    function loadDependencies() public virtual {
        
    }

    // function somar(uint256 number1, uint256 number2) public {
    //     total += number1 + number2;
    // }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DependentContracts {

    struct ContractInfo {
        string name;
        address _address;
    }

    uint256 internal totalDependencies = 0;
    mapping(uint256 => ContractInfo) internal dependencies;
    mapping(string => uint256) internal dependenciesIndex;

    ContractInfo emptyContractInfo = ContractInfo('', address(0));

    function addDependencies(ContractInfo[] calldata contractsInfo) public {
        for (uint256 i = 0; i < contractsInfo.length; i++) {
            addDependencie(contractsInfo[i]);
        }
                
        loadDependencies();
    }

    function addDependencie(ContractInfo calldata contractInfo) public {
        ContractInfo memory contractInfoSaved = this.getContractInfoByName(contractInfo.name);
        if (contractInfoSaved._address != contractInfo._address) {
            if (contractInfoSaved._address == address(0)) {
                dependenciesIndex[contractInfo.name] = totalDependencies;
                dependencies[totalDependencies++] = contractInfo;
            } else {
                uint256 pos = dependenciesIndex[contractInfo.name];
                dependencies[pos] = contractInfo;
            }
        }
    }

    function getContractInfoByName(string memory name) external view returns (ContractInfo memory) {
        for (uint256 i = 0; i < totalDependencies; i++) {
            ContractInfo memory contractInfoSaved = dependencies[i];
            if (equals(contractInfoSaved.name, name)) {
                return contractInfoSaved;
            }
        }

        return emptyContractInfo;
    }

    function getDependencieAddress(string memory name) external view returns (address) {
        return dependencies[dependenciesIndex[name]]._address;
    }

    // function getDependencies() public view returns (ContractInfo[] memory) {
    //     ContractInfo[] memory contractsInfo = new ContractInfo[](totalDependencies);
    //     for (uint256 i = 0; i < totalDependencies; i++) {
    //         contractsInfo[i] = dependencies[i];
    //     }

    //     return contractsInfo;
    // }

    function loadDependencies() internal virtual {
        
    }

    function equals(ContractInfo memory contractInfo1, ContractInfo memory contractInfo2) external pure returns (bool) {
        return keccak256(abi.encodePacked(contractInfo1.name, contractInfo1._address)) == keccak256(abi.encodePacked(contractInfo2.name, contractInfo2._address));
    }
    
    function equals(string memory string1, string memory string2) internal pure returns (bool) {
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }
}
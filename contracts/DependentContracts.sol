// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DependentContracts {

    struct ContractInfo {
        string name;
        address _address;
    }

    uint256 public totalDependencies = 0;
    mapping(uint256 => ContractInfo) public dependencies;
    mapping(string => uint256) public dependenciesIndex;

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

    function getContractInfoByName(string memory name) external returns (ContractInfo memory) {
        for (uint256 i = 0; i < totalDependencies; i++) {
            ContractInfo memory contractInfoSaved = dependencies[i];
            if (equals(contractInfoSaved.name, name)) {
                return contractInfoSaved;
            }
        }

        return emptyContractInfo;
    }

    // function indexOf(ContractInfo memory contractInfo) external returns (uint256) {
    //     for (uint256 i = 0; i < totalDependencies; i++) {
    //         ContractInfo memory contractInfoSaved = dependencies[i];
    //         if (equals(contractInfoSaved, contractInfo)) {
    //             return i;
    //         }
    //     }

    //     return 0;
    // }

    function getDependencieAddress(string memory name) external returns (address) {
        return dependencies[dependenciesIndex[name]]._address;
    }

    function getDependencies() public view returns (ContractInfo[] memory) {
        ContractInfo[] memory contractsInfo = new ContractInfo[](totalDependencies);
        for (uint256 i = 0; i < totalDependencies; i++) {
            contractsInfo[i] = dependencies[i];
        }

        return contractsInfo;
    }

    function loadDependencies() public virtual {
        
    }

    function equals(ContractInfo memory contractInfo1, ContractInfo memory contractInfo2) public pure returns (bool) {
        return keccak256(abi.encodePacked(contractInfo1.name, contractInfo1._address)) == keccak256(abi.encodePacked(contractInfo2.name, contractInfo2._address));
    }
    
    function equals(string memory string1, string memory string2) public pure returns (bool) {
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }
}
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./DiscountingTypes.sol";

contract DiscountingContract is DiscountingTypes {

    mapping(uint256 => ContractRule) public contractRules;
    uint256 public contractRulesLength = 0;

    function initContract(ContractRule[] memory _rule) public {
        for (uint256 i = 0; i < _rule.length; i++) {
            contractRules[contractRulesLength] = _rule[i];
        }
        contractRulesLength++;
    }

    function getContractRules() external view returns(ContractRule[] memory) {
        ContractRule[] memory result = new ContractRule[](contractRulesLength);
        for (uint256 i = 0; i < result.length; i++) {
            result[i] = contractRules[i];
        }
        return result;
    }

}


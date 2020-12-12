pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./DiscountingTypes.sol";

contract DiscountingContract is DiscountingTypes {

    function getContractRule() external view returns(ContractRule memory) {
        return ContractRule(123,123);
    }

}


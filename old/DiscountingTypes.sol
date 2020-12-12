pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

interface DiscountingTypes {

    struct ContractRule {
        uint256 amount;
        uint256 discount;
    }
}


pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

interface DiscountingTypes {

    struct ContractRule {
        address partner;
        uint256 amount;
        uint256 discount;
    }

    struct Supplier {
        address supplierAddress;
        uint256 discountPercent;
        uint256 needAmount;
    }

    struct Auction {
        uint256 id;
        address buyer;
        uint256 minPercent;
        uint256 hasAmount;
        address signedContract;
    }

}


pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

interface DiscountingTypes {

    struct ContractRule {
        uint256 amount;
        uint256 discount;
    }

    struct Supplier {
        address supplierAddress;
        address needAmount;
    }

    struct AuctionOrder {
        uint256 id;
        address buyer;
        uint256 hasAmount;
        uint256 minPercent;
        Supplier[] suppliers;
        address signedContract;
    }

}


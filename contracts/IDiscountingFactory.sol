pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./DiscountingTypes.sol";

interface IDiscountingFactory is DiscountingTypes {

    function createAuctionOrder(uint256 _hasAmount, uint256 _minPercent) external returns(uint256);

    function respondAuctionOrder(uint256 _orderId) external returns(bool);

    function executeAuctionOrder(uint256 _orderId) external returns(address);

    function getOrderDetails(uint256 _orderId) external view returns(AuctionOrder memory);

    function getContractDetails(address _contractAddress) external view returns(ContractRule memory);

    //
    // no gas control methods
    //

    function getOrderDetailsList(uint256[] memory _orderIds) external view returns(AuctionOrder[] memory);

    function getContractDetailsList(address[] memory _contractAddresses) external view returns(ContractRule[] memory);

    function getOpenedOrders() external view returns(AuctionOrder[] memory);

}

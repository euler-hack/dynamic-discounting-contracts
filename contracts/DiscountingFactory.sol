// SPDX-License-Identifier: MIT

/**
 *                        oooo                             oooo                            oooo        
 *                        `888                             `888                            `888        
 *   .ooooo.  oooo  oooo   888   .ooooo.  oooo d8b          888 .oo.    .oooo.    .ooooo.   888  oooo  
 *  d88' `88b `888  `888   888  d88' `88b `888""8P          888P"Y88b  `P  )88b  d88' `"Y8  888 .8P'   
 *  888ooo888  888   888   888  888ooo888  888     8888888  888   888   .oP"888  888        888888.    
 *  888        888   888   888  888        888              888   888  d8(  888  888   .o8  888 `88b.  
 *  `Y8bod8P'  `V88V"V8P' o888o `Y8bod8P' d888b            o888o o888o `Y888""8o `Y8bod8P' o888o o888o                                                                                                
 *
 **/

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./DiscountingContract.sol";
import "./IDiscountingFactory.sol";


contract DiscountingFactory is IDiscountingFactory, Ownable {

    using SafeMath for uint256;

    //
    // Storage
    //

    DiscountingContract[] public contracts;
    AuctionOrder[] public auctionOrders;

    //
    // Events
    //

    event CreatedAuctionOrder(uint256 _id, address indexed _buyer, uint256 _hasAmount, uint256 _minPercent, uint256 _timestamp);
    event RespondAuctionOrder(uint256 _id, address indexed _responder, uint256 _timestamp);

    //
    // External methods
    //

    function createAuctionOrder(uint256 _hasAmount, uint256 _minPercent) external override returns(uint256) {
        require(_hasAmount != 0, "DiscountingFactory: wrong _hasAmount parameter");

        // uint256 newOrderId = auctionOrders.length;
        // AuctionOrder memory newAuctionOrder = AuctionOrder({
        //     id: newOrderId,
        //     buyer: msg.sender,
        //     hasAmount: _hasAmount,
        //     minPercent: _minPercent,
        //     suppliers: new Supplier[](0),
        //     signedContract: address(0)
        // });

        // auctionOrders.push(newAuctionOrder);

        // emit CreatedAuctionOrder(newOrderId, msg.sender, _hasAmount, _minPercent, block.timestamp);

        return 1;
    }

    function respondAuctionOrder(uint256 _orderId) external override returns(bool) {

        emit RespondAuctionOrder(_orderId, msg.sender, block.timestamp);

        return true;
    }

    function executeAuctionOrder(uint256 _orderId) external override returns(address) {
        return address(0);
    }

    function getOrderDetails(uint256 _orderId) external view override returns(AuctionOrder memory) {
        return(auctionOrders[_orderId]);
    }

    function getContractDetails(address _contractAddress) external view override returns(ContractRule memory) {
        return(ContractRule(123, 123));
    }

    //
    // no gas control methods
    //

    function getOrderDetailsList(uint256[] memory _orderIds) external view override returns(AuctionOrder[] memory) {
        AuctionOrder[] memory result = new AuctionOrder[](_orderIds.length);
        for (uint256 i = 0; i < _orderIds.length; i++) {
            result[i] = auctionOrders[_orderIds[i]];
        }
        return result;
    }

    function getContractDetailsList(address[] memory _contractAddresses) external view override returns(ContractRule[] memory) {
        return new ContractRule[](0);
    }

    function getOpenedOrders() external view override returns(AuctionOrder[] memory) {
        return new AuctionOrder[](0);
    }

}

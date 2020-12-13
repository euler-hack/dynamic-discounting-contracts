
// File: @openzeppelin/contracts/GSN/Context.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: contracts/discounting/DiscountingTypes.sol

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

interface DiscountingTypes {

    struct Supplier {
        address supplierAddress;
        uint256 needAmount;
        uint256 discountPercent;
    }

    struct Auction {
        uint256 id;
        address buyer;
        uint256 minPercent;
        uint256 hasAmount;
        address signedContract;
    }

}

// File: contracts/discounting/IDiscountingContract.sol

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;


interface IDiscountingContract is DiscountingTypes {

    function getSuppliers() external view returns(Supplier[] memory);

}

// File: contracts/discounting/DiscountingContract.sol

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;


contract DiscountingContract is IDiscountingContract {

    mapping(uint256 => Supplier) public Suppliers;
    uint256 public SuppliersLength = 0;
    bool public inited = false;

    function initContract(Supplier[] memory _rule) public {
        require(inited == false);
        for (uint256 i = 0; i < _rule.length; i++) {
            Suppliers[SuppliersLength] = _rule[i];
            SuppliersLength++;
        }
        inited = true;
    }

    function getSuppliers() external view override returns(Supplier[] memory) {
        Supplier[] memory result = new Supplier[](SuppliersLength);
        for (uint256 i = 0; i < result.length; i++) {
            result[i] = Suppliers[i];
        }
        return result;
    }

}

// File: contracts/discounting/IDiscountingFactory.sol

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;


interface IDiscountingFactory is DiscountingTypes {

    function createAuction(uint256 _hasAmount, uint256 _minPercent) external returns(uint256);

    function respondAuction(uint256 _id, uint256 _needAmount, uint256 _discountPercent) external returns(bool);

    function executeAuction(uint256 _id) external returns(address);

    function getAuctionDetails(uint256 _id) external view returns(Auction memory);

    function getContractDetails(address _contractAddress) external view returns(Supplier[] memory);

    //
    // no gas control methods
    //

    function getAuctionSuppliers(uint256 _id) external view returns(Supplier[] memory);

    function getOtherOpenAuctions() external view returns(uint256[] memory);

    function getMyOpenAuctions() external view returns(uint256[] memory);

    function getClosedAuctions() external view returns(uint256[] memory);

}

// File: contracts/discounting/DiscountingFactory.sol

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






contract DiscountingFactory is IDiscountingFactory, Ownable {

    using SafeMath for uint256;

    //
    // Storage
    //

    DiscountingContract[] private contracts;
    Auction[] private auctions;
    mapping(uint256 => Supplier[]) private auctionsSuppliers;

    //
    // Events
    //

    event CreatedAuction(uint256 indexed _id, address indexed _buyer, uint256 _hasAmount, uint256 _minPercent, uint256 _timestamp);
    event RespondAuction(uint256 indexed _id, address indexed _responder, uint256 _discountPercent , uint256 _needAmount, uint256 _timestamp);
    event ExecutedAuction(uint256 indexed _id, address indexed _buyer, address indexed _newContractAddress);

    //
    // External methods
    //

    function createAuction(uint256 _hasAmount, uint256 _minPercent) external override returns(uint256) {
        require(_hasAmount != 0, "DiscountingFactory: wrong _hasAmount parameter");

        uint256 newId = auctions.length;
        Auction memory newAuction = Auction({
            id: newId,
            buyer: msg.sender,
            minPercent: _minPercent,
            hasAmount: _hasAmount,
            signedContract: address(0)
        });

        auctions.push(newAuction);

        emit CreatedAuction(newId, msg.sender, _hasAmount, _minPercent, block.timestamp);

        return newId;
    }

    function respondAuction(uint256 _id, uint256 _needAmount, uint256 _discountPercent) external override returns(bool) {
        require(auctions.length > _id, "DiscounstructuretingFactory: wrong _id parameter");
        require(auctions[_id].buyer != msg.sender, "DiscountingFactory: wrong msg.sender");
        require(auctions[_id].minPercent <= _discountPercent, "DiscountingFactory: wrong _discountPercent parameter");
        require(auctions[_id].hasAmount >= _needAmount, "DiscountingFactory: wrong _needAmount parameter");
        require(auctions[_id].signedContract == address(0), "DiscountingFactory: auction is closed");

        auctionsSuppliers[_id].push(Supplier({
            supplierAddress: msg.sender,
            discountPercent: _discountPercent,
            needAmount: _needAmount
        }));

        emit RespondAuction(_id, msg.sender, _discountPercent, _needAmount, block.timestamp);

        return true;
    }

    function executeAuction(uint256 _id) external override returns(address) {
        require(auctions.length > _id, "DiscountingFactory: wrong _id parameter");
        require(auctions[_id].buyer == msg.sender, "DiscountingFactory: wrong msg.sender");

        // load suppliers from storage
        Supplier[] memory newSuppliers = new Supplier[](auctionsSuppliers[_id].length);
        for (uint256 i = 0; i < newSuppliers.length; i++) {
            newSuppliers[i] = auctionsSuppliers[_id][i];
        }

        // sort
        newSuppliers = sort(newSuppliers);

        // filling
        uint256 counter = 0;
        uint256 filled = 0;
        for (uint256 i = 0; i < newSuppliers.length; i++) {
            filled = filled + newSuppliers[i].needAmount;
            if (filled > auctions[_id].hasAmount) {
                break;
            }
            counter++;
        }
        Supplier[] memory resultSuppliers = new Supplier[](counter);
        for (uint256 i = 0; i < counter; i++) {
            resultSuppliers[i] = newSuppliers[i];
        }

        DiscountingContract resultContract = new DiscountingContract();
        resultContract.initContract(resultSuppliers);
        contracts.push(resultContract);

        auctions[_id].signedContract =  address(resultContract);

        emit ExecutedAuction(_id, msg.sender, address(resultContract));

        return address(resultContract);
    }

    function getAuctionDetails(uint256 _id) external view override returns(Auction memory) {
        return auctions[_id];
    }

    function getContractDetails(address _contractAddress) external view override returns(Supplier[] memory) {
        return DiscountingContract(_contractAddress).getSuppliers();
    }

    function getAuctionsCount() external view returns(uint) {
        return auctions.length;
    }


    //
    // no gas control methods
    //

    function getAuctionSuppliers(uint256 _id) external view override returns(Supplier[] memory) {
        Supplier[] memory result = new Supplier[](auctionsSuppliers[_id].length);
        for (uint256 i = 0; i < result.length; i++) {
            result[i] = auctionsSuppliers[_id][i];
        }
        return result;
    }

    function getOtherOpenAuctions() external view override returns(uint256[] memory) {
        uint256 counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].buyer != msg.sender && auctions[i].signedContract == address(0)) {
                counter++;
            }
        }
        
        uint256[] memory result = new uint256[](counter);
        counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].buyer != msg.sender && auctions[i].signedContract == address(0)) {
                result[counter] = auctions[i].id;
                counter++;
            }
        }
        return result;
    }

    function getMyOpenAuctions() external view override returns(uint256[] memory) {
        uint256 counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].buyer == msg.sender && auctions[i].signedContract == address(0)) {
                counter++;
            }
        }
        
        uint256[] memory result = new uint256[](counter);
        counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].buyer == msg.sender && auctions[i].signedContract == address(0)) {
                result[counter] = auctions[i].id;
                counter++;
            }
        }
        return result;
    }

    function getClosedAuctions() external view override returns(uint256[] memory) {
        uint256 counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].signedContract != address(0)) {
                counter++;
            }
        }
        
        uint256[] memory result = new uint256[](counter);
        counter = 0;
        for (uint256 i = 0; i < auctions.length; i++) {
            if (auctions[i].signedContract != address(0)) {
                result[counter] = auctions[i].id;
                counter++;
            }
        }
        return result;
    }

    function sort(Supplier[] memory data) public view returns(Supplier[] memory) {
       quickSort(data, int(0), int(data.length - 1));
       return data;
    }

    function quickSort(Supplier[] memory arr, int left, int right) internal view {
        int i = left;
        int j = right;
        if(i==j) return;
        uint pivot = arr[uint(left + (right - left) / 2)].discountPercent;
        while (i <= j) {
            while (arr[uint(i)].discountPercent > pivot) i++;
            while (pivot > arr[uint(j)].discountPercent) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }

    

}

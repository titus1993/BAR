pragma solidity ^0.4.25;

import 'Ownable.sol';

/**
 * @title Asset
 * @dev The Asset contract has an owner who can transfer the ownership of the asset
 * an Asset contract is tracked via an AssetSeries contract
 */
contract Asset is Ownable {

    /**
     * serialNumber
     * @var represents the position in the AssetSeries contract.
     * This value is set on the create method
     */
    uint256 public serialNumber;

    /**
     * passphrase
     * @var random generated string.
     * If the Asset contract has no owner. The user must
     */
    uint256 private passphrase;


    address public newOwner;

    event NewOwnerAsset(address newOwner, string comment);

    /**
     *
     */
    constructor (
        uint256 _passphrase,
        uint256 _serialNumber) public {

        serialNumber = _serialNumber;
        passphrase = _passphrase;
        
        newOwner = address(0);
    }


    function claimAssetOwnership(uint256 _passphrase, string _comment) public {
        if(owner == address(0)){
            require(_passphrase == passphrase);
            owner = msg.sender;
        }else{
            require(newOwner == msg.sender);
            owner = msg.sender;
            newOwner = address(0);
        }

        emit NewOwnerAsset(msg.sender, _comment);
    }


    function transferAssetOwnership(address _newOwner) public onlyOwner {
        owner = address(0);
        newOwner = _newOwner;
        emit OwnershipTransferred(msg.sender, _newOwner);
    }
}

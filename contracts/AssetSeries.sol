pragma solidity ^0.4.25;

import './Asset.sol';
import "./Ownable.sol";

/**
 * @title AssetSeries
 * @dev
 * an Asset contract is tracked via an AssetSeries contract
 */
contract AssetSeries is Ownable{

    /**
     * series
     * @var indicates the supply of the number of Asset contracts linked to this series
     * 0 means unlimited supply
     */
    uint256 public series;

    /**
     * currentAssetNumber
     * @var
     *
     */
    uint256 public currentAssetNumber;

    /**
     * assets
     * @var Asset contracts to be linked.
     */
    mapping (uint256 => Asset) public assets;



    event CreatedAsset(uint256 series, address asset);
    /**
     *
     */
    constructor(uint256 _series) public {
        series = _series;
        currentAssetNumber = 0;
        owner = msg.sender;
    }


    function createAsset(uint256 passphrase) public onlyOwner returns (Asset asset) {

        currentAssetNumber = currentAssetNumber + 1;
        require(currentAssetNumber <= series);

        asset = new Asset(passphrase, currentAssetNumber);

        assets[currentAssetNumber] = asset;

        emit CreatedAsset(currentAssetNumber, asset);
    }
}

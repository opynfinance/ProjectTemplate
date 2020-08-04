/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity =0.6.10;
import "eip1167-spawner/contracts/Spawner.sol";

/**
 * @author Opyn Team
 * @title OpynSwapFactory
 * @notice contract that deploys new OpynSwap contracts
 */
 
/// @notice mapping of oToken address => OpynSwap address
mapping(address => address) public exchange;

/// @notice OpynSwap template address used for creation of new OpynSwap contracts
address public opynSwap

contract OpynSwapFactory is Spawner{
     /**
     * @notice deploys a new OpynSwap contract for trading of opyn options on a Balancer pool and initializes the pool 
     * @dev deploy an eip-1167 minimal proxy with CREATE and initalizes it
     * @param quoteCurrency addresses of quote currency in the pool, which is the asset which oTokens are quoted against
     * @param oToken addresses of oTokens in the pool
     * @param quoteCurrencyBalance initial balance of quote currency in pool
     * @param oTokenBalance initial balance of each oToken in pool
     * @param quoteCurrencyDenorm initial denormalized weight for quote currency
     * @param oTokenDenorm initial denormalized weight for each oToken
     */
    constructor(address _opynSwap) public {
        require(_opynSwap != address(0), "Invalid OpynSwap address");

        opynSwap = _opynSwap;
    }

    function createOpynSwap(
        address quoteCurrency, 
        address[] oToken, 
        uint256 quoteCurrencyBalance
        uint256[] oTokenBalance
        uint256 quoteCurrencyDenorm, 
        uint256[] oTokenDenorm
        ) external {
        
        address newAddress;
        bytes memory initData=abi.encodeWithSelector(
            OpynSwap.init.selector, 
            quoteCurrency, 
            oToken, 
            quoteCurrencyBalance, 
            oTokenBalance, 
            quoteCurrencyDenorm, 
            oTokenDenorm
        );

        address memory newAddress = Spawner._spawnOldSchool(OpynSwap, initData);
        
        for(uint i=0, i<oToken.length,i++){
            exchange[oToken[i]=newAddress;
        }

    }  
}
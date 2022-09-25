// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/solmate/src/tokens/ERC20.sol";
import "lib/solmate/src/auth/Owned.sol";
import "forge-std/console.sol";

contract TokenToBurn is ERC20, Owned {

    constructor () ERC20 (
        "TokenToBurn",
        "TB",
        18
    ) Owned(msg.sender) {}

    function transfer(address to, uint256 amount) public override returns(bool) {
        uint256 amountToBurn = amount * 5 / 100 ;
       
        if (super.transfer(to, amount - amountToBurn)) {
            _burn(msg.sender, amountToBurn);
            return true;
        } else return false;
    }  

    function transferFrom(address from, address to, uint256 amount) public  override onlyOwner returns(bool) {
        uint256 amountToBurn = amount * 5 / 100 ;
        allowance[from][msg.sender] = amount;
        
        if (super.transferFrom(from, to, amount - amountToBurn)) {
            _burn(from, amountToBurn);
            return true;            
        } else return false;
    }  
    
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenToBurn.sol";
import "forge-std/console.sol";


contract TokenToBurnTest is Test {
    TokenToBurn public coin;

    function setUp() public {
       coin = new TokenToBurn();
    }

    function testBurnTransfer() public {
        address user1 = address(0x1);
        address user2 = address(0x2);
        
        coin.mint(user1, 1000);  

        assertEq(coin.totalSupply(), 1000);
        
        vm.prank(user1);
        coin.transfer(user2, 100 );
        assertEq(coin.totalSupply(), 995 );
    }

    function testBurnTransferFrom() public {
        address user1 = address(0x1);
        address user2 = address(0x2);

        coin.mint(user1, 1000);
        assertEq(coin.totalSupply(), 1000);

        coin.transferFrom(user1, user2, 100);
        assertEq(coin.totalSupply(), 995);
    }    
}

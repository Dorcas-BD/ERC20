//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract dorcasToken is ERC20("Dorcas Token", "DRT") {
    uint256 public constant EXCHANGE_RATE = 1 ether;

    //Buy(mint) DRT token in excane for ETH
    function buy() public payable {
        //Retrieve  the amount of ETH deposited
        uint256 amountETH = msg.value;

        //calculate the amount of DRT token to mint
        uint256 amountDRT = amountETH / EXCHANGE_RATE;

        //Mint DRT token to the caller address
        address sender = msg.sender;
        _mint(sender, amountDRT);
    }

    //Redeem (burn) DRT token and gget ETH back
    function redeem(uint256 _DRTToRedeem) public {
        //Check that the user has enough DRT token balance
        require(balanceOf(msg.sender) >= _DRTToRedeem, "Insufficient Balance");
        //calculate the amount of ETH to get back from burning DRT token
        uint256 amountETH = _DRTToRedeem * EXCHANGE_RATE;

        require(address(this).balance >= amountETH, "Insufficient ETH");
        //Burn the DRT token
        _burn(msg.sender, _DRTToRedeem);

        //Transfer ETH to the user
        payable(msg.sender).transfer(amountETH);
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }
}

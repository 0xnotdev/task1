// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DepositWithdrawal {
    
    mapping (address => uint256) public deposits;
    
    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "You have no deposit to withdraw");
        delete deposits[msg.sender];
        payable(msg.sender).transfer(amount);
    }
    
    function withdrawAll(address payable recipient) public {
        uint256 amount = deposits[msg.sender];
        uint256 totalDeposits = 0;
        address[] memory depositors = new address[](2);
        for (uint256 i = 0; i < depositors.length; i++) {
            if (deposits[depositors[i]] > 0) {
                totalDeposits += deposits[depositors[i]];
            }
        }
        require(amount == totalDeposits, "You can only withdraw your deposits");
        delete deposits[msg.sender];
        recipient.transfer(amount);
    }
    
}
//SPDX-License-Identifier: Unlicense
pragma solidity 0.6.12;

import "hardhat/console.sol";


contract Storage {

    uint totalContractBalance = 0;

    mapping(address => uint) public balance;

    uint constant public threshold = 0.003 * 10**18;

    uint public deadline = block.timestamp + 1;

    function isActive() public view returns(bool){
        return block.timestamp = threshold;
    }

    function getContractBalance() public view returns(uint){
        return totalContractBalance;
    }

    function deposit() public payable {  
        balance[msg.sender] += msg.value;
        totalContractBalance += msg.value;
    }


    receive() external payable { deposit(); }

    function withdraw() public {
        require(block.timestamp > deadline, "deadline hasn't passed yet");
        require(!isActive(), "Contract is active");
        require(balance[msg.sender]> 0, "You havent deposited yet")

        uint amount = balance[msg.sender];
        balance[msg.sender] = 0;
        totalContractBalance -= amount;
        payable(msg.sender).transfer(amount);
    }
}

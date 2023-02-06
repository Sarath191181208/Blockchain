pragma solidity 0.8.7;

contract Bank{
    mapping(address => uint) account_balance;

    function deposit() external payable{
        account_balance[msg.sender] += msg.value;
    }

    function transfer(address receiver, uint amount) public payable{
        uint balance = account_balance[msg.sender];
        require(balance >= amount, "Insufficent funds!");
        (bool sent, bytes memory data) = receiver.call{value: amount}("");
        require(sent, "Error sending the funds! Try again later.");
        account_balance[msg.sender] = balance-amount;
    }

    function viewBalance() public view returns(uint){
        return account_balance[msg.sender];
    }
}
pragma solidity ^0.4.0;
contract Agent {
    
    address to; // адресат 
    address owner; // владелец
    address store; // адрес Store
    
    function Agent() public {
        owner = msg.sender; // запоминаем создателя контракти
    }
    
    function setAddress(address a) public { // указываем адрес получателя
        if (owner == msg.sender) {
           to = a;
        }
    } 
    
    function setStoreAddress(address a) public { // указываем адрес Store
        if (owner == msg.sender) {
           store = a;
        }
    }
    
    function sendToStore() payable public {
        Storage(store).store.value(this.balance)(); // отправляем средства на Store
    }
    
    function GetCoinBack() payable public { // получаем средства со Store
        if (msg.sender == owner || msg.sender == to){
            Storage(store).sendCoin.value(this.balance)();
            msg.sender.transfer(this.balance); // и отправляем их на аккаунт
        }
    }
    
    function getBack() payable public { // принимает средства со Store
        
    }
    
}

contract Storage  {
    
    
    function Storage() payable public{
        
    }
    function store() payable public { // принимает средства
    }
    
    function getBalance() public view returns (uint256) { // показывает баланс
        return this.balance;
    } 
    
    function sendCoin() payable public { // отправляет средсва на Agent
        Agent(msg.sender).getBack.value(this.balance)();
    }
}

pragma solidity ^0.4.0;
contract Agent {
    
    address to; // адресат 
    address owner; // владелец
    address store; // адрес Store
    
    function Agent() public {
        owner = msg.sender; // запоминаем создателя контракта
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
    address owner;
    uint a = 0; // переменная счетчик, запоминает контракт-вкладчик
    
    function Storage() payable public{
        
    }
    function store() payable public { // принимает средства
        if (a == 0) owner = msg.sender; // если а = 0 то запомним адрес контракта
        a++; // если кто то другой положит сюда деньги мы не запомним его адрес
    }
    
    function getBalance() public view returns (uint256) { // показывает баланс
        return this.balance;
    } 
    
    function sendCoin() payable public { // отправляет средсва на Agent
        require(owner == msg.sender);
        Agent(msg.sender).getBack.value(this.balance)();
        a = 0; // все деньги вывели, "стираем память", готовы запомнить нового 
               // вкладчика Agent
    }
}

pragma ton-solidity >= 0.44.0;
pragma AbiHeader expire;

contract Random {

    uint128 balance;
    uint8 betValue = 1;

    constructor() public onlyOwnerAccept {
        balance = 1000;//for testing purpose, delete in prod or set 0
    }

    modifier onlyOwnerAccept {
        require(tvm.pubkey() != 0 && tvm.pubkey() == msg.pubkey());
        tvm.accept();
        _;
    }

    function getrandom() public returns(uint8, uint8, uint8, uint128, uint8){
       tvm.accept();//0.007377001 - плата за одну рандомную генерацию
       rnd.shuffle(now);
       (uint8 first, uint8 second, uint8 third) = (rnd.next(7)+1, rnd.next(7)+1, rnd.next(7)+1);
       calculateBalance(first, second, third);
       return (first, second, third, balance, betValue);
    }

    function calculateBalance (uint8 first, uint8 second, uint8 third) public{        
        balance = balance - betValue;
        if(first == second && second == third){
            balance = balance + betValue * 6;
        }        
    }

}

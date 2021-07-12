pragma ton-solidity >= 0.44.0;
pragma AbiHeader expire;

contract Random {

    constructor() public onlyOwnerAccept {
    }

    modifier onlyOwnerAccept {
        require(tvm.pubkey() != 0 && tvm.pubkey() == msg.pubkey());
        tvm.accept();
        _;
    }

    function getrandom() public pure returns(uint8, uint8, uint8){
       tvm.accept();//0.007377001 - плата за одну рандомную генерацию
       rnd.shuffle(now);
       return (rnd.next(7)+1, rnd.next(7)+1, rnd.next(7)+1);
    }

}

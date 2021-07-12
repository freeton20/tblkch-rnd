#!/bin/bash
LOCALNET=http://127.0.0.1
DEVNET=https://net1.ton.dev
MAINNET=https://main.ton.dev
FLDNET=https://gql.custler.net
NETWORK=$FLDNET

CONTRACT_NAME=Random

giver=0:2bb4a0e8391e7ea8877f4825064924bd41ce110fce97e939d3323999e1efbb13

function giver {
if [[ $NETWORK == $DEVNET ]]    
then
tonos-cli --url $NETWORK  call 0:abd034be554c9329e4eb7c77679d798f760c98fdb776da3693a0a3621bbe6a86 sendTransaction "{\"dest\":\"$1\",\"value\":\"1000000000\",\"bounce\":false,\"flags\":3, \"payload\":\"\"}" --abi ./SafeMultisigWallet.abi.json --sign "alone length uncover main couple mushroom script siege spy dutch onion decrease"
fi 

if [[ $NETWORK == $LOCALNET ]]  
then  
tonos-cli --url $NETWORK call --abi ./local_giver.abi.json 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams "{\"dest\":\"$1\",\"amount\":1000000000000}"
fi 

if [[ $NETWORK == $FLDNET ]]  
then  
tonos-cli --url $NETWORK call 0:deda155da7c518f57cb664be70b9042ed54a92542769735dfb73d3eef85acdaf grant "{\"addr\":\"$1\"}" --abi Marvin.abi.json
fi 
}

function get_address {
echo $(cat log.log | grep "Raw address:" | cut -d ' ' -f 3)
}
function genaddr {
tonos-cli genaddr $1.tvc $1.abi.json --genkey $1.keys.json > log.log
}



echo GENADDR CONTRACT
genaddr $CONTRACT_NAME
CONTRACT_ADDRESS=$(get_address)

echo ASK GIVER
giver $CONTRACT_ADDRESS
tonos-cli --url $NETWORK deploy $CONTRACT_NAME.tvc "{}" --sign $CONTRACT_NAME.keys.json --abi $CONTRACT_NAME.abi.json

echo DONE
echo $CONTRACT_ADDRESS > address.log
echo CONTRACT $CONTRACT_ADDRESS

tonos-cli --url $NETWORK account $CONTRACT_ADDRESS
tonos-cli --url $NETWORK call $CONTRACT_ADDRESS getrandom "{}" --abi $CONTRACT_NAME.abi.json
tonos-cli --url $NETWORK account $CONTRACT_ADDRESS


# 0.007377001 - плата за одну рандомную генерацию
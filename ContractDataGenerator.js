const fs = require("fs");
const { resolve } = require("path");
const path = require("path");

const keys = JSON.parse(fs.readFileSync(path.resolve(__dirname, "src/contracts/Random.keys.json").toString()));
const abi = JSON.parse(fs.readFileSync(path.resolve(__dirname, "src/contracts/Random.abi.json").toString()));
const tvc = fs.readFileSync(path.resolve(__dirname, "src/contracts/Random.tvc")).toString("base64");
const AccountContract = {
    keys,
    abi,
    tvc, 
}
fs.writeFileSync(path.resolve(__dirname, "src/contracts/ContractData.json"), JSON.stringify(AccountContract, null, '\t'));



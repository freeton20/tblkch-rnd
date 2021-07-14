const { TonClient,signerKeys } = require("@tonclient/core");
const { libWeb } = require("@tonclient/lib-web");
const { Account } = require("@tonclient/appkit");
const contractData = require("./contracts/ContractData.json");

TonClient.useBinaryLibrary(libWeb);
const client = new TonClient({
    network: {
      //  endpoints: ["https://gql.custler.net"]
        endpoints: ["http://localhost"]
    }
});

const account = new Account(contractData,{signer: signerKeys(contractData.keys), client});

const random = async () => {
    try {
        const response = await account.run("getrandom", {});
        console.log(response);
        return {
            endNums: response.decoded.output,
            fees: response.fees.total_account_fees,
            balance: response.decoded.output.value3,
            betValue: response.decoded.output.value4,
        }
    } catch (err) {
        document.querySelector("#log").innerHTML = 'Network error';
    }
    client.close();
};

module.exports = {
    random
}

const Web3 = require('web3');

// Конфигурация
const NODE_URL = 'http://130.193.58.123:8545';
const CONTRACT_ADDRESS = '0xa57D758cd022f9C59f3A969382A15E4Fa962D454'
const ABI = [
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "_buyer",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_hasAmount",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_minPercent",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_timestamp",
          "type": "uint256"
        }
      ],
      "name": "CreatedAuction",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "_buyer",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "_newContractAddress",
          "type": "address"
        }
      ],
      "name": "ExecutedAuction",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "_responder",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_discountPercent",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_needAmount",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_timestamp",
          "type": "uint256"
        }
      ],
      "name": "RespondAuction",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "renounceOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "transferOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_hasAmount",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_minPercent",
          "type": "uint256"
        }
      ],
      "name": "createAuction",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_needAmount",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_discountPercent",
          "type": "uint256"
        }
      ],
      "name": "respondAuction",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        }
      ],
      "name": "executeAuction",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        }
      ],
      "name": "getAuctionDetails",
      "outputs": [
        {
          "components": [
            {
              "internalType": "uint256",
              "name": "id",
              "type": "uint256"
            },
            {
              "internalType": "address",
              "name": "buyer",
              "type": "address"
            },
            {
              "internalType": "uint256",
              "name": "minPercent",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "hasAmount",
              "type": "uint256"
            },
            {
              "internalType": "address",
              "name": "signedContract",
              "type": "address"
            }
          ],
          "internalType": "struct DiscountingTypes.Auction",
          "name": "",
          "type": "tuple"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_contractAddress",
          "type": "address"
        }
      ],
      "name": "getContractDetails",
      "outputs": [
        {
          "components": [
            {
              "internalType": "address",
              "name": "supplierAddress",
              "type": "address"
            },
            {
              "internalType": "uint256",
              "name": "needAmount",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "discountPercent",
              "type": "uint256"
            }
          ],
          "internalType": "struct DiscountingTypes.Supplier[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getAuctionsCount",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_id",
          "type": "uint256"
        }
      ],
      "name": "getAuctionSuppliers",
      "outputs": [
        {
          "components": [
            {
              "internalType": "address",
              "name": "supplierAddress",
              "type": "address"
            },
            {
              "internalType": "uint256",
              "name": "needAmount",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "discountPercent",
              "type": "uint256"
            }
          ],
          "internalType": "struct DiscountingTypes.Supplier[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getOtherOpenAuctions",
      "outputs": [
        {
          "internalType": "uint256[]",
          "name": "",
          "type": "uint256[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getMyOpenAuctions",
      "outputs": [
        {
          "internalType": "uint256[]",
          "name": "",
          "type": "uint256[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getClosedAuctions",
      "outputs": [
        {
          "internalType": "uint256[]",
          "name": "",
          "type": "uint256[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "components": [
            {
              "internalType": "address",
              "name": "supplierAddress",
              "type": "address"
            },
            {
              "internalType": "uint256",
              "name": "needAmount",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "discountPercent",
              "type": "uint256"
            }
          ],
          "internalType": "struct DiscountingTypes.Supplier[]",
          "name": "data",
          "type": "tuple[]"
        }
      ],
      "name": "sort",
      "outputs": [
        {
          "components": [
            {
              "internalType": "address",
              "name": "supplierAddress",
              "type": "address"
            },
            {
              "internalType": "uint256",
              "name": "needAmount",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "discountPercent",
              "type": "uint256"
            }
          ],
          "internalType": "struct DiscountingTypes.Supplier[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ];

// Сущности web3 и смарт-контракта
const web3 = new Web3(new Web3.providers.HttpProvider(NODE_URL));
const contract = new web3.eth.Contract(ABI, CONTRACT_ADDRESS);


//
// Методы (которые мы вызываем, обращаясь к контракту)
//

contract.methods.getOtherOpenAuctions().call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getOtherOpenAuctions');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})

contract.methods.getMyOpenAuctions().call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getMyOpenAuctions');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})

contract.methods.getClosedAuctions().call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getClosedAuctions');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})

contract.methods.getAuctionDetails(0).call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getAuctionDetails');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})

contract.methods.getAuctionSuppliers(0).call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getAuctionDetails');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})

contract.methods.getContractDetails('0x65Fa9Fc03B18977761b4e27b3C460c2D521335d6').call({from: '0x1B47ee2f9ad071B2754f329373711e32A9C6b04e'})
.then((result) => {
    console.log('\n getAuctionDetails');
    console.log(result);
})
.catch((error) => {
    console.log(error);
})
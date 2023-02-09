
const { Network, Alchemy } = require("alchemy-sdk");

const settings = {
  apiKey: "xhwjWIApFmUGK9mecq8ZYxe9oMx4V5og",
  network: Network.ETH_MAINNET,
};

const alchemy = new Alchemy(settings);

async function main() {
  const latestBlock = await alchemy.core.getBlockNumber();
  console.log("The latest block number is", latestBlock);
}

main();

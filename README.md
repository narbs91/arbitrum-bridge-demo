## Arbitrum Bridge Demo

This is a demo repo showing how to create an ERC20 token on Ethereum Sepolia and then demonstrating how to bridge the token to Arbitrum Sepolia using their native bridge

The Dev Token contract is deployed on Sepolia Testnet with the following contract address: [0xaF8b39973fE275aB4485dC53f1B2d890b65A5a39](https://sepolia.etherscan.io/address/0xaF8b39973fE275aB4485dC53f1B2d890b65A5a39)

The Dev Token was bridged to Arbitrum Sepolia using [their native bridge](https://bridge.arbitrum.io/?destinationChain=arbitrum-sepolia&sourceChain=sepolia) and has the following contract address: [0x2220ba944b39b4618c67341b6f136ec49014bdd8](https://sepolia.arbiscan.io/address/0x2220ba944b39b4618c67341b6f136ec49014bdd8)

## Dependencies

To deploy this contract on testnet you will need to populate your own `.env` file or bash profile following the [sample.env file](/sample.env) as a guide.

NOTE: IF YOU FORK THIS REPO AND/OR DEVELOP YOUR OWN FOUNDRY PROJECT DO NOT COMMIT YOUR PRiVATE KEY OR YOUR ETHERSCAN API KEY

You will also need an RPC url to deploy the contract; however, you may utilize the url provided in the `Deploy` section below which is a free public rpc url on sepolia testnet. Alternatively you can visit [chainlist](https://chainlist.org/) to find other rpc urls that suite your needs.

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy Dev Token
We will first deploy the contract to Ethereum Sepolia and then use the Arbitrum Bridge to seemlessly create its L2 counterpart

**Sepolia (without verification):**

```shell
forge script script/DevToken.s.sol:DeployDevToken --rpc-url https://1rpc.io/sepolia --private-key $WEB3_PK --broadcast
```

**Sepolia with verification (note: have the ETHERSCAN_API_KEY set in your environment variables):**

```shell
forge script script/DevToken.s.sol:DeployDevToken --rpc-url https://1rpc.io/sepolia --private-key $WEB3_PK --broadcast --etherscan-api-key $ETHERSCAN_API_KEY --verify -vvvv
```

Make note of the resulting contract address

**Bridging the token to Arbitrum**
To bridge the token to Arbitrum, we will be using the Arbitrum Bridge. You will need to have some Sepolia ETH in your wallet to pay for the bridge fee.

1. Head over to https://bridge.arbitrum.io/?destinationChain=arbitrum-sepolia&sourceChain=sepolia
2. Connect your wallet (make sure you on the Arbitrum Sepolia network)
3. Click the drop down corresponding to the token that will be bridged
4. Paste in the address of the Dev Token that you deployed onto Ethereum Sepolia
5. Select the Dev Token
6. Pick an amount to bridge over
7. Click `Bridge to Arbitrum`
8. Click accept on the resulting model and click the button to sign the transaction
9. Wait for the transaction to be confirmed (This step should take about 10 minutes)
10. Once the transaction no longer shows up in the active transaction section, click on the settle transactions tab
11. Click on the details of the transcation you see and click on the arbiscan link
12. Look at the transaction and find the proxy contract address it created, this will be the proxy l2 token address that the Arbitrum Token Bridge will have deployed for us

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

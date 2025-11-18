# evm-kit

## Usage

```sh
# Deploy WETH9 contract from bytecode
PRIVATE_KEY=0xabc123... \
forge script ./script/DeployWETH9FromBytecode.s.sol \
    --rpc-url https://your-rpc.io/ \
    --broadcast

# Deploy mock ERC20 token contract
PRIVATE_KEY=0xabc123... \
TOKEN_NAME=MockToken \
TOKEN_SYMBOL=MTK \
INITIAL_SUPPLY=1000000 \
forge script ./script/DeployMockToken.s.sol \
    --rpc-url https://your-rpc.io/ \
    --broadcast

forge verify-contract \
    --chain 167013 \
    --verifier custom \
    --verifier-url "https://api.etherscan.io/v2/api?chainid=167013&apikey=..." \
    0xTokenAddress \
    src/MockToken.sol:MockToken

# Deloy mock NFT contract
PRIVATE_KEY=0xabc123... \
NFT_NAME=MockNFT \
NFT_SYMBOL=MNFT \
forge script script/DeployMockNFT.s.sol:DeployMockNFT \
    --rpc-url https://your-rpc.io/ \
    --broadcast
```

## Example commands

```sh
cast send 0x18d5bB147f3D05D5f6c5E60Caf1daeeDBF5155B6 'mint(address,uint256)' <TO_ADDRESS> <AMOUNT_IN_DECIMALSS> --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>

cast send 0xA33e764b0248658c693Cc9502881648C80a4259c "mint(address)" <RECIPIENT_ADDRESS> \
    --rpc-url <RPC_URL> \
    --private-key <PRIVATE_KEY>

cast call 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "balanceOf(address)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 | cast to-dec

cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "deposit()" --value 1000000000000000000 --private-key <PRIVATE_KEY>

cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "balanceOf(address)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 | cast to-dec
```

# AuroraEngine Exit Contract

## Introduction

This repository contains a short term solution for exiting from the AuroraEngine along with performing
`ft_transfer_call` to the destination account.

## Usage

Example of depositing funds to app.near-intents.org:

```bash
cast send 0x9FC9944177cd85E7089155a85b4caEbb23c4b6fb \
  "ftTransferCall(address,string,uint128,string,string)" \
  "0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79" \ 
  "aaaaaa20d9e0e2461697782ef11675f668207961.factory.bridge.near" \
  "1" "intents.near" "foo.near" \
  --legacy --rpc-url aurora
  --private-key $PRIVATE_KEY
```

Arguments explanation:
- `0x8BEc47865aDe3B172A928df8f990Bc7f2A3b9f79` - ERC-20 token contract address
- `aaaaaa20d9e0e2461697782ef11675f668207961.factory.bridge.near` - NEP-141 bridged version of the token
- `1`  - amount of tokens to transfer, which will be passed to the `ft_transfer_call` method as `amount`
- `intents.near` - destination account, which will be passed to the `ft_transfer_call` method as `receiver_id`
- `foo.near` - message, which will be passed to the `ft_transfer_call` method as `msg`

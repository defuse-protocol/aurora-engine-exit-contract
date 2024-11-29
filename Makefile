-include .env

.PHONY: all clean

COMMON_DEPLOYMENT_FLAGS := --rpc-url aurora --private-key $(PRIVATE_KEY) --broadcast -vvvvv

build:; forge build

clean:; forge clean

# Deployments
deploy:; forge script script/Deploy.s.sol $(COMMON_DEPLOYMENT_FLAGS) --gas-price 1 --legacy --batch-size 1
upgrade:; forge script script/Upgrade.s.sol $(COMMON_DEPLOYMENT_FLAGS) --gas-price 1 --legacy --batch-size 1
approve-wnear:; forge script script/ApproveWNEAR.s.sol $(COMMON_DEPLOYMENT_FLAGS) --gas-price 1 --legacy --batch-size 1

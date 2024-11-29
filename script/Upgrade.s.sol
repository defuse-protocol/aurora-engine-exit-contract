// SPDX-License-Identifier: CC-BY-1.0
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import {ExitFtTransferCall} from "../src/ExitFtTransferCall.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

// Address of wNEAR ERC20 on mainnet
address constant wNEAR_MAINNET = 0xC42C30aC6Cc15faC9bD938618BcaA1a1FaE8501d;

contract Upgrade is Script {
    function run() external {
        address proxyAdminAddress = 0x41B187637B72322a243b45C3C32fC4f1D7e1C685;
        address proxyAddress = 0x9FC9944177cd85E7089155a85b4caEbb23c4b6fb;

        IERC20 wNEAR = IERC20(wNEAR_MAINNET);

        ProxyAdmin proxyAdmin = ProxyAdmin(proxyAdminAddress);

        vm.startBroadcast();

        // Deploy new implementation
        ExitFtTransferCall logic = new ExitFtTransferCall();

        // Upgrade the proxy
        proxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(payable(proxyAddress)),
            address(logic),
            abi.encodeWithSelector(logic.initialize.selector, wNEAR)
        );

        vm.stopBroadcast();
    }
}
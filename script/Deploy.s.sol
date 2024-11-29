// Deploy impl and proxy
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Script.sol';
import {ExitProxy} from '../src/ExitProxy.sol';
import {ExitFtTransferCall} from "../src/ExitFtTransferCall.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

// Address of wNEAR ERC20 on mainnet
address constant wNEAR_MAINNET = 0xC42C30aC6Cc15faC9bD938618BcaA1a1FaE8501d;

contract Deploy is Script {
    function run() external returns (address, address, address) {
        IERC20 wNEAR = IERC20(wNEAR_MAINNET);

        vm.startBroadcast();

        // Deploy the logic contract
        ExitFtTransferCall logic = new ExitFtTransferCall();

        ProxyAdmin proxyAdmin = new ProxyAdmin();

        // Deploy the proxy and link it to the logic contract
        Proxy proxy = new ExitProxy(
            address(logic),
            address(proxyAdmin),
            abi.encodeWithSelector(logic.initialize.selector, wNEAR)
        );

        vm.stopBroadcast();

        return (address(proxy), address(proxyAdmin), address(logic));
    }
}
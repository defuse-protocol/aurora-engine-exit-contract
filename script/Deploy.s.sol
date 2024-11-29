// Deploy impl and proxy
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Script.sol';
import {ExitProxy} from '../src/ExitProxy.sol';
import {ExitFtTransferCall} from "../src/ExitFtTransferCall.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract Deploy is Script {
    function run() external returns (address, address, address) {
        address deployer = msg.sender;
        string memory nearAccountId = "intents.near"; // Defuse intent account on Near
        IERC20 wNEAR = IERC20(0xC42C30aC6Cc15faC9bD938618BcaA1a1FaE8501d);

        vm.startBroadcast();

        // Deploy the logic contract
        ExitFtTransferCall logic = new ExitFtTransferCall();

        ProxyAdmin proxyAdmin = new ProxyAdmin();

        // Deploy the proxy and link it to the logic contract
        Proxy proxy = new ExitProxy(
            address(logic),
            address(proxyAdmin),
            abi.encodeWithSelector(logic.initialize.selector, nearAccountId, wNEAR)
        );

        vm.stopBroadcast();

        return (address(proxy), address(proxyAdmin), address(logic));
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol';
import '@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol';

contract ExitProxy is TransparentUpgradeableProxy {
    constructor(
        address _logic,
        address _owner,
        bytes memory _data
    ) TransparentUpgradeableProxy(_logic, _owner, _data) {}
}

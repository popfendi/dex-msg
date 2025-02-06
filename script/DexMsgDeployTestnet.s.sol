// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {Hooks} from "v4-core/src/libraries/Hooks.sol";
import {IPoolManager} from "v4-core/src/interfaces/IPoolManager.sol";
import {Constants} from "./base/Constants.sol";
import {DexMsg} from "../src/DexMsg.sol";
import {HookMiner} from "../test/utils/HookMiner.sol";

/// @notice Mines the address and deploys the Counter.sol Hook contract
contract DexMsgScript is Script, Constants {
    function setUp() public {}

    function run() public {
        // hook contracts must have specific flags encoded in the address
        uint160 flags = uint160(
            Hooks.AFTER_SWAP_FLAG 
        );

        // Mine a salt that will produce a hook address with the correct flags
        bytes memory constructorArgs = abi.encode(POOLMANAGER_TESTNET);
        (address hookAddress, bytes32 salt) =
            HookMiner.find(CREATE2_DEPLOYER, flags, type(DexMsg).creationCode, constructorArgs);

        // Deploy the hook using CREATE2
        vm.broadcast();
        DexMsg dexMsg = new DexMsg{salt: salt}(IPoolManager(POOLMANAGER_TESTNET));
        require(address(dexMsg) == hookAddress, "DexMsg: hook address mismatch");
        console.log("dexmsg deployed to: ", address(dexMsg));
    }
}

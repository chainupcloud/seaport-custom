// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Script.sol";

import {Seaport} from "contracts/Seaport.sol";
import {ConduitController} from "contracts/conduit/ConduitController.sol";

// forge script script/CustomSeaportDeployer.s.sol:SeaportAllDeployer --rpc-url https://api.chainup.net/ethereum/holesky/$ --broadcast --retries 10 --delay 30
// forge verify-contract 0x12246eb75caF4D4FBFcE48741abC5EeDCB1c1B76 Seaport --chain 17000 --constructor-args $(cast abi-encode "constructor(address)" 0x93a6860F2F089cb88B9c9355CD4A6E269B7FDc93) --etherscan-api-key $ --watch
// forge verify-contract 0x93a6860F2F089cb88B9c9355CD4A6E269B7FDc93 ConduitController --chain 17000 --etherscan-api-key $ --watch
// NOTE: This script assumes that the CREATE2-related contracts have already been deployed.
// verify 会有问题
contract SeaportAllDeployer is Script {
    ConduitController private conduitController;
    Seaport private seaport;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        conduitController = new ConduitController();
        address conduitControllerAddress = address(conduitController);
        seaport = new Seaport(conduitControllerAddress);
        address seaportAddress = address(seaport);

        console.log("conduitControllerAddress:", conduitControllerAddress);
        console.log("seaportAddress:", seaportAddress);

        vm.stopBroadcast();
    }
}

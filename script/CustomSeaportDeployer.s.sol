// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Script.sol";

import { Seaport } from "contracts/Seaport.sol";
import { ConduitController } from
    "seaport-core/src/conduit/ConduitController.sol";

// forge script script/CustomSeaportDeployer.s.sol:SeaportAllDeployer --rpc-url https://api.chainup.net/ethereum/holesky/$ --broadcast --retries 10 --delay 30
// forge verify-contract 0x2D206f3f2d0c97586dcf40c5095BEEe33B34D347 Seaport --chain 17000 --constructor-args $(cast abi-encode "constructor(address)" 0x3c8116B4ac0db545e184e2dc9CBB2Eb67a4dEd3F) --etherscan-api-key $ --watch
// forge verify-contract 0x3c8116B4ac0db545e184e2dc9CBB2Eb67a4dEd3F ConduitController --chain 17000 --etherscan-api-key $ --watch
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

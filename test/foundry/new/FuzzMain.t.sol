// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { FuzzEngine } from "./helpers/FuzzEngine.sol";

import { FuzzParams } from "./helpers/FuzzTestContextLib.sol";

contract FuzzMainTest is FuzzEngine {
    /**
     * @dev FuzzEngine test for valid orders. Generates a random valid order
     *      configuration, selects and calls a Seaport method, and runs all
     *      registered checks. This test should never revert.  For more details
     *      on the lifecycle of this test, see FuzzEngine.sol.
     */
    function test_fuzz_validOrders(
        uint256 seed,
        uint256 orders,
        uint256 maxOfferItemsPerOrder,
        uint256 maxConsiderationItemsPerOrder
    ) public {
        run(
            FuzzParams({
                seed: seed,
                totalOrders: bound(orders, 1, 10),
                maxOfferItems: bound(maxOfferItemsPerOrder, 0, 10),
                maxConsiderationItems: bound(
                    maxConsiderationItemsPerOrder,
                    0,
                    10
                )
            })
        );
    }

    function xtest_concrete() public {
        uint256 seed = 622297079027648507301523739429723561394433814885881465;
        uint256 orders = 115792089237316195423570985008687907853269984665640563737226129104255835963389;
        uint256 maxOfferItemsPerOrder = 0;
        uint256 maxConsiderationItemsPerOrder = 1;
        bytes memory callData = abi.encodeCall(
            this.test_fuzz_validOrders,
            (seed, orders, maxOfferItemsPerOrder, maxConsiderationItemsPerOrder)
        );
        (bool success, bytes memory result) = address(this).call(callData);
        if (!success) {
            if (result.length == 0) revert();
            assembly {
                revert(add(0x20, result), mload(result))
            }
        }
    }

    function fail_fuzz_invalidOrders(
        uint256 seed,
        uint256 orders,
        uint256 maxOfferItemsPerOrder,
        uint256 maxConsiderationItemsPerOrder
    ) public pure {
        seed;
        orders;
        maxOfferItemsPerOrder;
        maxConsiderationItemsPerOrder;
        revert("Assertion failed.");
    }
}

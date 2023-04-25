pragma solidity ^0.8.17;

import "./ScuffDirectives.sol";
import "./DynArrayDynArrayFulfillmentComponentPointerLibrary.sol";
import "./DynArrayCriteriaResolverPointerLibrary.sol";
import "./DynArrayAdvancedOrderPointerLibrary.sol";
import { AdvancedOrder, CriteriaResolver, FulfillmentComponent } from "../../../../../contracts/lib/ConsiderationStructs.sol";
import "../../../../../contracts/helpers/PointerLibraries.sol";

type FulfillAvailableAdvancedOrdersPointer is uint256;

using Scuff for MemoryPointer;
using FulfillAvailableAdvancedOrdersPointerLibrary for FulfillAvailableAdvancedOrdersPointer global;

/// @dev Library for resolving pointers of encoded calldata for
/// fulfillAvailableAdvancedOrders(AdvancedOrder[],CriteriaResolver[],FulfillmentComponent[][],FulfillmentComponent[][],bytes32,address,uint256)
library FulfillAvailableAdvancedOrdersPointerLibrary {
  enum ScuffKind { advancedOrders_HeadOverflow, advancedOrders_length_DirtyBits, advancedOrders_length_MaxValue, advancedOrders_element_HeadOverflow, advancedOrders_element_parameters_HeadOverflow, advancedOrders_element_parameters_offerer_DirtyBits, advancedOrders_element_parameters_offerer_MaxValue, advancedOrders_element_parameters_zone_DirtyBits, advancedOrders_element_parameters_zone_MaxValue, advancedOrders_element_parameters_offer_HeadOverflow, advancedOrders_element_parameters_offer_length_DirtyBits, advancedOrders_element_parameters_offer_length_MaxValue, advancedOrders_element_parameters_offer_element_itemType_DirtyBits, advancedOrders_element_parameters_offer_element_itemType_MaxValue, advancedOrders_element_parameters_offer_element_token_DirtyBits, advancedOrders_element_parameters_offer_element_token_MaxValue, advancedOrders_element_parameters_consideration_HeadOverflow, advancedOrders_element_parameters_consideration_length_DirtyBits, advancedOrders_element_parameters_consideration_length_MaxValue, advancedOrders_element_parameters_consideration_element_itemType_DirtyBits, advancedOrders_element_parameters_consideration_element_itemType_MaxValue, advancedOrders_element_parameters_consideration_element_token_DirtyBits, advancedOrders_element_parameters_consideration_element_token_MaxValue, advancedOrders_element_parameters_consideration_element_recipient_DirtyBits, advancedOrders_element_parameters_consideration_element_recipient_MaxValue, advancedOrders_element_parameters_orderType_DirtyBits, advancedOrders_element_parameters_orderType_MaxValue, advancedOrders_element_numerator_DirtyBits, advancedOrders_element_numerator_MaxValue, advancedOrders_element_denominator_DirtyBits, advancedOrders_element_denominator_MaxValue, advancedOrders_element_signature_HeadOverflow, advancedOrders_element_extraData_HeadOverflow, criteriaResolvers_HeadOverflow, criteriaResolvers_length_DirtyBits, criteriaResolvers_length_MaxValue, criteriaResolvers_element_HeadOverflow, criteriaResolvers_element_side_DirtyBits, criteriaResolvers_element_side_MaxValue, criteriaResolvers_element_criteriaProof_HeadOverflow, criteriaResolvers_element_criteriaProof_length_DirtyBits, criteriaResolvers_element_criteriaProof_length_MaxValue, offerFulfillments_HeadOverflow, offerFulfillments_length_DirtyBits, offerFulfillments_length_MaxValue, offerFulfillments_element_HeadOverflow, offerFulfillments_element_length_DirtyBits, offerFulfillments_element_length_MaxValue, considerationFulfillments_HeadOverflow, considerationFulfillments_length_DirtyBits, considerationFulfillments_length_MaxValue, considerationFulfillments_element_HeadOverflow, considerationFulfillments_element_length_DirtyBits, considerationFulfillments_element_length_MaxValue, recipient_DirtyBits, recipient_MaxValue }

  enum ScuffableField { advancedOrders, criteriaResolvers, offerFulfillments, considerationFulfillments, recipient }

  bytes4 internal constant FunctionSelector = 0x87201b41;
  string internal constant FunctionName = "fulfillAvailableAdvancedOrders";
  uint256 internal constant criteriaResolversOffset = 0x20;
  uint256 internal constant offerFulfillmentsOffset = 0x40;
  uint256 internal constant considerationFulfillmentsOffset = 0x60;
  uint256 internal constant fulfillerConduitKeyOffset = 0x80;
  uint256 internal constant recipientOffset = 0xa0;
  uint256 internal constant maximumFulfilledOffset = 0xc0;
  uint256 internal constant HeadSize = 0xe0;
  uint256 internal constant MinimumAdvancedOrdersScuffKind = uint256(ScuffKind.advancedOrders_length_DirtyBits);
  uint256 internal constant MaximumAdvancedOrdersScuffKind = uint256(ScuffKind.advancedOrders_element_extraData_HeadOverflow);
  uint256 internal constant MinimumCriteriaResolversScuffKind = uint256(ScuffKind.criteriaResolvers_length_DirtyBits);
  uint256 internal constant MaximumCriteriaResolversScuffKind = uint256(ScuffKind.criteriaResolvers_element_criteriaProof_length_MaxValue);
  uint256 internal constant MinimumOfferFulfillmentsScuffKind = uint256(ScuffKind.offerFulfillments_length_DirtyBits);
  uint256 internal constant MaximumOfferFulfillmentsScuffKind = uint256(ScuffKind.offerFulfillments_element_length_MaxValue);
  uint256 internal constant MinimumConsiderationFulfillmentsScuffKind = uint256(ScuffKind.considerationFulfillments_length_DirtyBits);
  uint256 internal constant MaximumConsiderationFulfillmentsScuffKind = uint256(ScuffKind.considerationFulfillments_element_length_MaxValue);

  /// @dev Convert a `MemoryPointer` to a `FulfillAvailableAdvancedOrdersPointer`.
  /// This adds `FulfillAvailableAdvancedOrdersPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (FulfillAvailableAdvancedOrdersPointer) {
    return FulfillAvailableAdvancedOrdersPointer.wrap(MemoryPointer.unwrap(ptr.offset(4)));
  }

  /// @dev Convert a `FulfillAvailableAdvancedOrdersPointer` back into a `MemoryPointer`.
  function unwrap(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(FulfillAvailableAdvancedOrdersPointer.unwrap(ptr));
  }

  function isFunction(bytes4 selector) internal pure returns (bool) {
    return FunctionSelector == selector;
  }

  /// @dev Convert a `bytes` with encoded calldata for `fulfillAvailableAdvancedOrders`to a `FulfillAvailableAdvancedOrdersPointer`.
  /// This adds `FulfillAvailableAdvancedOrdersPointerLibrary` functions as members of the pointer
  function fromBytes(bytes memory data) internal pure returns (FulfillAvailableAdvancedOrdersPointer ptrOut) {
    assembly {
      ptrOut := add(data, 0x24)
    }
  }

  /// @dev Encode function call from arguments
  function fromArgs(AdvancedOrder[] memory advancedOrders, CriteriaResolver[] memory criteriaResolvers, FulfillmentComponent[][] memory offerFulfillments, FulfillmentComponent[][] memory considerationFulfillments, bytes32 fulfillerConduitKey, address recipient, uint256 maximumFulfilled) internal pure returns (FulfillAvailableAdvancedOrdersPointer ptrOut) {
    bytes memory data = abi.encodeWithSignature("fulfillAvailableAdvancedOrders(((address,address,(uint8,address,uint256,uint256,uint256)[],(uint8,address,uint256,uint256,uint256,address)[],uint8,uint256,uint256,bytes32,uint256,bytes32,uint256),uint120,uint120,bytes,bytes)[],(uint256,uint8,uint256,uint256,bytes32[])[],(uint256,uint256)[][],(uint256,uint256)[][],bytes32,address,uint256)", advancedOrders, criteriaResolvers, offerFulfillments, considerationFulfillments, fulfillerConduitKey, recipient, maximumFulfilled);
    ptrOut = fromBytes(data);
  }

  /// @dev Resolve the pointer to the head of `advancedOrders` in memory.
  /// This points to the offset of the item's data relative to `ptr`
  function advancedOrdersHead(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the `DynArrayAdvancedOrderPointer` pointing to the data buffer of `advancedOrders`
  function advancedOrdersData(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (DynArrayAdvancedOrderPointer) {
    return DynArrayAdvancedOrderPointerLibrary.wrap(ptr.unwrap().offset(advancedOrdersHead(ptr).readUint256()));
  }

  /// @dev Resolve the pointer to the head of `criteriaResolvers` in memory.
  /// This points to the offset of the item's data relative to `ptr`
  function criteriaResolversHead(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(criteriaResolversOffset);
  }

  /// @dev Resolve the `DynArrayCriteriaResolverPointer` pointing to the data buffer of `criteriaResolvers`
  function criteriaResolversData(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (DynArrayCriteriaResolverPointer) {
    return DynArrayCriteriaResolverPointerLibrary.wrap(ptr.unwrap().offset(criteriaResolversHead(ptr).readUint256()));
  }

  /// @dev Resolve the pointer to the head of `offerFulfillments` in memory.
  /// This points to the offset of the item's data relative to `ptr`
  function offerFulfillmentsHead(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerFulfillmentsOffset);
  }

  /// @dev Resolve the `DynArrayDynArrayFulfillmentComponentPointer` pointing to the data buffer of `offerFulfillments`
  function offerFulfillmentsData(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (DynArrayDynArrayFulfillmentComponentPointer) {
    return DynArrayDynArrayFulfillmentComponentPointerLibrary.wrap(ptr.unwrap().offset(offerFulfillmentsHead(ptr).readUint256()));
  }

  /// @dev Resolve the pointer to the head of `considerationFulfillments` in memory.
  /// This points to the offset of the item's data relative to `ptr`
  function considerationFulfillmentsHead(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationFulfillmentsOffset);
  }

  /// @dev Resolve the `DynArrayDynArrayFulfillmentComponentPointer` pointing to the data buffer of `considerationFulfillments`
  function considerationFulfillmentsData(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (DynArrayDynArrayFulfillmentComponentPointer) {
    return DynArrayDynArrayFulfillmentComponentPointerLibrary.wrap(ptr.unwrap().offset(considerationFulfillmentsHead(ptr).readUint256()));
  }

  /// @dev Resolve the pointer to the head of `fulfillerConduitKey` in memory.
  /// This points to the beginning of the encoded `bytes32`
  function fulfillerConduitKey(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(fulfillerConduitKeyOffset);
  }

  /// @dev Resolve the pointer to the head of `recipient` in memory.
  /// This points to the beginning of the encoded `address`
  function recipient(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// @dev Resolve the pointer to the head of `maximumFulfilled` in memory.
  /// This points to the beginning of the encoded `uint256`
  function maximumFulfilled(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(maximumFulfilledOffset);
  }

  /// @dev Resolve the pointer to the tail segment of the encoded calldata.
  /// This is the beginning of the dynamically encoded data.
  function tail(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }

  function addScuffDirectives(FulfillAvailableAdvancedOrdersPointer ptr, ScuffDirectivesArray directives, uint256 kindOffset, ScuffPositions positions) internal pure {
    /// @dev Overflow offset for `advancedOrders`
    directives.push(Scuff.lower(uint256(ScuffKind.advancedOrders_HeadOverflow) + kindOffset, 224, ptr.advancedOrdersHead(), positions));
    /// @dev Add all nested directives in advancedOrders
    ptr.advancedOrdersData().addScuffDirectives(directives, kindOffset + MinimumAdvancedOrdersScuffKind, positions);
    /// @dev Overflow offset for `criteriaResolvers`
    directives.push(Scuff.lower(uint256(ScuffKind.criteriaResolvers_HeadOverflow) + kindOffset, 224, ptr.criteriaResolversHead(), positions));
    /// @dev Add all nested directives in criteriaResolvers
    ptr.criteriaResolversData().addScuffDirectives(directives, kindOffset + MinimumCriteriaResolversScuffKind, positions);
    /// @dev Overflow offset for `offerFulfillments`
    directives.push(Scuff.lower(uint256(ScuffKind.offerFulfillments_HeadOverflow) + kindOffset, 224, ptr.offerFulfillmentsHead(), positions));
    /// @dev Add all nested directives in offerFulfillments
    ptr.offerFulfillmentsData().addScuffDirectives(directives, kindOffset + MinimumOfferFulfillmentsScuffKind, positions);
    /// @dev Overflow offset for `considerationFulfillments`
    directives.push(Scuff.lower(uint256(ScuffKind.considerationFulfillments_HeadOverflow) + kindOffset, 224, ptr.considerationFulfillmentsHead(), positions));
    /// @dev Add all nested directives in considerationFulfillments
    ptr.considerationFulfillmentsData().addScuffDirectives(directives, kindOffset + MinimumConsiderationFulfillmentsScuffKind, positions);
    /// @dev Add dirty upper bits to `recipient`
    directives.push(Scuff.upper(uint256(ScuffKind.recipient_DirtyBits) + kindOffset, 96, ptr.recipient(), positions));
    /// @dev Set every bit in `recipient` to 1
    directives.push(Scuff.lower(uint256(ScuffKind.recipient_MaxValue) + kindOffset, 96, ptr.recipient(), positions));
  }

  function getScuffDirectives(FulfillAvailableAdvancedOrdersPointer ptr) internal pure returns (ScuffDirective[] memory) {
    ScuffDirectivesArray directives = Scuff.makeUnallocatedArray();
    ScuffPositions positions = EmptyPositions;
    addScuffDirectives(ptr, directives, 0, positions);
    return directives.finalize();
  }

  function getScuffDirectivesForCalldata(bytes memory data) internal pure returns (ScuffDirective[] memory) {
    return getScuffDirectives(fromBytes(data));
  }

  function toString(ScuffKind k) internal pure returns (string memory) {
    if (k == ScuffKind.advancedOrders_HeadOverflow) return "advancedOrders_HeadOverflow";
    if (k == ScuffKind.advancedOrders_length_DirtyBits) return "advancedOrders_length_DirtyBits";
    if (k == ScuffKind.advancedOrders_length_MaxValue) return "advancedOrders_length_MaxValue";
    if (k == ScuffKind.advancedOrders_element_HeadOverflow) return "advancedOrders_element_HeadOverflow";
    if (k == ScuffKind.advancedOrders_element_parameters_HeadOverflow) return "advancedOrders_element_parameters_HeadOverflow";
    if (k == ScuffKind.advancedOrders_element_parameters_offerer_DirtyBits) return "advancedOrders_element_parameters_offerer_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_offerer_MaxValue) return "advancedOrders_element_parameters_offerer_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_zone_DirtyBits) return "advancedOrders_element_parameters_zone_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_zone_MaxValue) return "advancedOrders_element_parameters_zone_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_HeadOverflow) return "advancedOrders_element_parameters_offer_HeadOverflow";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_length_DirtyBits) return "advancedOrders_element_parameters_offer_length_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_length_MaxValue) return "advancedOrders_element_parameters_offer_length_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_element_itemType_DirtyBits) return "advancedOrders_element_parameters_offer_element_itemType_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_element_itemType_MaxValue) return "advancedOrders_element_parameters_offer_element_itemType_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_element_token_DirtyBits) return "advancedOrders_element_parameters_offer_element_token_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_offer_element_token_MaxValue) return "advancedOrders_element_parameters_offer_element_token_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_HeadOverflow) return "advancedOrders_element_parameters_consideration_HeadOverflow";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_length_DirtyBits) return "advancedOrders_element_parameters_consideration_length_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_length_MaxValue) return "advancedOrders_element_parameters_consideration_length_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_itemType_DirtyBits) return "advancedOrders_element_parameters_consideration_element_itemType_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_itemType_MaxValue) return "advancedOrders_element_parameters_consideration_element_itemType_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_token_DirtyBits) return "advancedOrders_element_parameters_consideration_element_token_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_token_MaxValue) return "advancedOrders_element_parameters_consideration_element_token_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_recipient_DirtyBits) return "advancedOrders_element_parameters_consideration_element_recipient_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_consideration_element_recipient_MaxValue) return "advancedOrders_element_parameters_consideration_element_recipient_MaxValue";
    if (k == ScuffKind.advancedOrders_element_parameters_orderType_DirtyBits) return "advancedOrders_element_parameters_orderType_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_parameters_orderType_MaxValue) return "advancedOrders_element_parameters_orderType_MaxValue";
    if (k == ScuffKind.advancedOrders_element_numerator_DirtyBits) return "advancedOrders_element_numerator_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_numerator_MaxValue) return "advancedOrders_element_numerator_MaxValue";
    if (k == ScuffKind.advancedOrders_element_denominator_DirtyBits) return "advancedOrders_element_denominator_DirtyBits";
    if (k == ScuffKind.advancedOrders_element_denominator_MaxValue) return "advancedOrders_element_denominator_MaxValue";
    if (k == ScuffKind.advancedOrders_element_signature_HeadOverflow) return "advancedOrders_element_signature_HeadOverflow";
    if (k == ScuffKind.advancedOrders_element_extraData_HeadOverflow) return "advancedOrders_element_extraData_HeadOverflow";
    if (k == ScuffKind.criteriaResolvers_HeadOverflow) return "criteriaResolvers_HeadOverflow";
    if (k == ScuffKind.criteriaResolvers_length_DirtyBits) return "criteriaResolvers_length_DirtyBits";
    if (k == ScuffKind.criteriaResolvers_length_MaxValue) return "criteriaResolvers_length_MaxValue";
    if (k == ScuffKind.criteriaResolvers_element_HeadOverflow) return "criteriaResolvers_element_HeadOverflow";
    if (k == ScuffKind.criteriaResolvers_element_side_DirtyBits) return "criteriaResolvers_element_side_DirtyBits";
    if (k == ScuffKind.criteriaResolvers_element_side_MaxValue) return "criteriaResolvers_element_side_MaxValue";
    if (k == ScuffKind.criteriaResolvers_element_criteriaProof_HeadOverflow) return "criteriaResolvers_element_criteriaProof_HeadOverflow";
    if (k == ScuffKind.criteriaResolvers_element_criteriaProof_length_DirtyBits) return "criteriaResolvers_element_criteriaProof_length_DirtyBits";
    if (k == ScuffKind.criteriaResolvers_element_criteriaProof_length_MaxValue) return "criteriaResolvers_element_criteriaProof_length_MaxValue";
    if (k == ScuffKind.offerFulfillments_HeadOverflow) return "offerFulfillments_HeadOverflow";
    if (k == ScuffKind.offerFulfillments_length_DirtyBits) return "offerFulfillments_length_DirtyBits";
    if (k == ScuffKind.offerFulfillments_length_MaxValue) return "offerFulfillments_length_MaxValue";
    if (k == ScuffKind.offerFulfillments_element_HeadOverflow) return "offerFulfillments_element_HeadOverflow";
    if (k == ScuffKind.offerFulfillments_element_length_DirtyBits) return "offerFulfillments_element_length_DirtyBits";
    if (k == ScuffKind.offerFulfillments_element_length_MaxValue) return "offerFulfillments_element_length_MaxValue";
    if (k == ScuffKind.considerationFulfillments_HeadOverflow) return "considerationFulfillments_HeadOverflow";
    if (k == ScuffKind.considerationFulfillments_length_DirtyBits) return "considerationFulfillments_length_DirtyBits";
    if (k == ScuffKind.considerationFulfillments_length_MaxValue) return "considerationFulfillments_length_MaxValue";
    if (k == ScuffKind.considerationFulfillments_element_HeadOverflow) return "considerationFulfillments_element_HeadOverflow";
    if (k == ScuffKind.considerationFulfillments_element_length_DirtyBits) return "considerationFulfillments_element_length_DirtyBits";
    if (k == ScuffKind.considerationFulfillments_element_length_MaxValue) return "considerationFulfillments_element_length_MaxValue";
    if (k == ScuffKind.recipient_DirtyBits) return "recipient_DirtyBits";
    return "recipient_MaxValue";
  }

  function toKind(uint256 k) internal pure returns (ScuffKind) {
    return ScuffKind(k);
  }

  function toKindString(uint256 k) internal pure returns (string memory) {
    return toString(toKind(k));
  }
}
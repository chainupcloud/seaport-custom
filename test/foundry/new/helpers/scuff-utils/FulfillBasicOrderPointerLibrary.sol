pragma solidity ^0.8.17;

import "./ScuffDirectives.sol";
import "./BasicOrderParametersPointerLibrary.sol";
import { BasicOrderParameters } from "../../../../../contracts/lib/ConsiderationStructs.sol";
import "../../../../../contracts/helpers/PointerLibraries.sol";

type FulfillBasicOrderPointer is uint256;

using Scuff for MemoryPointer;
using FulfillBasicOrderPointerLibrary for FulfillBasicOrderPointer global;

/// @dev Library for resolving pointers of encoded calldata for
/// fulfillBasicOrder(BasicOrderParameters)
library FulfillBasicOrderPointerLibrary {
  enum ScuffKind { parameters_head_DirtyBits, parameters_head_MaxValue, parameters_additionalRecipients_head_DirtyBits, parameters_additionalRecipients_head_MaxValue, parameters_additionalRecipients_length_DirtyBits, parameters_additionalRecipients_length_MaxValue, parameters_signature_head_DirtyBits, parameters_signature_head_MaxValue, parameters_signature_length_DirtyBits, parameters_signature_length_MaxValue, parameters_signature_DirtyLowerBits }

  enum ScuffableField { parameters_head, parameters }

  bytes4 internal constant FunctionSelector = 0xfb0f3ee1;
  string internal constant FunctionName = "fulfillBasicOrder";
  uint256 internal constant HeadSize = 0x20;
  uint256 internal constant MinimumParametersScuffKind = uint256(ScuffKind.parameters_additionalRecipients_head_DirtyBits);
  uint256 internal constant MaximumParametersScuffKind = uint256(ScuffKind.parameters_signature_DirtyLowerBits);

  /// @dev Convert a `MemoryPointer` to a `FulfillBasicOrderPointer`.
  /// This adds `FulfillBasicOrderPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (FulfillBasicOrderPointer) {
    return FulfillBasicOrderPointer.wrap(MemoryPointer.unwrap(ptr.offset(4)));
  }

  /// @dev Convert a `FulfillBasicOrderPointer` back into a `MemoryPointer`.
  function unwrap(FulfillBasicOrderPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(FulfillBasicOrderPointer.unwrap(ptr));
  }

  function isFunction(bytes4 selector) internal pure returns (bool) {
    return FunctionSelector == selector;
  }

  /// @dev Convert a `bytes` with encoded calldata for `fulfillBasicOrder`to a `FulfillBasicOrderPointer`.
  /// This adds `FulfillBasicOrderPointerLibrary` functions as members of the pointer
  function fromBytes(bytes memory data) internal pure returns (FulfillBasicOrderPointer ptrOut) {
    assembly {
      ptrOut := add(data, 0x24)
    }
  }

  /// @dev Encode function calldata
  function encodeFunctionCall(BasicOrderParameters memory _parameters) internal pure returns (bytes memory) {
    return abi.encodeWithSignature("fulfillBasicOrder((address,uint256,uint256,address,address,address,uint256,uint256,uint8,uint256,uint256,bytes32,uint256,bytes32,bytes32,uint256,(uint256,address)[],bytes))", _parameters);
  }

  /// @dev Encode function call from arguments
  function fromArgs(BasicOrderParameters memory _parameters) internal pure returns (FulfillBasicOrderPointer ptrOut) {
    bytes memory data = encodeFunctionCall(_parameters);
    ptrOut = fromBytes(data);
  }

  /// @dev Resolve the pointer to the head of `parameters` in memory.
  /// This points to the offset of the item's data relative to `ptr`
  function parametersHead(FulfillBasicOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the `BasicOrderParametersPointer` pointing to the data buffer of `parameters`
  function parametersData(FulfillBasicOrderPointer ptr) internal pure returns (BasicOrderParametersPointer) {
    return BasicOrderParametersPointerLibrary.wrap(ptr.unwrap().offset(parametersHead(ptr).readUint256()));
  }

  /// @dev Resolve the pointer to the tail segment of the encoded calldata.
  /// This is the beginning of the dynamically encoded data.
  function tail(FulfillBasicOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }

  function addScuffDirectives(FulfillBasicOrderPointer ptr, ScuffDirectivesArray directives, uint256 kindOffset, ScuffPositions positions) internal pure {
    /// @dev Add dirty upper bits to parameters head
    directives.push(Scuff.upper(uint256(ScuffKind.parameters_head_DirtyBits) + kindOffset, 224, ptr.parametersHead(), positions));
    /// @dev Set every bit in length to 1
    directives.push(Scuff.lower(uint256(ScuffKind.parameters_head_MaxValue) + kindOffset, 229, ptr.parametersHead(), positions));
    /// @dev Add all nested directives in parameters
    ptr.parametersData().addScuffDirectives(directives, kindOffset + MinimumParametersScuffKind, positions);
  }

  function getScuffDirectives(FulfillBasicOrderPointer ptr) internal pure returns (ScuffDirective[] memory) {
    ScuffDirectivesArray directives = Scuff.makeUnallocatedArray();
    ScuffPositions positions = EmptyPositions;
    addScuffDirectives(ptr, directives, 0, positions);
    return directives.finalize();
  }

  function getScuffDirectivesForCalldata(bytes memory data) internal pure returns (ScuffDirective[] memory) {
    return getScuffDirectives(fromBytes(data));
  }

  function toString(ScuffKind k) internal pure returns (string memory) {
    if (k == ScuffKind.parameters_head_DirtyBits) return "parameters_head_DirtyBits";
    if (k == ScuffKind.parameters_head_MaxValue) return "parameters_head_MaxValue";
    if (k == ScuffKind.parameters_additionalRecipients_head_DirtyBits) return "parameters_additionalRecipients_head_DirtyBits";
    if (k == ScuffKind.parameters_additionalRecipients_head_MaxValue) return "parameters_additionalRecipients_head_MaxValue";
    if (k == ScuffKind.parameters_additionalRecipients_length_DirtyBits) return "parameters_additionalRecipients_length_DirtyBits";
    if (k == ScuffKind.parameters_additionalRecipients_length_MaxValue) return "parameters_additionalRecipients_length_MaxValue";
    if (k == ScuffKind.parameters_signature_head_DirtyBits) return "parameters_signature_head_DirtyBits";
    if (k == ScuffKind.parameters_signature_head_MaxValue) return "parameters_signature_head_MaxValue";
    if (k == ScuffKind.parameters_signature_length_DirtyBits) return "parameters_signature_length_DirtyBits";
    if (k == ScuffKind.parameters_signature_length_MaxValue) return "parameters_signature_length_MaxValue";
    return "parameters_signature_DirtyLowerBits";
  }

  function toKind(uint256 k) internal pure returns (ScuffKind) {
    return ScuffKind(k);
  }

  function toKindString(uint256 k) internal pure returns (string memory) {
    return toString(toKind(k));
  }
}
pragma solidity ^0.8.17;

import "./ScuffDirectives.sol";
import "./FulfillmentComponentPointerLibrary.sol";
import "../../../../../contracts/helpers/PointerLibraries.sol";

type DynArrayFulfillmentComponentPointer is uint256;

using Scuff for MemoryPointer;
using DynArrayFulfillmentComponentPointerLibrary for DynArrayFulfillmentComponentPointer global;

/// @dev Library for resolving pointers of encoded FulfillmentComponent[]
library DynArrayFulfillmentComponentPointerLibrary {
  enum ScuffKind { length_DirtyBits, length_MaxValue }

  enum ScuffableField { length }

  uint256 internal constant CalldataStride = 0x40;

  /// @dev Convert a `MemoryPointer` to a `DynArrayFulfillmentComponentPointer`.
  /// This adds `DynArrayFulfillmentComponentPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArrayFulfillmentComponentPointer) {
    return DynArrayFulfillmentComponentPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArrayFulfillmentComponentPointer` back into a `MemoryPointer`.
  function unwrap(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayFulfillmentComponentPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  /// This points to the first item's data
  function head(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  /// This points to the beginning of the encoded `FulfillmentComponent[]`
  function element(DynArrayFulfillmentComponentPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return head(ptr).offset(index * CalldataStride);
  }

  /// @dev Resolve the pointer for the length of the `FulfillmentComponent[]` at `ptr`.
  function length(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `FulfillmentComponent[]` at `ptr` to `length`.
  function setLength(DynArrayFulfillmentComponentPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `FulfillmentComponent[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArrayFulfillmentComponentPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Resolve the `FulfillmentComponentPointer` pointing to the data buffer of `arr[index]`
  function elementData(DynArrayFulfillmentComponentPointer ptr, uint256 index) internal pure returns (FulfillmentComponentPointer) {
    return FulfillmentComponentPointerLibrary.wrap(head(ptr).offset(index * CalldataStride));
  }

  function addScuffDirectives(DynArrayFulfillmentComponentPointer ptr, ScuffDirectivesArray directives, uint256 kindOffset, ScuffPositions positions) internal pure {
    /// @dev Add dirty upper bits to length
    directives.push(Scuff.upper(uint256(ScuffKind.length_DirtyBits) + kindOffset, 224, ptr.length(), positions));
    /// @dev Set every bit in length to 1
    directives.push(Scuff.lower(uint256(ScuffKind.length_MaxValue) + kindOffset, 229, ptr.length(), positions));
    uint256 len = ptr.length().readUint256();
    for (uint256 i; i < len; i++) {
      ScuffPositions pos = positions.push(i);
    }
  }

  function getScuffDirectives(DynArrayFulfillmentComponentPointer ptr) internal pure returns (ScuffDirective[] memory) {
    ScuffDirectivesArray directives = Scuff.makeUnallocatedArray();
    ScuffPositions positions = EmptyPositions;
    addScuffDirectives(ptr, directives, 0, positions);
    return directives.finalize();
  }

  function toString(ScuffKind k) internal pure returns (string memory) {
    if (k == ScuffKind.length_DirtyBits) return "length_DirtyBits";
    return "length_MaxValue";
  }

  function toKind(uint256 k) internal pure returns (ScuffKind) {
    return ScuffKind(k);
  }

  function toKindString(uint256 k) internal pure returns (string memory) {
    return toString(toKind(k));
  }
}
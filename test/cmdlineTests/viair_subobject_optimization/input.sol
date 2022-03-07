// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.0.0;

contract C {
  constructor(uint x) {
    // The constant should be optimized away and occur neither in the bytecode of C
    // nor embedded in the bytecode of D.
    if (x == 0xFFFFFFFFFFFFFFFF42)
      revert();
  }
}
contract D {
  function f() public pure returns (bytes memory) {
    return type(C).creationCode;
  }
}

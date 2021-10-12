contract D {
	uint x;
	function inc() public { ++x; }
	function f() public view returns (uint) { return x; }
}

contract C {
	D d;
	constructor() {
		d = new D();
		assert(d.f() == 0); // should hold
	}
	function g() public view {
		assert(d.f() == 0); // should fail
	}
}
// ====
// SMTEngine: all
// SMTExtCalls: trusted
// ----
// Warning 4984: (47-50): CHC: Overflow (resulting value larger than 2**256 - 1) might happen here.
// Info 1180: Contract invariant(s) for :C:\n((:var 1).storage.storage_D_19[d].x_3_D_19 <= 0)\n
// Warning 2661: (47-50): BMC: Overflow (resulting value larger than 2**256 - 1) happens here.

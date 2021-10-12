contract State {
	uint x;
	function f() public returns (uint) {
		if (x == 0) x = 1;
		else if (x == 1) x = 2;
		else if (x == 2) x = 0;
		return x;
	}
}

contract C {
	address owner;
	uint y;
	uint z;
	State s;

	constructor() {
		s = new State();
		owner = msg.sender;
	}

	function f() public {
		address prevOwner = owner;
		y = s.f();
		z = s.f();
		assert(prevOwner == owner);
		assert(y != z);
	}
}
// ====
// SMTContract: C
// SMTEngine: chc
// SMTExtCalls: trusted
// ----
// Info 1180: Reentrancy property(ies) for :State:\n((<errorCode> = 0) && ((:var 1) = (:var 3)) && (x' = x))\n<errorCode> = 0 -> no errors\n<errorCode> = 1 -> Assertion failed at assert(prevOwner == owner)\n<errorCode> = 2 -> Assertion failed at assert(y != z)\n

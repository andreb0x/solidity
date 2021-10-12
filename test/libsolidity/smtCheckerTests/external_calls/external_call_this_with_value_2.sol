contract C {
	function g(uint i) public {
		require(address(this).balance == 100);
		// if called address is same as this, don't do anything with the value stuff
		// or fix the receiving end
		this.h{value: 1}();
		uint x = address(this).balance;
		assert(x == 100); // should hold
		assert(address(this).balance == 100); // should hold
		assert(address(this).balance == 90); // should fail
	}

	function h() external payable {}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// ----
// Warning 6328: (107-143): CHC: Assertion violation happens here.
// Warning 6328: (162-197): CHC: Assertion violation happens here.

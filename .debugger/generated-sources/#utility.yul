{

    function abi_decode_t_address(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_address(value)
    }

    function abi_decode_t_uint256(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_uint256(value)
    }

    function abi_decode_tuple_t_address(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert(0, 0) }

        {

            let offset := 0

            value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
        }

    }

    function abi_decode_tuple_t_uint256(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert(0, 0) }

        {

            let offset := 0

            value0 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

    }

    function abi_encode_t_uint256_to_t_uint256_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint256(value))
    }

    function abi_encode_tuple_t_uint256__to_t_uint256__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        abi_encode_t_uint256_to_t_uint256_fromStack(value0,  add(headStart, 0))

    }

    function checked_add_t_uint256(x, y) -> sum {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)

        // overflow, if x > (maxValue - y)
        if gt(x, sub(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, y)) { panic_error_0x11() }

        sum := add(x, y)
    }

    function checked_sub_t_uint256(x, y) -> diff {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)

        if lt(x, y) { panic_error_0x11() }

        diff := sub(x, y)
    }

    function cleanup_t_address(value) -> cleaned {
        cleaned := cleanup_t_uint160(value)
    }

    function cleanup_t_uint160(value) -> cleaned {
        cleaned := and(value, 0xffffffffffffffffffffffffffffffffffffffff)
    }

    function cleanup_t_uint256(value) -> cleaned {
        cleaned := value
    }

    function panic_error_0x11() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x11)
        revert(0, 0x24)
    }

    function validator_revert_t_address(value) {
        if iszero(eq(value, cleanup_t_address(value))) { revert(0, 0) }
    }

    function validator_revert_t_uint256(value) {
        if iszero(eq(value, cleanup_t_uint256(value))) { revert(0, 0) }
    }

}

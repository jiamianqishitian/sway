//! Utility functions for cryptographic hashing.
library;

/// Returns the `SHA-2-256` hash of `param`.
///
/// # Arguments
///
/// * `param`: [T] - The value to be hashed.
///
/// # Returns
///
/// * [b256] - The sha-256 hash of the value.
///
/// # Examples
/// 
/// ```sway
/// use std::hash::sha256;
///
/// fn foo() {
///     let result = sha256("Fuel");
///     assert(result = 0xa80f942f4112036dfc2da86daf6d2ef6ede3164dd56d1000eb82fa87c992450f);
/// }
/// ```
pub fn sha256<T>(param: T) -> b256 {
    let mut result_buffer: b256 = b256::min();
    if !__is_reference_type::<T>() {
        asm(buffer, ptr: param, eight_bytes: 8, hash: result_buffer) {
            move buffer sp; // Make `buffer` point to the current top of the stack
            cfei i8; // Grow stack by 1 word
            sw buffer ptr i0; // Save value in register at "ptr" to memory at "buffer"
            s256 hash buffer eight_bytes; // Hash the next eight bytes starting from "buffer" into "hash"
            cfsi i8; // Shrink stack by 1 word
            hash: b256 // Return
        }
    } else {
        let size = if __is_str_type::<T>() {
            __size_of_str::<T>()
        } else {
            __size_of::<T>()
        };
        asm(hash: result_buffer, ptr: param, bytes: size) {
            s256 hash ptr bytes; // Hash the next "size" number of bytes starting from "ptr" into "hash"
            hash: b256 // Return
        }
    }
}

/// Returns the `KECCAK-256` hash of `param`.
///
/// # Arguments
///
/// * `param`: [T] - The value to be hashed.
///
/// # Returns
///
/// * [b256] - The keccak-256 hash of the value.
///
/// # Examples
/// 
/// ```sway
/// use std::hash::keccak256;
///
/// fn foo() {
///     let result = keccak256("Fuel");
///     assert(result = 0x4375c8bcdc904e5f51752581202ae9ae2bb6eddf8de05d5567d9a6b0ae4789ad);
/// }
/// ```
pub fn keccak256<T>(param: T) -> b256 {
    let mut result_buffer: b256 = b256::min();
    if !__is_reference_type::<T>() {
        asm(buffer, ptr: param, eight_bytes: 8, hash: result_buffer) {
            move buffer sp; // Make `buffer` point to the current top of the stack
            cfei i8; // Grow stack by 1 word
            sw buffer ptr i0; // Save value in register at "ptr" to memory at "buffer"
            k256 hash buffer eight_bytes; // Hash the next eight bytes starting from "buffer" into "hash"
            cfsi i8; // Shrink stack by 1 word
            hash: b256 // Return
        }
    } else {
        let size = if __is_str_type::<T>() {
            __size_of_str::<T>()
        } else {
            __size_of::<T>()
        };
        asm(hash: result_buffer, ptr: param, bytes: size) {
            k256 hash ptr bytes; // Hash the next "size" number of bytes starting from "ptr" into "hash"
            hash: b256 // Return
        }
    }
}

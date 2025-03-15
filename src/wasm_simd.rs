use core::arch::wasm32::{f32x4_add, v128, v128_load, v128_store};

/// Adds two vectors of four 32-bit floats using SIMD and returns the result.
#[unsafe(no_mangle)]
pub extern "C" fn simd_pointwise_add(a_ptr: *const f32, b_ptr: *const f32, result_ptr: *mut f32) {
    unsafe {
        let va = v128_load(a_ptr as *const v128);
        let vb = v128_load(b_ptr as *const v128);
        let sum = f32x4_add(va, vb);

        v128_store(result_ptr as *mut v128, sum);
    }
}
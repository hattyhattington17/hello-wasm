use core::arch::wasm32::*;

/// Computes inner product of two n-length vectors of 32-bit integers using SIMD.
#[unsafe(no_mangle)]
pub extern "C" fn inner_product_simd(a_ptr: *const i32, b_ptr: *const i32, n: i32) -> i32 {
    let mut sum: i32 = 0;
    // Process four i32 elements at a time.
    let chunks = (n / 4) as usize;
    unsafe {
        for i in 0..chunks {
            let a_vec = v128_load(a_ptr.add(i * 4) as *const v128);
            let b_vec = v128_load(b_ptr.add(i * 4) as *const v128);
            let prod = i32x4_mul(a_vec, b_vec);
            sum += i32x4_extract_lane::<0>(prod)
                + i32x4_extract_lane::<1>(prod)
                + i32x4_extract_lane::<2>(prod)
                + i32x4_extract_lane::<3>(prod);
        }
    }
    sum
}

/// Computes inner product of two n-length vectors of 32-bit integers without using SIMD.
#[unsafe(no_mangle)]
pub extern "C" fn inner_product_scalar(a_ptr: *const i32, b_ptr: *const i32, n: i32) -> i32 {
    let mut sum = 0;
    let count = n as usize;
    for i in 0..count {
        unsafe {
            sum += *a_ptr.add(i) * *b_ptr.add(i);
        }
    }
    sum
}

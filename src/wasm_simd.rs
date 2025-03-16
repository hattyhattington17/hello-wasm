use core::arch::wasm32::*;

/// Computes inner product of two n-length vectors of 32-bit integers using SIMD.
#[unsafe(no_mangle)]
pub extern "C" fn inner_product_simd(a_ptr: *const u32, b_ptr: *const u32, n: u32) -> u32 {
    let mut sum: u32 = 0;
    // Process four u32 elements at a time.
    let chunks = (n / 4) as usize;
    unsafe {
        for i in 0..chunks {
            let a_vec = v128_load(a_ptr.add(i * 4) as *const v128);
            let b_vec = v128_load(b_ptr.add(i * 4) as *const v128);
            let prod = u32x4_mul(a_vec, b_vec);
            sum += u32x4_extract_lane::<0>(prod)
                + u32x4_extract_lane::<1>(prod)
                + u32x4_extract_lane::<2>(prod)
                + u32x4_extract_lane::<3>(prod);
        }
    }
    sum
}

/// Computes inner product of two n-length vectors of 32-bit integers without using SIMD.
#[unsafe(no_mangle)]
pub extern "C" fn inner_product_scalar(a_ptr: *const u32, b_ptr: *const u32, n: u32) -> u32 {
    let mut sum = 0;
    for i in 0..n as usize {
        unsafe {
            sum += *a_ptr.add(i) * *b_ptr.add(i);
        }
    }
    sum
}

unsafe extern "C" {
    unsafe fn js_console_log(c: u32);
}

#[unsafe(no_mangle)]
pub fn get_meaning_of_life() {
    unsafe {
        js_console_log(42);
    }
}

#[unsafe(no_mangle)]
pub fn get_meaning_of_lifes() -> u32 {
    return 32;
}

#[cfg(all(target_family = "wasm", target_feature = "simd128"))]
mod wasm_simd;

#[cfg(all(target_family = "wasm", target_feature = "simd128"))]
pub use wasm_simd::simd_pointwise_add;

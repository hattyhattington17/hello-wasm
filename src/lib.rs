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
pub fn loop_to_n_rust(n: u32) {
    let mut i = 0;
    while i < n {
        unsafe {
            js_console_log(i);
        }
        i += 1;
    }
}

#[unsafe(no_mangle)]
pub fn inner_product(a_ptr: *const u32, b_ptr: *const u32, n: u32) -> u32 {
    let mut sum = 0;
    for i in 0..n as usize {
        unsafe {
            sum += *a_ptr.add(i) * *b_ptr.add(i);
        }
    }
    sum
}

unsafe extern "C" {
    unsafe fn js_console_log(c: u32);
}

#[unsafe(no_mangle)]
pub fn get_meaning_of_life() {
    unsafe {
        js_console_log(42);
    }
}
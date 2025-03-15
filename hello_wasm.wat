(module $hello_wasm.wasm
  (type (;0;) (func (param i32)))
  (type (;1;) (func))
  (type (;2;) (func (result i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (import "env" "js_console_log" (func $js_console_log (type 0)))
  (func $get_meaning_of_life (type 1)
    i32.const 42
    call $js_console_log)
  (func $get_meaning_of_lifes (type 2) (result i32)
    i32.const 32)
  (func $simd_pointwise_add (type 3) (param i32 i32 i32)
    local.get 2
    local.get 0
    v128.load align=1
    local.get 1
    v128.load align=1
    f32x4.add
    v128.store align=1)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 16)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "memory" (memory 0))
  (export "get_meaning_of_life" (func $get_meaning_of_life))
  (export "get_meaning_of_lifes" (func $get_meaning_of_lifes))
  (export "simd_pointwise_add" (func $simd_pointwise_add))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

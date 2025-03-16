(module $hello_wasm.wasm
  (type (;0;) (func (param i32)))
  (type (;1;) (func))
  (type (;2;) (func (result i32)))
  (type (;3;) (func (param i32 i32 i32) (result i32)))
  (import "env" "memory" (memory (;0;) 16))
  (import "env" "js_console_log" (func $js_console_log (type 0)))
  (func $get_meaning_of_life (type 1)
    i32.const 42
    call $js_console_log)
  (func $get_meaning_of_lifes (type 2) (result i32)
    i32.const 32)
  (func $inner_product_simd (type 3) (param i32 i32 i32) (result i32)
    (local i32 v128)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.const 4
      i32.lt_u
      br_if 0 (;@1;)
      local.get 2
      i32.const 2
      i32.shr_u
      local.set 2
      i32.const 0
      local.set 3
      loop  ;; label = @2
        local.get 1
        v128.load align=1
        local.get 0
        v128.load align=1
        i32x4.mul
        local.tee 4
        i32x4.extract_lane 1
        local.get 3
        i32.add
        local.get 4
        i32x4.extract_lane 0
        i32.add
        local.get 4
        i32x4.extract_lane 2
        i32.add
        local.get 4
        i32x4.extract_lane 3
        i32.add
        local.set 3
        local.get 0
        i32.const 16
        i32.add
        local.set 0
        local.get 1
        i32.const 16
        i32.add
        local.set 1
        local.get 2
        i32.const -1
        i32.add
        local.tee 2
        br_if 0 (;@2;)
      end
    end
    local.get 3)
  (func $inner_product_scalar (type 3) (param i32 i32 i32) (result i32)
    (local i32 i32 v128 i32 i32)
    block  ;; label = @1
      local.get 2
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    i32.const 0
    local.set 3
    i32.const 0
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 4
        i32.lt_u
        br_if 0 (;@2;)
        v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000
        local.set 5
        local.get 2
        i32.const -4
        i32.and
        local.tee 4
        local.set 3
        local.get 1
        local.set 6
        local.get 0
        local.set 7
        loop  ;; label = @3
          local.get 6
          v128.load align=4
          local.get 7
          v128.load align=4
          i32x4.mul
          local.get 5
          i32x4.add
          local.set 5
          local.get 6
          i32.const 16
          i32.add
          local.set 6
          local.get 7
          i32.const 16
          i32.add
          local.set 7
          local.get 3
          i32.const -4
          i32.add
          local.tee 3
          br_if 0 (;@3;)
        end
        local.get 5
        local.get 5
        local.get 5
        i8x16.shuffle 8 9 10 11 12 13 14 15 0 1 2 3 0 1 2 3
        i32x4.add
        local.tee 5
        local.get 5
        local.get 5
        i8x16.shuffle 4 5 6 7 0 1 2 3 0 1 2 3 0 1 2 3
        i32x4.add
        i32x4.extract_lane 0
        local.set 3
        local.get 2
        local.get 4
        i32.eq
        br_if 1 (;@1;)
      end
      local.get 2
      local.get 4
      i32.sub
      local.set 2
      local.get 0
      local.get 4
      i32.const 2
      i32.shl
      local.tee 7
      i32.add
      local.set 6
      local.get 1
      local.get 7
      i32.add
      local.set 7
      loop  ;; label = @2
        local.get 7
        i32.load
        local.get 6
        i32.load
        i32.mul
        local.get 3
        i32.add
        local.set 3
        local.get 6
        i32.const 4
        i32.add
        local.set 6
        local.get 7
        i32.const 4
        i32.add
        local.set 7
        local.get 2
        i32.const -1
        i32.add
        local.tee 2
        br_if 0 (;@2;)
      end
    end
    local.get 3)
  (table (;0;) 1 1 funcref)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "get_meaning_of_life" (func $get_meaning_of_life))
  (export "get_meaning_of_lifes" (func $get_meaning_of_lifes))
  (export "inner_product_simd" (func $inner_product_simd))
  (export "inner_product_scalar" (func $inner_product_scalar))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

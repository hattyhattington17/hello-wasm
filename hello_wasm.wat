(module $hello_wasm.wasm
  (type (;0;) (func (param i32)))
  (type (;1;) (func))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (import "env" "memory" (memory (;0;) 16))
  (import "env" "js_console_log" (func $js_console_log (type 0)))
  (func $get_meaning_of_life (type 1)
    i32.const 42
    call $js_console_log)
  (func $loop_to_n_rust (type 0) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      loop  ;; label = @2
        local.get 1
        call $js_console_log
        local.get 0
        local.get 1
        i32.const 1
        i32.add
        local.tee 1
        i32.ne
        br_if 0 (;@2;)
      end
    end)
  (func $inner_product (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 2
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    local.get 2
    i32.const 3
    i32.and
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 4
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 2
      i32.const -4
      i32.and
      local.set 5
      i32.const 0
      local.set 6
      i32.const 0
      local.set 2
      i32.const 0
      local.set 4
      loop  ;; label = @2
        local.get 1
        local.get 6
        i32.add
        local.tee 7
        i32.const 12
        i32.add
        i32.load
        local.get 0
        local.get 6
        i32.add
        local.tee 8
        i32.const 12
        i32.add
        i32.load
        i32.mul
        local.get 7
        i32.const 8
        i32.add
        i32.load
        local.get 8
        i32.const 8
        i32.add
        i32.load
        i32.mul
        local.get 7
        i32.const 4
        i32.add
        i32.load
        local.get 8
        i32.const 4
        i32.add
        i32.load
        i32.mul
        local.get 7
        i32.load
        local.get 8
        i32.load
        i32.mul
        local.get 2
        i32.add
        i32.add
        i32.add
        i32.add
        local.set 2
        local.get 6
        i32.const 16
        i32.add
        local.set 6
        local.get 5
        local.get 4
        i32.const 4
        i32.add
        local.tee 4
        i32.ne
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
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
        local.get 2
        i32.add
        local.set 2
        local.get 6
        i32.const 4
        i32.add
        local.set 6
        local.get 7
        i32.const 4
        i32.add
        local.set 7
        local.get 3
        i32.const -1
        i32.add
        local.tee 3
        br_if 0 (;@2;)
      end
    end
    local.get 2)
  (table (;0;) 1 1 funcref)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "get_meaning_of_life" (func $get_meaning_of_life))
  (export "loop_to_n_rust" (func $loop_to_n_rust))
  (export "inner_product" (func $inner_product))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

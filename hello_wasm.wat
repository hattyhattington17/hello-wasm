(module $hello_wasm.wasm
  (type (;0;) (func (param i32)))
  (type (;1;) (func))
  (import "env" "js_console_log" (func $js_console_log (type 0)))
  (func $get_meaning_of_life (type 1)
    i32.const 42
    call $js_console_log)

  ;; define a function named $loop_to_n taking a single i32 parameter and using a single i32 local variable
  (func $loop_to_n (type 0) (param $n i32)  
    (local $i i32) 
    
    ;; begin the function body
    i32.const 0  ;; Push the constant value 0 onto the stack  
    local.set $i  ;; Set the local variable $i to the top value on the stack
    
    ;; begin a block named $loop_exit    
    block $loop_exit  
      loop $loop  ;; begin a loop named $loop    
        local.get $i  ;; push value of $i to the stack  
        local.get $n  ;; push the value of parameter $n to the stack   
        i32.ge_s  ;; pop two values from the stack and interpret them as signed integers for comparison, push the boolean result of the comparison to the stack
        br_if $loop_exit  ;; If the comparison is true, break out of the loop to $loop_exit    
        local.get $i  ;; push value of $i to the stack     
        call $js_console_log  ;; call the imported function $js_console_log with the top value of the stack as the argument
        local.get $i  ;; push value of $i to the stack      
        i32.const 1  ;; push constant 1 to the stack     
        i32.add  ;; add the top two values on the stack and push the result
        local.set $i  ;; Set the local variable $i to the top value on the stack i = (i + 1)    
        br $loop  ;; Jump back to the beginning of the loop    
      end    
    end)
  ;; export the function from the module
  (export "loop_to_n" (func $loop_to_n))
  
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
  (table (;0;) 1 1 funcref)
  (memory (;0;) 16)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "memory" (memory 0))
  (export "get_meaning_of_life" (func $get_meaning_of_life))
  (export "loop_to_n_rust" (func $loop_to_n_rust))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

const { module, instance } = await WebAssembly.instantiateStreaming(fetch('hello_wasm.wasm'), {
    env: {
        js_console_log: (x) => { console.log(x); }
    }
});

instance.exports.loop_to_n(10);
instance.exports.loop_to_n_rust(10);
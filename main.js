const { module, instance} = await WebAssembly.instantiateStreaming(fetch('hello_wasm.wasm'), {
    env: {
        js_console_log: (x) => { console.log(x); }
    }
});

instance.exports.get_meaning_of_life();
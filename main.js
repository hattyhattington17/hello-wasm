// create the WebAssembly memory and supply it to the module as part of the importObject
const memory = new WebAssembly.Memory({ initial: 65536, maximum: 65536 });
const { instance } = await WebAssembly.instantiateStreaming(fetch('hello_wasm.wasm'), {
    env: {
        js_console_log: (x) => { console.log(x); },
        memory
    }
});

/********** Initialize the wasm memory with the arrays being combined **********/
// length of the arrays
const n = 500_000_000;
// Create a DataView into the memory buffer
const dataView = new DataView(memory.buffer);
// initialize two n-length arrays in linear memory with random u32 values
for (let i = 0; i < n; i++) {
    // wasm uses little-endian byte order, so we need to set the last argument to true 
    dataView.setUint32(i * 4, Math.floor(Math.random() * 10), true);
    dataView.setUint32((n + i) * 4, Math.floor(Math.random() * 10), true);
}

/********** Compute the inner product **********/
const wasmStart = performance.now();
let wasmProduct = instance.exports.inner_product(0, n * 4, n);
const wasmEnd = performance.now();

console.log(`inner product ${wasmProduct}, time to compute: ${wasmEnd - wasmStart} ms`); 
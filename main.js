const { module, instance } = await WebAssembly.instantiateStreaming(fetch('hello_wasm.wasm'), {
    env: {
        js_console_log: (x) => { console.log(x); }
    }
});

instance.exports.get_meaning_of_life();

// Allocate memory for input vectors and result vector
// arrays must be allocated in wasm linear memory for the module to read them
const a = new Float32Array(instance.exports.memory.buffer, 0, 4);
const b = new Float32Array(instance.exports.memory.buffer, 16, 4);
const result = new Float32Array(instance.exports.memory.buffer, 32, 4);

// Initialize input vectors
a.set([1.0, 2.0, 3.0, 4.0]);
b.set([5.0, 6.0, 7.0, 8.0]);

// pointwise add vectors a and b and store result in result
instance.exports.simd_pointwise_add(a.byteOffset, b.byteOffset, result.byteOffset);
console.log('Result:', result.at(0), result.at(1), result.at(2), result.at(3));


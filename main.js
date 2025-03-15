
const memory = new WebAssembly.Memory({ initial: 65536, maximum: 65536 });
const { instance } = await WebAssembly.instantiateStreaming(fetch('hello_wasm.wasm'), {
    env: {
        js_console_log: (x) => { console.log(x); },
        memory
    }
});

const { inner_product_simd, inner_product_scalar } = instance.exports;

// must set (memory (;0;) 65536) in the wasm file 
console.log(`memory.buffer.byteLength: ${memory.buffer.byteLength}`);
if (memory.buffer.byteLength !== 4294967296) {
    throw new Error('must set (memory (;0;) 65536) in the wat file, then convert back to wasm ');
}
const length = 500_000_000;

// Create a DataView for the WebAssembly memory buffer
const dataView = new DataView(memory.buffer);

// initialize two i32 arrays in linear memory with random values
for (let i = 0; i < length; i++) {
    dataView.setInt32(i * 4, Math.floor(Math.random() * 10), true); // true for little-endian
    dataView.setInt32((length + i) * 4, Math.floor(Math.random() * 10), true); // true for little-endian
}

// Benchmark the SIMD inner product
const simdStart = performance.now();
let simd = inner_product_simd(0, length * 4, length);
const simdEnd = performance.now();

// Benchmark the scalar inner product
const scalarStart = performance.now();
let scalar = inner_product_scalar(0, length * 4, length);
const scalarEnd = performance.now();

console.log(`SIMD inner product ${simd}, time to compute: ${simdEnd - simdStart} ms`);
console.log(`Scalar inner product ${scalar}, time to compute: ${(scalarEnd - scalarStart)} ms`);


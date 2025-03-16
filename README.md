# Hello-Wasm Example Application
- Compile the Rust library into wasm and copy the Wasm binary into the project root
```shell
rustup target add wasm32-unknown-unknown
cargo build --release --target wasm32-unknown-unknown
cp target/wasm32-unknown-unknown/release/hello_wasm.wasm ./
```
- Serve the `index.html`, `main.js`, and Wasm module 
```
npx serve .
```

# Wasm Text Format
- Install WebAssembly Binary Toolkit
```shell
brew install wabt
```
- Convert a Wasm binary into its human readable WebAssembly Text Format representation
```shell
wasm2wat target/wasm32-unknown-unknown/release/hello_wasm.wasm -o hello_wasm.wat 
```
- Convert a WebAssembly Text Format file into its executable Wasm binary representation
```shell
wat2wasm hello_wasm.wat -o hello_wasm.wasm --debug-names
```
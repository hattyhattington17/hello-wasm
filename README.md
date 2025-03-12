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
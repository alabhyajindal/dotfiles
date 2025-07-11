function wasmc
    /opt/wasi-sdk/bin/clang $argv -o (string replace c wasm $argv[1])
end

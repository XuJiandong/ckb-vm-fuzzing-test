#!/bin/bash

LLVM_COV="${LLVM_COV:-llvm-cov-19}"
TARGET="${TARGET:-interpreter}"

cd deps/ckb-vm
cargo +nightly fuzz coverage ${TARGET} fuzz/corpus/${TARGET}
${LLVM_COV} show target/x86_64-unknown-linux-gnu/coverage/x86_64-unknown-linux-gnu/release/${TARGET} \
    -instr-profile=fuzz/coverage/${TARGET}/coverage.profdata \
    -format=html \
    -ignore-filename-regex='\.cargo' > fuzz/coverage/${TARGET}/index.html
cd -


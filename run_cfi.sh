#!/bin/bash
set -ex

cd deps
rm -rf ckb-vm
git clone https://github.com/nervosnetwork/ckb-vm --depth 1 --branch cfi
cd -

# must use absolute path
ln -s "$PWD/corpus" "$PWD/deps/ckb-vm/fuzz/corpus"

cd deps/ckb-vm

fuzz() {
    if [ -f ./fuzz/fuzz_targets/$1.rs ]; then
        cargo +nightly fuzz run -j $(nproc) $1 -- -max_total_time=$2 -timeout=2 -max_len=614400
    fi
}

fuzz interpreter 300

cd -

# X86 Backend Plugin Session

## Mission

Build `lib/LLVMX86BackendPlugin.so` as a system-clang-loadable replacement for
the X86 backend/codegen path.

The plugin should contain the X86 backend plus most generic CodeGen sources,
including ISel and register allocation code, without loading `libLLVM.so`.

## Build

```sh
cmake -S llvm -B build-llvm-backend2 -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_TARGETS_TO_BUILD=X86 \
  -DLLVM_BUILD_LLVM_DYLIB=ON \
  -DLLVM_LINK_LLVM_DYLIB=ON
```

```sh
ninja -C build-llvm-backend2 lib/LLVMX86BackendPlugin.so
```

Plugin output:

```sh
build-llvm-backend2/lib/LLVMX86BackendPlugin.so
```

## Test

```sh
/usr/bin/clang \
  -fpass-plugin=/home/varsec/mnt/build-llvm-backend2/lib/LLVMX86BackendPlugin.so \
  ...
```

Expected x86 remark:

```text
x86-backend-plugin: remark: replacing clang backend for x86_64-pc-linux-gnu
```

Non-X86 should fail closed:

```sh
/usr/bin/clang --target=aarch64-linux-gnu \
  -fpass-plugin=/home/varsec/mnt/build-llvm-backend2/lib/LLVMX86BackendPlugin.so
```

Expected error:

```text
error: X86 backend plugin can only compile x86 targets
```

## Collision Notes

The plugin statically links LLVM/X86/CodeGen objects into a process that already
has system clang/libLLVM loaded.

Resolution:

- Compile plugin objects with hidden visibility.
- Export only llvmGetPassPluginInfo.
- Do not link against libLLVM.so.
- Prefix plugin-built cl::opt names centrally in llvm/include/llvm/Support/CommandLine.h.

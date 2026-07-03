//===-- X86BackendPlugin.cpp - X86 backend replacement plugin -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/X86TargetInfo.h"
#include "X86TargetMachine.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/CodeGen.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/WithColor.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/TargetParser/Triple.h"
#include <memory>
#include <mutex>

using namespace llvm;

static_assert(LLVM_PLUGIN_API_VERSION == 2,
              "X86 backend plugin requires the pre-codegen plugin ABI");

extern "C" void LLVMInitializeX86Target();
extern "C" void LLVMInitializeX86TargetMC();
extern "C" void LLVMInitializeX86AsmPrinter();
extern "C" void LLVMInitializeX86AsmParser();
extern "C" void LLVMInitializeX86Disassembler();

namespace {

bool isX86Target(const Triple &TT) {
  return TT.getArch() == Triple::x86 || TT.getArch() == Triple::x86_64;
}

void initializePluginX86Backend() {
  static std::once_flag InitFlag;
  std::call_once(InitFlag, [] {
    LLVMInitializeX86Target();
    LLVMInitializeX86TargetMC();
    LLVMInitializeX86AsmPrinter();
  });
}

bool runX86Backend(Module &M, TargetMachine &TM, CodeGenFileType CGFT,
                   raw_pwrite_stream &OS) {
  const Triple TT(M.getTargetTriple().empty() ? TM.getTargetTriple()
                                              : Triple(M.getTargetTriple()));
  if (!isX86Target(TT)) {
    M.getContext().emitError("X86 backend plugin can only compile x86 targets");
    return true;
  }

  WithColor::remark(errs(), "x86-backend-plugin")
      << "replacing clang backend for " << TT.str() << '\n';

  initializePluginX86Backend();

  const Target &PluginTarget =
      TT.getArch() == Triple::x86_64 ? getTheX86_64Target()
                                     : getTheX86_32Target();
  auto PluginTM = std::make_unique<X86TargetMachine>(
      PluginTarget, TT, TM.getTargetCPU(), TM.getTargetFeatureString(),
      TM.Options, TM.getRelocationModel(), TM.getCodeModel(), TM.getOptLevel(),
      /*JIT=*/false);

  legacy::PassManager CodeGenPasses;
  CodeGenPasses.add(createTargetTransformInfoWrapperPass(
      PluginTM->getTargetIRAnalysis()));

  if (PluginTM->addPassesToEmitFile(CodeGenPasses, OS, /*DwoOut=*/nullptr,
                                    CGFT, /*DisableVerify=*/true)) {
    M.getContext().emitError("X86 backend plugin cannot emit requested output");
    return true;
  }

  CodeGenPasses.run(M);
  return true;
}

void registerPassBuilderCallbacks(PassBuilder &) {}

} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK LLVM_EXTERNAL_VISIBILITY PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "X86BackendPlugin", LLVM_VERSION_STRING,
          registerPassBuilderCallbacks, runX86Backend};
}

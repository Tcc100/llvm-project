set(x86_backend_plugin_desc_sources
  ../MCTargetDesc/X86ATTInstPrinter.cpp
  ../MCTargetDesc/X86IntelInstPrinter.cpp
  ../MCTargetDesc/X86InstComments.cpp
  ../MCTargetDesc/X86InstPrinterCommon.cpp
  ../MCTargetDesc/X86EncodingOptimization.cpp
  ../MCTargetDesc/X86ShuffleDecode.cpp
  ../MCTargetDesc/X86AsmBackend.cpp
  ../MCTargetDesc/X86MCTargetDesc.cpp
  ../MCTargetDesc/X86MCAsmInfo.cpp
  ../MCTargetDesc/X86MCCodeEmitter.cpp
  ../MCTargetDesc/X86MachObjectWriter.cpp
  ../MCTargetDesc/X86MnemonicTables.cpp
  ../MCTargetDesc/X86ELFObjectWriter.cpp
  ../MCTargetDesc/X86WinCOFFObjectWriter.cpp
  ../MCTargetDesc/X86WinCOFFStreamer.cpp
  ../MCTargetDesc/X86WinCOFFTargetStreamer.cpp
  )

set(x86_backend_plugin_info_sources
  ../TargetInfo/X86TargetInfo.cpp
  )

file(GLOB x86_backend_plugin_generic_codegen_sources CONFIGURE_DEPENDS
  ../../../CodeGen/*.cpp
  ../../../CodeGen/AsmPrinter/*.cpp
  ../../../CodeGen/GlobalISel/*.cpp
  ../../../CodeGen/LiveDebugValues/*.cpp
  ../../../CodeGen/MIRParser/*.cpp
  ../../../CodeGen/SelectionDAG/*.cpp
  )
foreach(src ${x86_backend_plugin_generic_codegen_sources})
  if(src MATCHES "/CodeGen/CommandFlags\\.cpp$")
    list(REMOVE_ITEM x86_backend_plugin_generic_codegen_sources ${src})
  endif()
endforeach()

set(x86_backend_plugin_codegen_sources)
foreach(src ${sources})
  if(src STREQUAL "GISel/X86PreLegalizerCombiner.cpp")
    continue()
  endif()
  list(APPEND x86_backend_plugin_codegen_sources ../${src})
endforeach()

add_library(LLVMX86BackendPluginObjects OBJECT
  ${x86_backend_plugin_codegen_sources}
  ${x86_backend_plugin_generic_codegen_sources}
  ${x86_backend_plugin_desc_sources}
  ${x86_backend_plugin_info_sources}
  )

llvm_update_compile_flags(LLVMX86BackendPluginObjects)
target_compile_definitions(LLVMX86BackendPluginObjects PRIVATE
  LLVM_BUILD_STATIC
  LLVM_X86_BACKEND_PLUGIN
  )
target_include_directories(LLVMX86BackendPluginObjects PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/..
  ${CMAKE_CURRENT_BINARY_DIR}/..
  )
set_target_properties(LLVMX86BackendPluginObjects PROPERTIES
  C_VISIBILITY_PRESET hidden
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN YES
  )
add_dependencies(LLVMX86BackendPluginObjects
  intrinsics_gen
  vt_gen
  X86CommonTableGen
  )

add_llvm_library(LLVMX86BackendPlugin MODULE NO_EXPORT
  DISABLE_LLVM_LINK_LLVM_DYLIB
  X86BackendPlugin.cpp
  $<TARGET_OBJECTS:LLVMX86BackendPluginObjects>

  DEPENDS
  intrinsics_gen
  vt_gen
  X86CommonTableGen
  )

target_include_directories(LLVMX86BackendPlugin PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/..
  )

add_dependencies(LLVMX86BackendPlugin
  LLVMX86BackendPluginObjects
  )

set_target_properties(LLVMX86BackendPlugin PROPERTIES
  C_VISIBILITY_PRESET hidden
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN YES
  )

add_llvm_symbol_exports(LLVMX86BackendPlugin
  ${CMAKE_CURRENT_SOURCE_DIR}/X86BackendPlugin.exports
  )

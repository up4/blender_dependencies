set(CLANG_EXTRA_ARGS 
   -DCLANG_PATH_TO_LLVM_SOURCE=${CMAKE_CURRENT_BINARY_DIR}/build/ll/src/ll
   -DCLANG_PATH_TO_LLVM_BUILD=${LIBDIR}/llvm
   -DLLVM_USE_CRT_RELEASE=MT
   -DLLVM_USE_CRT_DEBUG=MTd
   )
ExternalProject_Add(external_clang
  URL ${CLANG_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${CLANG_HASH}
  PATCH_COMMAND ${PATCH_CMD} -p 2 -N -R -d ${CMAKE_CURRENT_BINARY_DIR}/build/clang/src/external_clang < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/clang.diff 
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/clang
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/llvm ${DEFAULT_CMAKE_FLAGS} ${CLANG_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/llvm
)
add_dependencies(external_clang ll)
set(CUEW_EXTRA_ARGS )

ExternalProject_Add(external_cuew
  URL ${CUEW_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${CUEW_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/cuew
  PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/cuew/src/external_cuew < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/cuew.diff 
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/cuew -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${CUEW_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/cuew
)

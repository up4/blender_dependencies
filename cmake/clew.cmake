set(CLEW_EXTRA_ARGS )

ExternalProject_Add(external_clew
  URL ${CLEW_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${CLEW_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/clew
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/clew -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${CLEW_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/clew
)

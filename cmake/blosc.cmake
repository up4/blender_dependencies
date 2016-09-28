set(BLOSC_EXTRA_ARGS -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
                     -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
                     -DBUILD_TESTS=OFF
                     -DBUILD_BENCHMARKS=OFF 
                     -DCMAKE_DEBUG_POSTFIX=_d 
)

ExternalProject_Add(external_blosc
  URL ${BLOSC_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${BLOSC_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/blosc
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/blosc ${DEFAULT_CMAKE_FLAGS} ${BLOSC_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/blosc
)
add_dependencies(external_blosc external_zlib)

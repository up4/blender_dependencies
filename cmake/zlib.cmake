ExternalProject_Add(external_zlib
  URL ${ZLIB_URI}
  URL_HASH MD5=${ZLIB_HASH}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/zlib
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/zlib ${DEFAULT_CMAKE_FLAGS}
  INSTALL_DIR ${LIBDIR}/zlib
)

if (BUILD_MODE STREQUAL Debug)
 ExternalProject_Add_Step(external_zlib after_install
 COMMAND ${CMAKE_COMMAND} -E copy ${LIBDIR}/zlib/lib/zlibstaticd${LIBEXT} ${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
 DEPENDEES install
 )
endif (BUILD_MODE STREQUAL Debug)

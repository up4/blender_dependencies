set(FREETYPE_EXTRA_ARGS -DCMAKE_RELEASE_POSTFIX:STRING=2ST -DCMAKE_DEBUG_POSTFIX:STRING=2ST_d )

ExternalProject_Add(external_freetype
  URL ${FREETYPE_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${FREETYPE_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/freetype
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/freetype ${DEFAULT_CMAKE_FLAGS} ${FREETYPE_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/freetype
)

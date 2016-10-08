ExternalProject_Add(external_flac
  URL ${FLAC_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${FLAC_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/flac
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/flac/src/external_flac/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/flac --disable-shared --enable-static 
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/flac/src/external_flac/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/flac/src/external_flac/ && make install
  INSTALL_DIR ${LIBDIR}/flac
)  

if (MSVC)
set_target_properties(external_flac PROPERTIES FOLDER Mingw)
endif (MSVC)

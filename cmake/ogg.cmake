ExternalProject_Add(external_ogg
  URL ${OGG_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${OGG_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/ogg
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/ogg/src/external_ogg/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/ogg --disable-shared --enable-static 
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/ogg/src/external_ogg/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/ogg/src/external_ogg/ && make install
  INSTALL_DIR ${LIBDIR}/ogg
)  

if (MSVC)
set_target_properties(external_ogg PROPERTIES FOLDER Mingw)
endif (MSVC)

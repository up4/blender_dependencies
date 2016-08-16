ExternalProject_Add(external_orc
  URL ${ORC_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${ORC_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/orc
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/orc/src/external_orc/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/orc --disable-shared --enable-static 
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/orc/src/external_orc/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/orc/src/external_orc/ && make install
  INSTALL_DIR ${LIBDIR}/orc
)
if (MSVC)
set_target_properties(external_orc PROPERTIES FOLDER Mingw)
endif (MSVC)

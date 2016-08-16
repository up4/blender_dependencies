set(SNDFILE_EXTRA_ARGS 
   )

ExternalProject_Add(external_sndfile
  URL ${SNDFILE_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${SNDFILE_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/sndfile
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/sndfile/src/external_sndfile/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --enable-static --prefix=${mingw_LIBDIR}/sndfile
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/sndfile/src/external_sndfile/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/sndfile/src/external_sndfile/ && make install
  INSTALL_DIR ${LIBDIR}/sndfile
)
if (MSVC)
set_target_properties(external_sndfile PROPERTIES FOLDER Mingw)
endif (MSVC)

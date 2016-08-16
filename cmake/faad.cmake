set(FAAD_EXTRA_ARGS  )
ExternalProject_Add(external_faad
  URL ${FAAD_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${FAAD_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/faad
  PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/faad/src/external_faad < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/libfaad.diff 
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/faad/src/external_faad/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --disable-shared --enable-static --prefix=${LIBDIR}/faad
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/faad/src/external_faad/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/faad/src/external_faad/ && make install
  INSTALL_DIR ${LIBDIR}/faad
)
if (MSVC)
set_target_properties(external_faad PROPERTIES FOLDER Mingw)
endif (MSVC)

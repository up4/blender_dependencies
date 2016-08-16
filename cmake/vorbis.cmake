ExternalProject_Add(external_vorbis
  URL ${VORBIS_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${VORBIS_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/vorbis
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/vorbis/src/external_vorbis/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/vorbis --disable-shared --enable-static 
    --with-pic 
    --with-ogg=${LIBDIR}/ogg
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/vorbis/src/external_vorbis/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/vorbis/src/external_vorbis/ && make install
  INSTALL_DIR ${LIBDIR}/vorbis
)
add_dependencies(external_vorbis external_ogg)
if (MSVC)
set_target_properties(external_vorbis PROPERTIES FOLDER Mingw)
endif (MSVC)

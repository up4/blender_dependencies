ExternalProject_Add(external_theora
  URL ${THEORA_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${THEORA_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/theora
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/theora/src/external_theora/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/theora --disable-shared --enable-static 
    --with-pic 
    --with-ogg=${LIBDIR}/ogg
    --with-vorbis=${LIBDIR}/vorbis
	--disable-examples
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/theora/src/external_theora/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/theora/src/external_theora/ && make install
  INSTALL_DIR ${LIBDIR}/theora
)
add_dependencies(external_theora external_vorbis external_ogg)
if (MSVC)
set_target_properties(external_theora PROPERTIES FOLDER Mingw)
endif (MSVC)

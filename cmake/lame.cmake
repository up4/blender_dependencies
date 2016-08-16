set(LAME_EXTRA_ARGS  )
if (MSVC)
	if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "4" )
	set(LAME_EXTRA_ARGS CFLAGS=-msse )
	endif()
endif()
ExternalProject_Add(external_lame
  URL ${LAME_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${LAME_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/lame
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lame/src/external_lame/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/lame --disable-shared --enable-static ${LAME_EXTRA_ARGS}
    --enable-export=full 
    --with-fileio=sndfile 
    --without-vorbis
    --with-pic 
    --disable-mp3x 
    --disable-mp3rtp 
    --disable-gtktest 
    --enable-export=full  
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lame/src/external_lame/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lame/src/external_lame/ && make install
  INSTALL_DIR ${LIBDIR}/lame
)
if (MSVC)
set_target_properties(external_lame PROPERTIES FOLDER Mingw)
endif (MSVC)

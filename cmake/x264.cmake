if(WIN32)
	set(X264_EXTRA_ARGS -enable-win32thread --cross-prefix=${MINGW_HOST}- --host=${MINGW_HOST})
endif()

ExternalProject_Add(external_x264
  URL ${X264_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${X264_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/x264
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/x264/src/external_x264/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/x264 --enable-static --disable-lavf ${X264_EXTRA_ARGS}
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/x264/src/external_x264/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/x264/src/external_x264/ && make install
  INSTALL_DIR ${LIBDIR}/x264
)
if (MSVC)
set_target_properties(external_x264 PROPERTIES FOLDER Mingw)
endif (MSVC)

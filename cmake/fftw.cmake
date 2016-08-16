set(FFTW_EXTRA_ARGS  )

if(WIN32)
	set(FFTW3_ENV set CFLAGS=-fno-stack-check -fno-stack-protector -mno-stack-arg-probe -fno-lto &&)
	set(FFTW3_PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/fftw3/src/external_fftw3 < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/fftw3.diff)
endif()

ExternalProject_Add(external_fftw3
  URL ${FFTW_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${FFTW_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/fftw3
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && ${FFTW3_ENV} cd ${CMAKE_CURRENT_BINARY_DIR}/build/fftw3/src/external_fftw3/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --enable-static --prefix=${mingw_LIBDIR}/fftw3
  PATCH_COMMAND ${FFTW3_PATCH_COMMAND}
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/fftw3/src/external_fftw3/ && make  -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/fftw3/src/external_fftw3/ && make install
  INSTALL_DIR ${LIBDIR}/fftw3
)
if (MSVC)
set_target_properties(external_fftw3 PROPERTIES FOLDER Mingw)
endif (MSVC)

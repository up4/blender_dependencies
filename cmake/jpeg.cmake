if (WIN32)
	# cmake for windows
	set(JPEG_EXTRA_ARGS  -DWITH_JPEG8=ON  -DCMAKE_DEBUG_POSTFIX=d )
	ExternalProject_Add(external_jpeg
	  URL ${JPEG_URI}
	  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
	  URL_HASH MD5=${JPEG_HASH}
	  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/jpg
	  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/jpg ${DEFAULT_CMAKE_FLAGS} ${JPEG_EXTRA_ARGS}
	  INSTALL_DIR ${LIBDIR}/jpg
	)
	if (BUILD_MODE STREQUAL Debug)
	ExternalProject_Add_Step(external_jpeg after_install
	 COMMAND ${CMAKE_COMMAND} -E copy ${LIBDIR}/jpg/lib/jpegd${LIBEXT}  ${LIBDIR}/jpg/lib/jpeg${LIBEXT}
	 DEPENDEES install
	 )
	endif (BUILD_MODE STREQUAL Debug)
	set (JPEG_LIBRARY jpeg-static${LIBEXT})
else(WIN32)
	# autoconf for unix
	if (APPLE)
		set(JPEG_EXTRA_ARGS --host x86_64-apple-darwin --with-jpeg8)
	else()
		set(JPEG_EXTRA_ARGS --with-jpeg8)
	endif()
	ExternalProject_Add(external_jpeg
	  URL ${JPEG_URI}
	  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
	  URL_HASH MD5=${JPEG_HASH}
	  CONFIGURE_COMMAND ${CONFIGURE_ENV} && autoreconf -fiv && ./configure --prefix=${LIBDIR}/jpg NASM=yasm ${JPEG_EXTRA_ARGS}
	  BUILD_IN_SOURCE 1
	  BUILD_COMMAND ${CONFIGURE_ENV} && make install
	  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/jpg
	  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/jpg ${DEFAULT_CMAKE_FLAGS} ${JPEG_EXTRA_ARGS}
	  INSTALL_DIR ${LIBDIR}/jpg
	)
	set (JPEG_LIBRARY libjpeg${LIBEXT})
endif(WIN32)

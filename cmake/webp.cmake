if(WIN32)
	if (BUILD_MODE STREQUAL Release)
		set(WEBP_EXTRA_ARGS  
			-DWEBP_HAVE_SSE2=On
			-DWEBP_HAVE_SSE41=Off 
			-DWEBP_HAVE_AVX2=Off
		)

		ExternalProject_Add(external_webp
			URL ${WEBP_URI}
			DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
			URL_HASH MD5=${WEBP_HASH}
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/webp
			CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/webp -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${WEBP_EXTRA_ARGS}
			INSTALL_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp-build/${BUILD_MODE}/webp${LIBEXT} ${LIBDIR}/webp/lib/webp${LIBEXT} &&
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/decode.h ${LIBDIR}/webp/include/webp/decode.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/encode.h ${LIBDIR}/webp/include/webp/encode.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/demux.h ${LIBDIR}/webp/include/webp/demux.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/extras.h ${LIBDIR}/webp/include/webp/extras.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/format_constants.h ${LIBDIR}/webp/include/webp/format_constants.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/mux.h ${LIBDIR}/webp/include/webp/mux.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/mux_types.h ${LIBDIR}/webp/include/webp/mux_types.h && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/webp/src/external_webp/src/webp/types.h ${LIBDIR}/webp/include/webp/types.h
			INSTALL_DIR ${LIBDIR}/webp
		)
		
	endif (BUILD_MODE STREQUAL Release)
endif(WIN32)

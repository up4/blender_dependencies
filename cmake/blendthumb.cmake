if (BUILD_MODE STREQUAL Release)
	if (WIN32)

		ExternalProject_Add(external_zlib_32
			URL ${ZLIB_URI}
			CMAKE_GENERATOR ${GENERATOR_32}
			URL_HASH MD5=${ZLIB_HASH}
			DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/zlib32
			CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/zlib32 ${DEFAULT_CMAKE_FLAGS}
			INSTALL_DIR ${LIBDIR}/zlib32
		)

		ExternalProject_Add(external_zlib_64
			URL ${ZLIB_URI}
			CMAKE_GENERATOR ${GENERATOR_64}
			URL_HASH MD5=${ZLIB_HASH}
			DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/zlib64
			CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/zlib64 ${DEFAULT_CMAKE_FLAGS}
			INSTALL_DIR ${LIBDIR}/zlib64
		)

		ExternalProject_Add(external_blendthumb_32
			CMAKE_GENERATOR ${GENERATOR_32}
			SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Source/BlendThumb
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/BlendThumb32
			CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/blendThumb32 ${DEFAULT_CMAKE_FLAGS} -DZLIB_INCLUDE=${LIBDIR}/zlib32/include -DZLIB_LIBS=${LIBDIR}/zlib32/lib/zlibstatic.lib
			INSTALL_DIR ${LIBDIR}/BlendThumb32
		)
		add_dependencies(external_blendthumb_32 external_zlib_32)

		ExternalProject_Add(external_blendthumb_64
			CMAKE_GENERATOR ${GENERATOR_64}
			SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Source/BlendThumb
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/BlendThumb64
			CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/blendThumb64 ${DEFAULT_CMAKE_FLAGS} -DZLIB_INCLUDE=${LIBDIR}/zlib64/include -DZLIB_LIBS=${LIBDIR}/zlib64/lib/zlibstatic.lib
			INSTALL_DIR ${LIBDIR}/BlendThumb64
		)
		add_dependencies(external_blendthumb_64 external_zlib_64)
	endif(WIN32)
endif (BUILD_MODE STREQUAL Release)

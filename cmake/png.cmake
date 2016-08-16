set(PNG_EXTRA_ARGS 
 -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
 -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
 -DPNG_STATIC=ON
)

ExternalProject_Add(external_png
  URL ${PNG_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${PNG_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/png
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/png ${DEFAULT_CMAKE_FLAGS} ${PNG_EXTRA_ARGS}
  INSTALL_DIR  ${LIBDIR}/png
)

add_dependencies(external_png external_zlib)

if (BUILD_MODE STREQUAL Debug)
	ExternalProject_Add_Step(external_png after_install
	 COMMAND ${CMAKE_COMMAND} -E copy ${LIBDIR}/png/lib/libpng16_staticd${LIBEXT}  ${LIBDIR}/png/lib/libpng16${LIBEXT}
	 DEPENDEES install
	 )
endif (BUILD_MODE STREQUAL Debug)

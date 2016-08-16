set(TIFF_EXTRA_ARGS 
	 -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
	 -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include 
	 -DPNG_STATIC=ON 
	 -DBUILD_SHARED_LIBS=OFF
	 -Dlzma=OFF
   )

ExternalProject_Add(external_tiff
  URL ${TIFF_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${TIFF_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/tiff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/tiff ${DEFAULT_CMAKE_FLAGS} ${TIFF_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/tiff
)

add_dependencies(external_tiff external_zlib )
if (BUILD_MODE STREQUAL Debug)
ExternalProject_Add_Step(external_tiff after_install
 COMMAND ${CMAKE_COMMAND} -E copy ${LIBDIR}/tiff/lib/tiffd${LIBEXT}  ${LIBDIR}/tiff/lib/tiff${LIBEXT}
 DEPENDEES install
 )
endif (BUILD_MODE STREQUAL Debug)

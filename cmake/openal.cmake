if (BUILD_MODE STREQUAL Release)
set(OPENAL_EXTRA_ARGS 
	-DALSOFT_UTILS=Off
	-DALSOFT_NO_CONFIG_UTIL=On
	-DALSOFT_EXAMPLES=Off
	-DALSOFT_TESTS=Off
	-DALSOFT_CONFIG=Off
	-DALSOFT_HRTF_DEFS=Off
	-DALSOFT_INSTALL=On
)

ExternalProject_Add(external_openal
  URL ${OPENAL_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${OPENAL_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/openal
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openal ${DEFAULT_CMAKE_FLAGS} ${OPENAL_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openal
)
endif (BUILD_MODE STREQUAL Release)

if(WIN32)
	set(OPENCOLLADA_PATCH_COMMAND ${PATCH_CMD} --verbose -p 1 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/opencollada/src/external_opencollada < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/opencollada.diff)
endif()

ExternalProject_Add(external_opencollada
  URL ${OPENCOLLADA_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${OPENCOLLADA_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/opencollada
  PATCH_COMMAND ${OPENCOLLADA_PATCH_COMMAND}
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/opencollada ${DEFAULT_CMAKE_FLAGS} ${OPENCOLLADA_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/opencollada
)

if (MSVC)
if (BUILD_MODE STREQUAL Release)
set(NUMPY_POSTFIX )
message("Python_binary = ${PYTHON_BINARY}")
message("Python_post = ${PYTHON_POSTFIX}")
ExternalProject_Add(external_numpy
  URL ${NUMPY_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${NUMPY_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/numpy
  PATCH_COMMAND ${PATCH_CMD}  --verbose -p 1 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/numpy/src/external_numpy < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/numpy.diff 
  CONFIGURE_COMMAND ""
  LOG_BUILD 1
  BUILD_COMMAND ${PYTHON_BINARY} ${CMAKE_CURRENT_BINARY_DIR}/build/numpy/src/external_numpy/setup.py build
  INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir "${CMAKE_CURRENT_BINARY_DIR}/build/numpy/src/external_numpy/build/lib.${PYTHON_ARCH2}-3.5" 
                  ${CMAKE_COMMAND} -E tar "cfvz" "${LIBDIR}/python35_numpy${PYTHON_POSTFIX}_1.11.tar.gz" "."  
)
add_dependencies(external_numpy Make_Python_Environment)
endif(BUILD_MODE STREQUAL Release)
endif (MSVC)
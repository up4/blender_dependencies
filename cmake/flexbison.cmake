set(FLEXBISON_EXTRA_ARGS 
   )

ExternalProject_Add(external_flexbison
  URL ${FLEXBISON_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${FLEXBISON_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/flexbison
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/flexbison ${DEFAULT_CMAKE_FLAGS} ${FLEXBISON_EXTRA_ARGS}
  CONFIGURE_COMMAND echo .
  BUILD_COMMAND echo . 
  INSTALL_COMMAND COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/flexbison/src/external_flexbison/ ${LIBDIR}/flexbison/ 
  INSTALL_DIR ${LIBDIR}/flexbison
)

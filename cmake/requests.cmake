if (BUILD_MODE STREQUAL Release)

ExternalProject_Add(external_requests
  URL ${REQUESTS_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${REQUESTS_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/requests
  CONFIGURE_COMMAND ""
  BUILD_COMMAND "" 
  INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/requests/src/external_requests/requests ${LIBDIR}/requests
)
endif(BUILD_MODE STREQUAL Release)

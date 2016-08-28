set(GLFW_EXTRA_ARGS )

ExternalProject_Add(external_glfw
  URL ${GLFW_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${GLFW_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/glfw
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/glfw -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${GLFW_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/glfw
)
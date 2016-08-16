set(OPENJPEG_EXTRA_ARGS 
	-DBUILD_SHARED_LIBS=Off
)

if(WIN32)
	set(OPENJPEG_EXTRA_ARGS -G "MSYS Makefiles")
else()
	set(OPENJPEG_EXTRA_ARGS ${DEFAULT_CMAKE_FLAGS})
endif()

ExternalProject_Add(external_openjpeg
  URL ${OPENJPEG_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${OPENJPEG_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/openjpeg
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/openjpeg/src/external_openjpeg-build && ${CMAKE_COMMAND} ${OPENJPEG_EXTRA_ARGS} -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openjpeg -DBUILD_SHARED_LIBS=Off -DBUILD_THIRDPARTY=OFF ${CMAKE_CURRENT_BINARY_DIR}/build/openjpeg/src/external_openjpeg
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/openjpeg/src/external_openjpeg-build/ && make -j${MAKE_THREADS} 
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/openjpeg/src/external_openjpeg-build/ && make install
  INSTALL_DIR ${LIBDIR}/openjpeg
)
if (MSVC)
set_target_properties(external_openjpeg PROPERTIES FOLDER Mingw)
endif (MSVC)

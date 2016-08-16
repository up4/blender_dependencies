if(WIN32)
	if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
		set(VPX_EXTRA_FLAGS --target=x86_64-win64-gcc)
	else()
		set(VPX_EXTRA_FLAGS --target=x86-win32-gcc)
	endif()
else()
	set(VPX_EXTRA_FLAGS --target=generic-gnu)
endif()

ExternalProject_Add(external_vpx
  URL ${VPX_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${VPX_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/vpx
  CONFIGURE_COMMAND ${CONFIGURE_ENV} &&
	 cd ${CMAKE_CURRENT_BINARY_DIR}/build/vpx/src/external_vpx/ && 
	 sh ./configure --prefix=${LIBDIR}/vpx --disable-shared --enable-static
    --disable-install-bins 
    --disable-install-srcs 
    --disable-sse4_1 
    --disable-sse3 
    --disable-ssse3 
    --disable-avx 
    --disable-avx2 
    --disable-unit-tests 
    --disable-examples  
	${VPX_EXTRA_FLAGS}
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/vpx/src/external_vpx/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/vpx/src/external_vpx/ && make install
  INSTALL_DIR ${LIBDIR}/vpx
)
if (MSVC)
set_target_properties(external_vpx PROPERTIES FOLDER Mingw)
endif (MSVC)

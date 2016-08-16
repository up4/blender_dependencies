set(LAPACK_EXTRA_ARGS  
 
)

if(WIN32)
	if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
		set(LAPACK_EXTRA_ARGS -G "MSYS Makefiles" -DCMAKE_Fortran_COMPILER=${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/gfortran.exe)
	else()
		set(LAPACK_EXTRA_ARGS -G "MSYS Makefiles" -DCMAKE_Fortran_COMPILER=${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw32/bin/gfortran.exe)
	endif()
endif()

ExternalProject_Add(external_lapack
  URL ${LAPACK_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${LAPACK_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/lapack
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lapack/src/external_lapack/ && ${CMAKE_COMMAND} ${LAPACK_EXTRA_ARGS} -DBUILD_TESTING=Off -DCMAKE_INSTALL_PREFIX=${LIBDIR}/lapack . 
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lapack/src/external_lapack/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/lapack/src/external_lapack/ && make install

  INSTALL_DIR ${LIBDIR}/lapack
)
if (MSVC)
set_target_properties(external_lapack PROPERTIES FOLDER Mingw)
endif (MSVC)

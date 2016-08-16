if(WIN32)
	set(OPENEXR_CMAKE_CXX_STANDARD_LIBRARIES "kernel32${LIBEXT} user32${LIBEXT} gdi32${LIBEXT} winspool${LIBEXT} shell32${LIBEXT} ole32${LIBEXT} oleaut32${LIBEXT} uuid${LIBEXT} comdlg32${LIBEXT} advapi32${LIBEXT} psapi${LIBEXT}")
endif()
set(OPENEXR_EXTRA_ARGS 
		-DBUILD_SHARED_LIBS=OFF 
		-DCMAKE_CXX_STANDARD_LIBRARIES=${OPENEXR_CMAKE_CXX_STANDARD_LIBRARIES}
		-DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
		-DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
		-DILMBASE_PACKAGE_PREFIX=${LIBDIR}/ilmbase/
	)

ExternalProject_Add(external_openexr
	URL ${OPENEXR_URI}
	DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
	URL_HASH MD5=${OPENEXR_HASH}
	PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/openexr
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openexr ${DEFAULT_CMAKE_FLAGS} ${OPENEXR_EXTRA_ARGS}
	INSTALL_DIR ${LIBDIR}/openexr
)

add_dependencies(external_openexr external_zlib external_ilmbase)

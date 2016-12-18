set(PYTHON_POSTFIX )
if (BUILD_MODE STREQUAL Debug)
	set (PYTHON_POSTFIX _d)
endif (BUILD_MODE STREQUAL Debug)

if (WIN32)
	if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
		set(PYTHON_ARCH x64)
		set(PYTHON_ARCH2 win-AMD64)
		set(PYTHON_OUTPUTDIR ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/pcbuild/amd64/)
	else()
		set(PYTHON_ARCH x86)
		set(PYTHON_ARCH2 win32)
		set(PYTHON_OUTPUTDIR ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/pcbuild/win32/)
	endif()

	set(PYTHON_BINARY ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python${PYTHON_POSTFIX}.exe)

	macro(cmake_to_dos_path MsysPath ResultingPath)
	  string(REPLACE "/" "\\" ${ResultingPath} "${MsysPath}" )
	endmacro()

	set(PYTHON_EXTERNALS_FOLDER ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/externals )
	set(DOWNLOADS_EXTERNALS_FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/Downloads/externals )

	cmake_to_dos_path(${PYTHON_EXTERNALS_FOLDER} PYTHON_EXTERNALS_FOLDER_DOS)
	cmake_to_dos_path(${DOWNLOADS_EXTERNALS_FOLDER} DOWNLOADS_EXTERNALS_FOLDER_DOS)

	message("Python externals = ${PYTHON_EXTERNALS_FOLDER}")
	message("Python externals_dos = ${PYTHON_EXTERNALS_FOLDER_DOS}")
	message("Python DOWNLOADS_EXTERNALS_FOLDER = ${DOWNLOADS_EXTERNALS_FOLDER}")
	message("Python DOWNLOADS_EXTERNALS_FOLDER_DOS = ${DOWNLOADS_EXTERNALS_FOLDER_DOS}")

	ExternalProject_Add(external_python
	  URL ${PYTHON_URI}
	  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
	  URL_HASH MD5=${PYTHON_HASH}
	  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/python
	  PATCH_COMMAND echo mklink /D "${PYTHON_EXTERNALS_FOLDER_DOS}" "${DOWNLOADS_EXTERNALS_FOLDER_DOS}" &&
						 mklink /D "${PYTHON_EXTERNALS_FOLDER_DOS}" "${DOWNLOADS_EXTERNALS_FOLDER_DOS}" &&
						 ${PATCH_CMD}  --verbose -p 0 -d ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python < ${CMAKE_CURRENT_SOURCE_DIR}/diffs/python.diff 
	  CONFIGURE_COMMAND ""
	  BUILD_COMMAND cd ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/pcbuild/ && set IncludeTkinter=false && call build.bat -e -p ${PYTHON_ARCH} -c ${BUILD_MODE} -k ${PYTHON_COMPILER_STRING}
	  INSTALL_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${PYTHON_OUTPUTDIR}/python35${PYTHON_POSTFIX}.dll ${LIBDIR}/python/lib/python35${PYTHON_POSTFIX}.dll && 
							  ${CMAKE_COMMAND} -E copy ${PYTHON_OUTPUTDIR}/python35${PYTHON_POSTFIX}.lib ${LIBDIR}/python/lib/python35${PYTHON_POSTFIX}.lib && 
							  ${CMAKE_COMMAND} -E copy ${PYTHON_OUTPUTDIR}/python35${PYTHON_POSTFIX}.exp ${LIBDIR}/python/lib/python35${PYTHON_POSTFIX}.exp &&
							  ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/include ${LIBDIR}/python/include/Python${PYTHON_SHORT_VERSION} &&
							  ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/PC/pyconfig.h" ${LIBDIR}/python/include/Python${PYTHON_SHORT_VERSION}/pyconfig.h
	)
	Message("PythinRedist = ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist")
	Message("POutput = ${PYTHON_OUTPUTDIR}")
else()
	if(APPLE)
		# we need to manually add homebrew headers to get ssl module building
		set(PYTHON_ARCH2 macosx-${OSX_DEPLOYMENT_TARGET}-x86_64)
		set(PYTHON_EXTRA_INCLUDES "-I/usr/local/opt/openssl/include -I${OSX_SYSROOT}/usr/include")
		set(PYTHON_EXTRA_LIBS "-L/usr/local/opt/openssl/lib")
		set(PYTHON_CONFIGURE_ENV ${CONFIGURE_ENV} && export CFLAGS=${PYTHON_EXTRA_INCLUDES} && export LDFLAGS=${PYTHON_EXTRA_LIBS})
	else()
		set(PYTHON_ARCH2 linux)
		set(PYTHON_CONFIGURE_ENV ${CONFIGURE_ENV})
	endif()

	set(PYTHON_BINARY ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/python.exe)

	ExternalProject_Add(external_python
	  URL ${PYTHON_URI}
	  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
	  URL_HASH MD5=${PYTHON_HASH}
	  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/python
	  PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -d ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python < ${CMAKE_CURRENT_SOURCE_DIR}/diffs/python_apple.diff 
	  CONFIGURE_COMMAND ${PYTHON_CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/python
	  BUILD_COMMAND ${PYTHON_CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/ && make -j${MAKE_THREADS}
	  INSTALL_COMMAND ${PYTHON_CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/ && make install
	  INSTALL_DIR ${LIBDIR}/python)

	add_custom_command(  
		OUTPUT ${LIBDIR}/python/release/python_x86_64.zip
		WORKING_DIRECTORY ${LIBDIR}/python
		COMMAND mkdir -p release
		COMMAND zip -r release/python_x86_64.zip lib/python${PYTHON_SHORT_VERSION} lib/pkgconfig --exclude *__pycache__*)
	add_custom_target(Package_Python ALL DEPENDS external_python ${LIBDIR}/python/release/python_x86_64.zip)
	add_custom_target( Make_Python_Environment ALL DEPENDS Package_Python) 
endif()

if (MSVC)
		 
		add_custom_command(  
			OUTPUT ${LIBDIR}/python35${PYTHON_POSTFIX}.tar.gz 
			OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/bin/python${PYTHON_POSTFIX}.exe
			COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/lib ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib  
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/python${PYTHON_POSTFIX}.exe" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/bin/python${PYTHON_POSTFIX}.exe   
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_bz2${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_bz2${PYTHON_POSTFIX}.pyd
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_hashlib${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_hashlib${PYTHON_POSTFIX}.pyd
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_lzma${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_lzma${PYTHON_POSTFIX}.pyd
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_sqlite3${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_sqlite3${PYTHON_POSTFIX}.pyd
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_ssl${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_ssl${PYTHON_POSTFIX}.pyd
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/pyexpat${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/pyexpat${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/select${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/select${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/unicodedata${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/unicodedata${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/winsound${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/winsound${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_ctypes${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_ctypes${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_ctypes_test${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_ctypes_test${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_decimal${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_decimal${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_elementtree${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_elementtree${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_msi${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_msi${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_multiprocessing${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_multiprocessing${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_overlapped${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_overlapped${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_socket${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_socket${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_testbuffer${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_testbuffer${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_testcapi${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_testcapi${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_testimportmultiple${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_testimportmultiple${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/_testmultiphase${PYTHON_POSTFIX}.pyd" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/lib/_testmultiphase${PYTHON_POSTFIX}.pyd 
			COMMAND ${CMAKE_COMMAND} -E chdir "${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist" ${CMAKE_COMMAND} -E tar "cfvz" "${LIBDIR}/python35${PYTHON_POSTFIX}.tar.gz" "." 
		)
		add_custom_target(Package_Python ALL DEPENDS external_python ${LIBDIR}/python35${PYTHON_POSTFIX}.tar.gz ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist/bin/python${PYTHON_POSTFIX}.exe)

		if (MSVC12)
			set(PYTHON_DISTUTIL_PATCH ${PATCH_CMD}  --verbose -p 0 -d ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/lib/distutils < ${CMAKE_CURRENT_SOURCE_DIR}/diffs/python_runtime_vc2013.diff )
		else()
			set(PYTHON_DISTUTIL_PATCH echo "No patch needed")
		endif()

		add_custom_command( OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python${PYTHON_POSTFIX}.exe 
							COMMAND	${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/redist ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run  
							COMMAND	${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/include ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/include  
							COMMAND	${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/python35${PYTHON_POSTFIX}.dll" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python35${PYTHON_POSTFIX}.dll  
							COMMAND	${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/python35${PYTHON_POSTFIX}.lib" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/libs/python35.lib  #missing postfix on purpose, distutils is not expecting it
							COMMAND	${CMAKE_COMMAND} -E copy "${PYTHON_OUTPUTDIR}/python${PYTHON_POSTFIX}.exe" ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python${PYTHON_POSTFIX}.exe   
							COMMAND	${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python${PYTHON_POSTFIX}.exe -m ensurepip --upgrade
							COMMAND	${PYTHON_DISTUTIL_PATCH} 
						  )
		add_custom_target( Make_Python_Environment ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/build/python/src/external_python/run/python${PYTHON_POSTFIX}.exe Package_Python) 
endif (MSVC)

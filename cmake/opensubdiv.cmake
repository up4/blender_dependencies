set(OPENSUBDIV_EXTRA_ARGS  
    -DNO_EXAMPLES=ON 
    -DNO_REGRESSION=ON 
    -DNO_PYTHON=ON 
    -DNO_MAYA=ON 
    -DNO_PTEX=ON 
    -DNO_DOC=ON 
    -DNO_CLEW=OFF
    -DNO_OPENCL=OFF
    -DNO_TUTORIALS=ON 
	-DGLEW_INCLUDE_DIR=${LIBDIR}/glew/include
	-DGLEW_LIBRARY=${LIBDIR}/glew/lib/libglew${LIBEXT}
	-DGLFW_INCLUDE_DIR=${LIBDIR}/glfw/include
	-DGLFW_LIBRARIES=${LIBDIR}/glfw/lib/glfw3${LIBEXT}
)

if(WIN32)
	#no cuda support for vc15 yet
	if (msvc15)
		set(OPENSUBDIV_CUDA On)
	else()
		set(OPENSUBDIV_CUDA On)
	endif()

	set(OPENSUBDIV_EXTRA_ARGS
		${OPENSUBDIV_EXTRA_ARGS}
    	-DNO_CUDA=${OPENSUBDIV_CUDA}
		-DCLEW_INCLUDE_DIR=${LIBDIR}/clew/include/cl
		-DCLEW_LIBRARY=${LIBDIR}/clew/lib/clew${LIBEXT}
		-DCUEW_INCLUDE_DIR=${LIBDIR}/cuew/include
		-DCUEW_LIBRARY=${LIBDIR}/cuew/lib/cuew${LIBEXT}
		-DCMAKE_EXE_LINKER_FLAGS_RELEASE=libcmt.lib)
else()
	set(OPENSUBDIV_EXTRA_ARGS
		${OPENSUBDIV_EXTRA_ARGS}
    	-DNO_CUDA=ON
    	-DCUEW_INCLUDE_DIR=${LIBDIR}/cuew/include
    	-DCLEW_LIBRARY=${LIBDIR}/clew/lib/static/${LIBPREFIX}clew${LIBEXT})
endif()

ExternalProject_Add(external_opensubdiv
  URL ${OPENSUBDIV_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${OPENSUBDIV_Hash}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/opensubdiv
  PATCH_COMMAND ${PATCH_CMD} --verbose -p 1 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/opensubdiv/src/external_opensubdiv < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/opensubdiv.diff 
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/opensubdiv -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${OPENSUBDIV_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/opensubdiv
)

add_dependencies(external_opensubdiv external_glew external_glfw external_clew external_cuew)

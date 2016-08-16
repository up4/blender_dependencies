set(TBB_EXTRA_ARGS 
	-DTBB_BUILD_SHARED=Off
	-DTBB_BUILD_TBBMALLOC=Off
	-DTBB_BUILD_TBBMALLOC_PROXY=Off
	-DTBB_BUILD_STATIC=On
   )

#Cmake script for tbb from https://github.com/wjakob/tbb/blob/master/CMakeLists.txt
ExternalProject_Add(external_tbb
  URL ${TBB_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${TBB_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/tbb
  PATCH_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/cmakelists_tbb.txt  ${CMAKE_CURRENT_BINARY_DIR}/build/tbb/src/external_tbb/cmakelists.txt &&  
						${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/tbb/src/external_tbb/build/vs2010/version_string.ver ${CMAKE_CURRENT_BINARY_DIR}/build/tbb/src/external_tbb/src/tbb/version_string.ver
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/tbb ${DEFAULT_CMAKE_FLAGS} ${TBB_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/tbb
)

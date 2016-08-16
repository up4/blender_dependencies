set(OPENVDB_EXTRA_ARGS 
	-DOPENEXR_HOME=${LIBDIR}/openexr/
	-DILMBASE_INCLUDE_DIR=${LIBDIR}/ilmbase/include/
    -DILMBASE_HALF_LIBRARIES=${LIBDIR}/ilmbase/lib/Half${LIBEXT} 
    -DILMBASE_IMATH_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}Imath-2_2${LIBEXT} 
    -DILMBASE_ILMTHREAD_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}IlmThread-2_2${LIBEXT} 
    -DILMBASE_IEX_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}Iex-2_2${LIBEXT} 
	-DOPENEXR_INCLUDE_DIR=${LIBDIR}/openexr/include/ 
	-DOPENEXR_ILMIMF_LIBRARIES=${LIBDIR}/openexr/lib/${LIBPREFIX}IlmImf-2_2${LIBEXT} 
	-DTBB_ROOT_DIR=${LIBDIR}/tbb/
	-DTBB_LIBRARY=${LIBDIR}/tbb/lib/tbb_static${LIBEXT}
	-DBoost_COMPILER:STRING=${BOOST_COMPILER_STRING}
	-DBoost_USE_MULTITHREADED=ON 
	-DBoost_USE_STATIC_LIBS=ON 
	-DBoost_USE_STATIC_RUNTIME=ON 
	-DBOOST_ROOT=${LIBDIR}/boost 
    -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
	-DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
)

if(WIN32)
	set(OPENVDB_EXTRA_ARGS ${OPENVDB_EXTRA_ARGS} -DCMAKE_CXX_FLAGS_DEBUG="/bigobj ${BLENDER_CMAKE_CXX_FLAGS_DEBUG}")
endif()

#cmake script for openvdb based on https://raw.githubusercontent.com/diekev/openvdb-cmake/master/CMakeLists.txt
#can't be in external_openvdb because of how the includes are setup. 


ExternalProject_Add(openvdb
  URL ${OPENVDB_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${OPENVDB_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/openvdb
  PATCH_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/cmakelists_openvdb.txt  ${CMAKE_CURRENT_BINARY_DIR}/build/openvdb/src/openvdb/cmakelists.txt &&
                        ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/cmake/  ${CMAKE_CURRENT_BINARY_DIR}/build/openvdb/src/openvdb/cmake/ &&
                        ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/openvdb/src/openvdb < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/openvdb_vc2013.diff 
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openvdb ${DEFAULT_CMAKE_FLAGS} ${OPENVDB_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openvdb
)

add_dependencies(openvdb external_tbb external_boost external_ilmbase external_openexr external_zlib)

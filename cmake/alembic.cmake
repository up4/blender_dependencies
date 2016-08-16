if (ALEMBIC_HDF5)
	set(ALEMBIC_HDF5_HL )
	#
	#in debug mode we do not build HDF5_hdf5_hl_LIBRARY which makes cmake really unhappy, stub it with the debug mode lib
	#it's not linking it in at this point in time anyhow 
	#
	if (BUILD_MODE STREQUAL Debug)
		set(ALEMBIC_HDF5_HL -DHDF5_hdf5_hl_LIBRARY=${LIBDIR}/hdf5/lib/libhdf5_hl_D.${LIBEXT} )
	endif (BUILD_MODE STREQUAL Debug)
endif()

set(ALEMBIC_EXTRA_ARGS  
 -DBUILDSTATIC=ON 
 -DLINKSTATIC=ON 
 -DALEMBIC_LIB_USES_BOOST=ON 
 -DBoost_COMPILER:STRING=${BOOST_COMPILER_STRING}
 -DBoost_USE_MULTITHREADED=ON 
 -DUSE_STATIC_BOOST=On
 -DBoost_USE_STATIC_LIBS=ON 
 -DBoost_USE_STATIC_RUNTIME=ON 
 -DBoost_DEBUG=ON
 -DBOOST_ROOT=${LIBDIR}/boost 
 -DILMBASE_ROOT=${LIBDIR}/ilmbase 
 -DALEMBIC_ILMBASE_INCLUDE_DIRECTORY=${LIBDIR}/ilmbase/include/OpenEXR 
 -DALEMBIC_ILMBASE_HALF_LIB=${LIBDIR}/ilmbase/lib/Half${LIBEXT} 
 -DALEMBIC_ILMBASE_IMATH_LIB=${LIBDIR}/ilmbase/lib/Imath-2_2${LIBEXT} 
 -DALEMBIC_ILMBASE_ILMTHREAD_LIB=${LIBDIR}/ilmbase/lib/IlmThread-2_2${LIBEXT} 
 -DALEMBIC_ILMBASE_IEX_LIB=${LIBDIR}/ilmbase/lib/Iex-2_2${LIBEXT} 
 -DUSE_PYILMBASE=0 
 -DUSE_PYALEMBIC=0
 -DUSE_ARNOLD=0 
 -DUSE_MAYA=0
 -DUSE_PRMAN=0
 -DUSE_HDF5=Off
 -DUSE_STATIC_HDF5=Off
 -DHDF5_ROOT=${LIBDIR}/hdf5
 -DUSE_TESTS=Off
 -DALEMBIC_NO_OPENGL=1 
 -DUSE_BINARIES=Off
 -DALEMBIC_ILMBASE_LINK_STATIC=On
 -DALEMBIC_SHARED_LIBS=OFF 
 -DGLUT_INCLUDE_DIR="" 
 -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
 -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
 ${ALEMBIC_HDF5_HL}
 )

ExternalProject_Add(external_alembic
  URL ${ALEMBIC_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${ALEMBIC_MD5}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/alembic
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/alembic -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${ALEMBIC_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/alembic
)

add_dependencies(external_alembic external_boost external_zlib external_ilmbase )

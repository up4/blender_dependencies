set(OPENIMAGEIO_EXTRA_ARGS 
	-DBUILDSTATIC=ON 
	-DLINKSTATIC=ON 
	-DOPENEXR_INCLUDE_DIR=${LIBDIR}/openexr/include/openexr/ 
	-DOPENEXR_ILMIMF_LIBRARIES=${LIBDIR}/openexr/lib/IlmImf-2_2${LIBEXT}
	-DBoost_COMPILER:STRING=${BOOST_COMPILER_STRING}
	-DBoost_USE_MULTITHREADED=ON 
	-DBoost_USE_STATIC_LIBS=ON 
	-DBoost_USE_STATIC_RUNTIME=ON 
	-DBOOST_ROOT=${LIBDIR}/boost 
	-DBOOST_LIBRARYDIR=${LIBDIR}/boost/lib/
	-OIIO_BUILD_CPP11=ON 
	-DUSE_OPENGL=OFF 
	-DUSE_TBB=OFF 
	-DUSE_FIELD3D=OFF 
	-DUSE_QT=OFF 
	-DUSE_PYTHON=OFF 
	-DUSE_GIF=OFF
	-DOIIO_BUILD_TOOLS=OFF 
	-DOIIO_BUILD_TESTS=OFF 
	-DBUILD_TESTING=OFF 
	-DZLIB_LIBRARY=${LIBDIR}/zlib/lib/${ZLIB_LIBRARY}
	-DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include 
	-DPNG_LIBRARY=${LIBDIR}/png/lib/libpng${LIBEXT} 
	-DPNG_PNG_INCLUDE_DIR=${LIBDIR}/png/include 
	-DTIFF_LIBRARY=${LIBDIR}/tiff/lib/tiff${LIBEXT} 
	-DTIFF_INCLUDE_DIR=${LIBDIR}/tiff/include 
	-DJPEG_LIBRARY=${LIBDIR}/jpg/lib/${JPEG_LIBRARY}
	-DJPEG_INCLUDE_DIR=${LIBDIR}/jpg/include
	-DOCIO_PATH=${LIBDIR}/opencolorio/
	-DOPENEXR_HOME=${LIBDIR}/openexr/
	-DILMBASE_PACKAGE_PREFIX=${LIBDIR}/ilmbase/
	-DILMBASE_INCLUDE_DIR=${LIBDIR}/ilmbase/include/ 
	-DILMBASE_HALF_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}Half${LIBEXT} 
	-DILMBASE_IMATH_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}Imath-2_2${LIBEXT} 
	-DILMBASE_ILMTHREAD_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}IlmThread-2_2${LIBEXT} 
	-DILMBASE_IEX_LIBRARIES=${LIBDIR}/ilmbase/lib/${LIBPREFIX}Iex-2_2${LIBEXT} 
	-DOPENEXR_INCLUDE_DIR=${LIBDIR}/openexr/include/ 
	-DOPENEXR_ILMIMF_LIBRARIES=${LIBDIR}/openexr/lib/${LIBPREFIX}IlmImf-2_2${LIBEXT} 
	-DSTOP_ON_WARNING=OFF
	-DWEBP_INCLUDE_DIR=${LIBDIR}/webp/include
	-DWEBP_LIBRARY=${LIBDIR}/webp/webp${LIBEXT} 
)

ExternalProject_Add(external_openimageio
  URL ${OPENIMAGEIO_URI}	
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${OPENIMAGEIO_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/openimageio
  PATCH_COMMAND ${PATCH_CMD} -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/openimageio/src/external_openimageio/src/include < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/OpenImageIO_GDI.diff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openimageio ${DEFAULT_CMAKE_FLAGS} ${OPENIMAGEIO_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openimageio
)
add_dependencies(external_openimageio external_png external_zlib external_ilmbase external_openexr external_jpeg external_boost external_tiff external_webp )

set(ICONV_EXTRA_ARGS  
 
)

ExternalProject_Add(external_iconv
  URL ${ICONV_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${ICONV_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/iconv
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/iconv/src/external_iconv/ && sh ./configure ${CONFIGURE_BUILD_TARGET} --enable-static --prefix=${mingw_LIBDIR}/iconv
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/iconv/src/external_iconv/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/iconv/src/external_iconv/ && make install
  INSTALL_DIR ${LIBDIR}/iconv
)
if (MSVC)
set_target_properties(external_iconv PROPERTIES FOLDER Mingw)
endif (MSVC)

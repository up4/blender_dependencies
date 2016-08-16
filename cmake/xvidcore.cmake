if(WIN32)
	set(XVIDCORE_EXTRA_ARGS --host=${MINGW_HOST})
endif()

ExternalProject_Add(external_xvidcore
  URL ${XVIDCORE_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${XVIDCORE_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/xvidcore
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/xvidcore/src/external_xvidcore/build/generic && sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/xvidcore ${XVIDCORE_EXTRA_ARGS}
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/xvidcore/src/external_xvidcore/build/generic && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/xvidcore/src/external_xvidcore/build/generic && make install
  INSTALL_DIR ${LIBDIR}/xvidcore
)
 ExternalProject_Add_Step(external_xvidcore after_install
 COMMAND ${CMAKE_COMMAND} -E rename ${LIBDIR}/xvidcore/lib/xvidcore.a  ${LIBDIR}/xvidcore/lib/libxvidcore.a
 COMMAND ${CMAKE_COMMAND} -E remove ${LIBDIR}/xvidcore/lib/xvidcore.dll.a
 DEPENDEES install
  )
if (MSVC)
set_target_properties(external_xvidcore PROPERTIES FOLDER Mingw)
endif (MSVC)

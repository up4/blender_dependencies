if(WIN32)
	set(SCHROEDINGER_EXTRA_FLAGS "CFLAGS=-g -I./ -I${LIBDIR}/orc/include/orc-0.4" "LDFLAGS=-Wl,--as-needed -static-libgcc -L${LIBDIR}/orc/lib" ORC_CFLAGS=-I${LIBDIR}/orc/include/orc-0.4 ORC_LDFLAGS=-L${LIBDIR}/orc/lib ORC_LIBS=${LIBDIR}/orc/lib/liborc-0.4.a ORCC=${LIBDIR}/orc/bin/orcc.exe)
else()
	set(SCHROEDINGER_CFLAGS "${PLATFORM_CFLAGS} -I./ -I${LIBDIR}/orc/include/orc-0.4")
	set(SCHROEDINGER_LDFLAGS "${PLATFORM_LDFLAGS} -L${LIBDIR}/orc/lib")
	set(SCHROEDINGER_EXTRA_FLAGS CFLAGS=${SCHROEDINGER_CFLAGS} LDFLAGS=${SCHROEDINGER_LDFLAGS} ORC_CFLAGS=-I${LIBDIR}/orc/include/orc-0.4 ORC_LDFLAGS=-L${LIBDIR}/orc/lib ORCC=${LIBDIR}/orc/bin/orcc) # ORC_LIBS=${LIBDIR}/orc/lib/liborc-0.4.a 
endif()

ExternalProject_Add(external_schroedinger
  URL ${SCHROEDINGER_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH SHA256=${SCHROEDINGER_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/schroedinger
  PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/schroedinger/src/external_schroedinger < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/schroedinger.diff  
  CONFIGURE_COMMAND ${CONFIGURE_ENV} &&
					cd ${CMAKE_CURRENT_BINARY_DIR}/build/schroedinger/src/external_schroedinger/ && 
					sh ./configure ${CONFIGURE_BUILD_TARGET} --prefix=${LIBDIR}/schroedinger --disable-shared --enable-static ${SCHROEDINGER_EXTRA_FLAGS}
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/schroedinger/src/external_schroedinger/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/schroedinger/src/external_schroedinger/ && make install
  INSTALL_DIR ${LIBDIR}/schroedinger
)
add_dependencies(external_schroedinger external_orc)

if (MSVC)
set_target_properties(external_schroedinger PROPERTIES FOLDER Mingw)
endif (MSVC)

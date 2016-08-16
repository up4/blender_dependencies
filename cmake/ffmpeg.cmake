set(FFMPEG_CFLAGS "-I${mingw_LIBDIR}/lame/include -I${mingw_LIBDIR}/openjpeg/include/ -I${mingw_LIBDIR}/ogg/include -I${mingw_LIBDIR}/vorbis/include -I${mingw_LIBDIR}/theora/include -I${mingw_LIBDIR}/vpx/include -I${mingw_LIBDIR}/x264/include -I${mingw_LIBDIR}/xvidcore/include -I${mingw_LIBDIR}/dirac/include/dirac -I${mingw_LIBDIR}/schroedinger/include/schroedinger-1.0 -I${mingw_LIBDIR}/zlib/include")
set(FFMPEG_LDFLAGS "-L${mingw_LIBDIR}/lame/lib -L${mingw_LIBDIR}/openjpeg/lib -L${mingw_LIBDIR}/ogg/lib -L${mingw_LIBDIR}/vorbis/lib -L${mingw_LIBDIR}/theora/lib -L${mingw_LIBDIR}/vpx/lib -L${mingw_LIBDIR}/x264/lib -L${mingw_LIBDIR}/xvidcore/lib -L${mingw_LIBDIR}/dirac/lib -L${mingw_LIBDIR}/schroedinger/lib -L${mingw_LIBDIR}/orc/lib -L${mingw_LIBDIR}/zlib/lib")
set(FFMPEG_EXTRA_FLAGS --extra-cflags=${FFMPEG_CFLAGS} --extra-ldflags=${FFMPEG_LDFLAGS})
set(FFMPEG_ENV set PKG_CONFIG_PATH=${mingw_LIBDIR}/schroedinger/lib/pkgconfig:${mingw_LIBDIR}/orc/lib/pkgconfig:${mingw_LIBDIR})

if(WIN32)
	set(FFMPEG_EXTRA_FLAGS
		${FFMPEG_EXTRA_FLAGS}
		--enable-shared 
		--disable-static
		--enable-w32threads 
		--disable-pthreads
		--enable-libopenjpeg)
else()
	set(FFMPEG_EXTRA_FLAGS
		${FFMPEG_EXTRA_FLAGS}
		--enable-static
		--disable-shared
		--disable-libopenjpeg)  # TODO enable, conflicts with extern/libopenjpeg
endif()

ExternalProject_Add(external_ffmpeg
  URL ${FFMPEG_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${FFMPEG_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg
  CONFIGURE_COMMAND ${CONFIGURE_ENV} &&
		cd ${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg/src/external_ffmpeg/ && 
		${FFMPEG_ENV} && sh ./configure ${FFMPEG_EXTRA_FLAGS}
		--disable-avfilter 
		--disable-vdpau  
		--disable-bzlib 
		--disable-libgsm 
		--disable-libspeex 
		--enable-libvpx 
		--prefix=${LIBDIR}/ffmpeg 
		--enable-libschroedinger 
		--enable-libtheora 
		--enable-libvorbis 
		--enable-zlib 
		--enable-stripping 
		--enable-runtime-cpudetect 
		--disable-vaapi 
		--disable-nonfree 
		--enable-gpl 
		--disable-postproc 
		--disable-x11grab 
		--enable-libmp3lame 
		--disable-librtmp 
		--enable-libx264 
		--enable-libxvid 
		--disable-libopencore-amrnb 
		--disable-libopencore-amrwb 
		--disable-libdc1394 
		--disable-version3 
		--disable-debug 
		--enable-optimizations 
		--disable-sse 
		--disable-ssse3 
		--enable-ffplay 
		--disable-openssl
		--disable-securetransport
		--disable-indev=avfoundation
		--disable-indev=qtkit
		--disable-sdl
		--disable-gnutls
		--disable-vda
		--disable-videotoolbox
  PATCH_COMMAND ${PATCH_CMD} --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg/src/external_ffmpeg < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/ffmpeg.diff 
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg/src/external_ffmpeg/ && make -j${MAKE_THREADS}
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg/src/external_ffmpeg/ && make install
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/ffmpeg ${DEFAULT_CMAKE_FLAGS}
  INSTALL_DIR ${LIBDIR}/ffmpeg
)  

if (MSVC)
set_target_properties(external_ffmpeg PROPERTIES FOLDER Mingw)
endif (MSVC)

add_dependencies(external_ffmpeg external_faad external_openjpeg external_xvidcore external_x264 external_schroedinger external_vpx external_theora external_vorbis external_ogg external_lame)

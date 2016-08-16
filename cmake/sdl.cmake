if(WIN32)
	set(SDL_EXTRA_ARGS  
		-DSDL_STATIC=Off
	)
else()
	set(SDL_EXTRA_ARGS  
		-DSDL_STATIC=ON
		-DSDL_SHARED=OFF
		-DSDL_VIDEO=OFF
	)
endif()

ExternalProject_Add(external_sdl
  URL ${SDL_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${SDL_HASH}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/sdl
  PATCH_COMMAND ${PATCH_CMD} -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/sdl/src/external_sdl < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/sdl.diff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/sdl ${DEFAULT_CMAKE_FLAGS} ${SDL_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/sdl
)

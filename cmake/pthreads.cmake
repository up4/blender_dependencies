if(WIN32)
	if (BUILD_MODE STREQUAL Release)
		set(PTHREAD_XCFLAGS /MD )
		if (MSVC14) #vs2015 has timespec
			set(PTHREAD_CPPFLAGS "/I. /DHAVE_PTW32_CONFIG_H /D_TIMESPEC_DEFINED "  )
		else (MSVC14) #everything before doesn't 
			set(PTHREAD_CPPFLAGS "/I. /DHAVE_PTW32_CONFIG_H "  )
		endif (MSVC14)
		set(PTHREADS_BUILD cd ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/ && cd  && nmake VC /e CPPFLAGS=${PTHREAD_CPPFLAGS}  /e XCFLAGS=${PTHREAD_XCFLAGS} /e XLIBS=/NODEFAULTLIB:msvcr )

		ExternalProject_Add(external_pthreads
			URL ${PTHREADS_URI} 
			DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
			URL_HASH SHA512=${PTHREADS_SHA512}
			PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads
			CONFIGURE_COMMAND echo .
			PATCH_COMMAND ${PATCH_CMD}  --verbose -p 0 -N -d ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads < ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/pthreads.diff 
			BUILD_COMMAND ${PTHREADS_BUILD}
			INSTALL_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/pthreadVC2.dll ${LIBDIR}/pthreads/lib/pthreadVC2.dll && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/pthreadVC2${LIBEXT} ${LIBDIR}/pthreads/lib/pthreadVC2${LIBEXT} &&        
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/pthread.h ${LIBDIR}/pthreads/inc/pthread.h             && 
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/sched.h ${LIBDIR}/pthreads/inc/sched.h               &&
															${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/build/pthreads/src/external_pthreads/semaphore.h ${LIBDIR}/pthreads/inc/semaphore.h         
			INSTALL_DIR ${LIBDIR}/pthreads
		)
	endif (BUILD_MODE STREQUAL Release)
endif(WIN32)

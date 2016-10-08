if(WIN32)
	if (MSVC12)
		set(BOOST_TOOLSET toolset=msvc-12.0)
		set(BOOST_COMPILER_STRING -vc120)
		set(PYTHON_COMPILER_STRING v120)
	endif()
	if (MSVC14)
		set(BOOST_TOOLSET toolset=msvc-14.0)
		set(BOOST_COMPILER_STRING -vc140)
		set(PYTHON_COMPILER_STRING v140)
	endif()
	set(BOOST_CONFIGURE_COMMAND bootstrap.bat)
	set(BOOST_BUILD_COMMAND bjam)
	set(BOOST_BUILD_OPTIONS)
else()
	set(BOOST_CONFIGURE_COMMAND ./bootstrap.sh)
	set(BOOST_BUILD_COMMAND ./bjam)
	set(BOOST_BUILD_OPTIONS toolset=clang cxxflags=${PLATFORM_CXXFLAGS} linkflags=${PLATFORM_LDFLAGS})
endif()

set(BOOST_OPTIONS --with-filesystem
					--with-locale
					--with-thread
					--with-regex
					--with-system
					--with-date_time
					--with-wave
					--with-atomic
					--with-serialization
					--with-program_options
					--with-iostreams
					--with-python
					${BOOST_TOOLSET})
string(TOLOWER ${BUILD_MODE} BOOST_BUILD_TYPE)

if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
	set(BOOST_ADDRESS_MODEL 64)
else()
	set(BOOST_ADDRESS_MODEL 32)
endif()

ExternalProject_Add(external_boost
  URL ${BOOST_URI}
  DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Downloads
  URL_HASH MD5=${BOOST_MD5}
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/build/boost
  UPDATE_COMMAND  ""
  CONFIGURE_COMMAND ${BOOST_CONFIGURE_COMMAND}
  BUILD_COMMAND ${BOOST_BUILD_COMMAND} ${BOOST_BUILD_OPTIONS} -j${MAKE_THREADS} architecture=x86 address-model=${BOOST_ADDRESS_MODEL} variant=${BOOST_BUILD_TYPE} link=static runtime-link=static threading=multi ${BOOST_OPTIONS}  --prefix=${LIBDIR}/boost install
  BUILD_IN_SOURCE 1
  INSTALL_COMMAND ""
)

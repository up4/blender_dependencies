project("Blender External Dependencies")
cmake_minimum_required(VERSION 3.5)
####################################################################################################
#
# WINDOWS USAGE:
#   Don't call this cmake file your self, use the build_deps batch file
#   build_deps 2013 x64 / build_deps 2013 x86
#   build_deps 2015 x64 / build_deps 2015 x86
#
#   Note this currently only builds 64 bit versions of the dependencies, 32 bit is not supported or tested
#
# MAC OS X USAGE:
#	Install autotools, yasm, openssl and xz, for example with homebrew:
#		brew install autoconf automake libtool yasm openssl xz
#	Build with cmake as usual
#
####################################################################################################

include(ExternalProject)
include(cmake/Options.cmake)
include(cmake/Versions.cmake)
include(cmake/zlib.cmake)
include(cmake/blendthumb.cmake)
include(cmake/openal.cmake)
include(cmake/png.cmake)
include(cmake/jpeg.cmake)
include(cmake/boost.cmake)
include(cmake/blosc.cmake)
include(cmake/pthreads.cmake)
include(cmake/ilmbase.cmake)
include(cmake/openexr.cmake)
include(cmake/freetype.cmake)
include(cmake/freeglut.cmake)
include(cmake/glew.cmake)
include(cmake/hdf5.cmake)
include(cmake/alembic.cmake)
include(cmake/glfw.cmake)
include(cmake/clew.cmake)
include(cmake/cuew.cmake)
include(cmake/opensubdiv.cmake)
include(cmake/sdl.cmake)
include(cmake/opencollada.cmake)
include(cmake/opencolorio.cmake)
include(cmake/llvm.cmake)
include(cmake/clang.cmake)
include(cmake/openimageio.cmake)
include(cmake/tiff.cmake)
include(cmake/flexbison.cmake)
include(cmake/osl.cmake)
include(cmake/tbb.cmake)
include(cmake/openvdb.cmake)
include(cmake/python.cmake)
include(cmake/requests.cmake)
include(cmake/numpy.cmake)

if (ENABLE_MINGW64)
	if ( "${CMAKE_SIZEOF_VOID_P}" EQUAL "8" )
		include(cmake/setup_mingw64.cmake)
	else()
		include(cmake/setup_mingw32.cmake)
	endif()
else(ENABLE_MINGW64)
set(mingw_LIBDIR ${LIBDIR})
endif (ENABLE_MINGW64)

if (NOT WIN32 OR ENABLE_MINGW64)
	if (BUILD_MODE STREQUAL Release)
		include(cmake/lame.cmake)
		include(cmake/ogg.cmake)
		include(cmake/vorbis.cmake)
		include(cmake/theora.cmake)
		include(cmake/vpx.cmake)
		include(cmake/orc.cmake)
		include(cmake/schroedinger.cmake)
		include(cmake/x264.cmake)
		include(cmake/xvidcore.cmake)
		include(cmake/openjpeg.cmake)
		include(cmake/faad.cmake)
		include(cmake/ffmpeg.cmake)
		include(cmake/fftw.cmake)
		include(cmake/iconv.cmake)
		include(cmake/lapack.cmake)
		include(cmake/sndfile.cmake)
	endif(BUILD_MODE STREQUAL Release)
endif(NOT WIN32 OR ENABLE_MINGW64)

include(cmake/harvest.cmake)
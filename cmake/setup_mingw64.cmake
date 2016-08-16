####################################################################################################################
# Mingw64 Builds
####################################################################################################################
# This installs mingw64+msys to compile ffmpeg/iconv/libsndfile/lapack/fftw3
####################################################################################################################

message("LIBDIR = ${LIBDIR}")
macro(cmake_to_msys_path MsysPath ResultingPath)
  string(REPLACE ":" "" TmpPath "${MsysPath}" )
  string(SUBSTRING ${TmpPath} 0 1 Drive)
  string(SUBSTRING ${TmpPath} 1 255 PathPart)
  string(TOLOWER ${Drive} LowerDrive)
  string(CONCAT ${ResultingPath} "/" ${LowerDrive} ${PathPart} )
endmacro()
cmake_to_msys_path(${LIBDIR} mingw_LIBDIR)
message("mingw_LIBDIR = ${mingw_LIBDIR}")
Message("Checking for mingw64")
#download ming64
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/x86_64-w64-mingw32-gcc-4.8.0-win64_rubenvb.7z")
	Message("Downloading mingw64")
	file(DOWNLOAD "http://heanet.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/rubenvb/gcc-4.8-release/x86_64-w64-mingw32-gcc-4.8.0-win64_rubenvb.7z" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/x86_64-w64-mingw32-gcc-4.8.0-win64_rubenvb.7z") 
endif()

#make mingw root directory
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw")
    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_SOURCE_DIR}/mingw
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endif()

#extract mingw64
if ( (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/mingw64env.cmd") AND (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/x86_64-w64-mingw32-gcc-4.8.0-win64_rubenvb.7z") )
	Message("Extracting mingw64")
    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf ${CMAKE_CURRENT_SOURCE_DIR}/Downloads/x86_64-w64-mingw32-gcc-4.8.0-win64_rubenvb.7z
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/mingw
    )
endif()

Message("Checking for pkg-config")
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/pkg-config-lite-0.28-1_bin-win32.zip")
	Message("Downloading pkg-config")
    file(DOWNLOAD "http://heanet.dl.sourceforge.net/project/pkgconfiglite/0.28-1/pkg-config-lite-0.28-1_bin-win32.zip" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/pkg-config-lite-0.28-1_bin-win32.zip")
endif()

#extract pkgconfig
if ( (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/pkg-config.exe") AND (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/pkg-config-lite-0.28-1_bin-win32.zip") )
    Message("Extracting pkg-config")
	EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/pkg-config-lite-0.28-1_bin-win32.zip"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
    )

	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/pkg-config-lite-0.28-1/bin/pkg-config.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/pkg-config.exe"
    )	

endif()

Message("Checking for nasm")
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/nasm-2.12.01-win64.zip")
	Message("Downloading nasm")
    file(DOWNLOAD "http://www.nasm.us/pub/nasm/releasebuilds/2.12.01/win64/nasm-2.12.01-win64.zip" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/nasm-2.12.01-win64.zip")
endif()

#extract nasm
if ( (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/nasm.exe") AND (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/nasm-2.12.01-win64.zip") )
    Message("Extracting nasm")
	EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/nasm-2.12.01-win64.zip"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
    )
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/nasm-2.12.01/nasm.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/nasm.exe"
    )	

endif()

Message("Checking for mingwGet")
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip")
	Message("Downloading mingw-get")
    file(DOWNLOAD "http://heanet.dl.sourceforge.net/project/mingw/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip")
endif()
 
#extract mingw_get
if ( (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/mingw-get.exe") AND (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip") )
    Message("Extracting mingw-get")
	EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/
    )
endif()

if ( (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/mingw-get.exe") AND (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/msys/1.0/bin/make.exe") )
	Message("Installing MSYS")
	EXECUTE_PROCESS(
        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/mingw-get install msys msys-patch
        WORKING_DIRECTORY  ${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/
    )
endif()

Message("Checking for CoreUtils")
#download old core_utils for pr.exe (ffmpeg needs it to build)
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/coreutils-5.97-MSYS-1.0.11-snapshot.tar.bz2")
	Message("Downloading CoreUtils 5.97")
	file(DOWNLOAD "http://heanet.dl.sourceforge.net/project/mingw/MSYS/Base/msys-core/_obsolete/coreutils-5.97-MSYS-1.0.11-2/coreutils-5.97-MSYS-1.0.11-snapshot.tar.bz2" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/coreutils-5.97-MSYS-1.0.11-snapshot.tar.bz2") 
endif()

if ( (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/coreutils-5.97-MSYS-1.0.11-snapshot.tar.bz2") AND (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/msys/1.0/bin/pr.exe") )
	Message("Installing pr from CoreUtils 5.97")
    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_SOURCE_DIR}/tmp_coreutils
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf ${CMAKE_CURRENT_SOURCE_DIR}/Downloads/coreutils-5.97-MSYS-1.0.11-snapshot.tar.bz2
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tmp_coreutils/
    )

    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/tmp_coreutils/coreutils-5.97/bin/pr.exe "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/msys/1.0/bin/pr.exe"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tmp_coreutils/
    )
endif()

if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/ming64sh.cmd") 
	Message("Installing ming64sh.cmd")
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Diffs/ming64sh.cmd  ${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/ming64sh.cmd 
    )
endif()

Message("Checking for perl")
#download perl for libvpx
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/strawberry-perl-5.22.1.3-64bit-portable.zip")
	Message("Downloading perl")
	file(DOWNLOAD "http://strawberryperl.com/download/5.22.1.3/strawberry-perl-5.22.1.3-64bit-portable.zip" "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/strawberry-perl-5.22.1.3-64bit-portable.zip") 
endif()

#make perl root directory
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/perl")
    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_SOURCE_DIR}/perl
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endif()

#extract perl
if ( (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/perl/portable.perl") AND (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Downloads/strawberry-perl-5.22.1.3-64bit-portable.zip") )
	Message("Extracting perl")
    EXECUTE_PROCESS(
        COMMAND ${CMAKE_COMMAND} -E tar jxf ${CMAKE_CURRENT_SOURCE_DIR}/Downloads/strawberry-perl-5.22.1.3-64bit-portable.zip
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/perl
    )
endif()

#get yasm for vpx
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/yasm.exe")
	Message("Downloading yasm")
	file(DOWNLOAD "http://www.tortall.net/projects/yasm/releases/yasm-1.3.0-win64.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/yasm.exe") 
endif()

Message("checking x86_64-w64-mingw32-strings.exe")
#copy strings.exe to x86_64-w64-mingw32-strings.exe for x264
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-strings.exe")
	Message("fixing x86_64-w64-mingw32-strings.exe")
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/strings.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-strings.exe"
    )	
endif()

Message("checking x86_64-w64-mingw32-ar.exe")
#copy ar.exe to x86_64-w64-mingw32-ar.exe for x264
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-ar.exe")
	Message("fixing x86_64-w64-mingw32-ar.exe")
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/ar.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-ar.exe"
    )	
endif()

Message("checking x86_64-w64-mingw32-strip.exe")
#copy strip.exe to x86_64-w64-mingw32-strip.exe for x264
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-strip.exe")
	Message("fixing x86_64-w64-mingw32-strip.exe")
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/strip.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-strip.exe"
    )	
endif()

Message("checking x86_64-w64-mingw32-ranlib.exe")
#copy ranlib.exe to x86_64-w64-mingw32-ranlib.exe for x264
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-ranlib.exe")
	Message("fixing x86_64-w64-mingw32-ranlib.exe")
	EXECUTE_PROCESS(
		COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/ranlib.exe" "${CMAKE_CURRENT_SOURCE_DIR}/mingw/mingw64/bin/x86_64-w64-mingw32-ranlib.exe"
    )	
endif()


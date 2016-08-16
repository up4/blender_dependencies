set(ZLIB_VERSION 1.2.8)    
set(ZLIB_URI http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz)
set(ZLIB_HASH 44d667c142d7cda120332623eab69f40)

set(OPENAL_VERSION 1.17.2)
set(OPENAL_URI  http://kcat.strangesoft.net/openal-releases/openal-soft-${OPENAL_VERSION}.tar.bz2)
set(OPENAL_HASH 1764e0d8fec499589b47ebc724e0913d)

set(PNG_VERSION 1.6.21)
set(PNG_URI  http://prdownloads.sourceforge.net/libpng/libpng-${PNG_VERSION}.tar.gz)
set(PNG_HASH aca36ec8e0a3b406a5912243bc243717)

set(JPEG_VERSION 1.4.2)
set(JPEG_URI https://github.com/libjpeg-turbo/libjpeg-turbo/archive/${JPEG_VERSION}.tar.gz)
set(JPEG_HASH f9804884c1c41eb7f4febb9353a2cb27)

set(BOOST_VERSION 1.60.0)
set(BOOST_VERSION_NODOTS 1_60_0)
set(BOOST_URI http://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_NODOTS}.tar.bz2/download)
set(BOOST_MD5 65a840e1a0b13a558ff19eeb2c4f0cbe)

set(BLOSC_VERSION 1.7.1)
set(BLOSC_URI https://github.com/Blosc/c-blosc/archive/v${BLOSC_VERSION}.zip)
set(BLOSC_HASH ff5cc729a5a25934ef714217218eed26)

set(PTHREADS_VERSION 2-9-1)
set(PTHREADS_URI ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz)
set(PTHREADS_SHA512 9c06e85310766834370c3dceb83faafd397da18a32411ca7645c8eb6b9495fea54ca2872f4a3e8d83cb5fdc5dea7f3f0464be5bb9af3222a6534574a184bd551 )

set(ILMBASE_VERSION 2.2.0)
set(ILMBASE_URI http://download.savannah.nongnu.org/releases/openexr/ilmbase-${ILMBASE_VERSION}.tar.gz)
set(ILMBASE_HASH b540db502c5fa42078249f43d18a4652)

set(OPENEXR_VERSION 2.2.0)
set(OPENEXR_URI http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz)
set(OPENEXR_HASH b64e931c82aa3790329c21418373db4e)

set(FREETYPE_VERSION 263)
set(FREETYPE_URI http://download.savannah.gnu.org/releases/freetype/ft${FREETYPE_VERSION}.zip)
set(FREETYPE_HASH 0db2a43301572e5c2b4a0864f237aeeb)

set(GLEW_VERSION 1.13.0)
set(GLEW_URI http://prdownloads.sourceforge.net/glew/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.tgz )
set(GLEW_HASH 7cbada3166d2aadfc4169c4283701066 ) 

set(FREEGLUT_VERSION 3.0.0)
set(FREEGLUT_URI http://pilotfiber.dl.sourceforge.net/project/freeglut/freeglut/${FREEGLUT_VERSION}/freeglut-${FREEGLUT_VERSION}.tar.gz )
set(FREEGLUT_HASH 90c3ca4dd9d51cf32276bc5344ec9754 ) 

set(HDF5_VERSION 1.8.17)
set(HDF5_URI http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-${HDF5_VERSION}.zip )
set(HDF5_HASH be2642d976b49d6cc60a32b0bd8f829a ) 

set(ALEMBIC_VERSION 1.6.0)
set(ALEMBIC_URI https://github.com/alembic/alembic/archive/${ALEMBIC_VERSION}.zip )
set(ALEMBIC_MD5 310a9d234fc7d81764a8464bd05ddcc7 ) 

## hash is for 3.1.2 
set(GLFW_GIT_UID 30306e54705c3adae9fe082c816a3be71963485c)
set(GLFW_URI https://github.com/glfw/glfw/archive/${GLFW_GIT_UID}.zip )
set(GLFW_HASH 20cacb1613da7eeb092f3ac4f6b2b3d0 )

#latest uid in git as of 2016-04-01
set(CLEW_GIT_UID 277db43f6cafe8b27c6f1055f69dc67da4aeb299)
set(CLEW_URI https://github.com/OpenCLWrangler/clew/archive/${CLEW_GIT_UID}.zip )
set(CLEW_HASH 2c699d10ed78362e71f56fae2a4c5f98 )

#latest uid in git as of 2016-04-01
set(CUEW_GIT_UID 1744972026de9cf27c8a7dc39cf39cd83d5f922f)
set(CUEW_URI https://github.com/CudaWrangler/cuew/archive/${CUEW_GIT_UID}.zip )
set(CUEW_HASH 86760d62978ebfd96cd93f5aa1abaf4a )

set(OPENSUBDIV_VERSION v3_0_5 ) 
set(OPENSUBDIV_Hash 31b9033aa11cf78b8ef8625356a3ffc9 ) 
set(OPENSUBDIV_URI https://github.com/PixarAnimationStudios/OpenSubdiv/archive/${OPENSUBDIV_VERSION}.zip )

set(SDL_VERSION 2.0.4)
set(SDL_URI https://www.libsdl.org/release/SDL2-${SDL_VERSION}.tar.gz)
set(SDL_HASH 44fc4a023349933e7f5d7a582f7b886e ) 

set(OPENCOLLADA_URI https://github.com/KhronosGroup/OpenCOLLADA/archive/3335ac164e68b2512a40914b14c74db260e6ff7d.zip)
set(OPENCOLLADA_HASH 098d7bec44e5f3ca7d0f6d60f1f2b743) 

set(OPENCOLORIO_URI https://github.com/imageworks/OpenColorIO/archive/a557a85454ee1ffa8cb66f8a96238e079c452f08.zip)
set(OPENCOLORIO_HASH c581388fb28d6acf18a18ed4399eb216 )

set(LLVM_VERSION 3.4.2)
set(LLVM_URI http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.gz)
set(LLVM_HASH a20669f75967440de949ac3b1bad439c)

set(CLANG_URI http://llvm.org/releases/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.gz)
set(CLANG_HASH 87945973b7c73038871c5f849a818588)

set(OPENIMAGEIO_VERSION 1.6.9)
set(OPENIMAGEIO_URI https://github.com/OpenImageIO/oiio/archive/Release-${OPENIMAGEIO_VERSION}.zip)
set(OPENIMAGEIO_HASH c0ec61c3e79ddc65a6239ea938ce2cda)

set(TIFF_VERSION 4.0.6)
set(TIFF_URI http://download.osgeo.org/libtiff/tiff-${TIFF_VERSION}.tar.gz)
set(TIFF_HASH d1d2e940dea0b5ad435f21f03d96dd72)

set(FLEXBISON_VERSION 2.5.5)
set(FLEXBISON_URI http://prdownloads.sourceforge.net/winflexbison//win_flex_bison-2.5.5.zip)
set(FLEXBISON_HASH d87a3938194520d904013abef3df10ce)

set(OSL_VERSION 1.7.3)
set(OSL_URI https://github.com/imageworks/OpenShadingLanguage/archive/Release-${OSL_VERSION}.zip)
set(OSL_HASH 5967245f664e43ef1ef1671f5ec32b25)

set(PYTHON_VERSION 3.5.1)
set(PYTHON_URI https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz)
set(PYTHON_HASH e9ea6f2623fffcdd871b7b19113fde80)

set(TBB_VERSION 44_20160128)
set(TBB_URI https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb${TBB_VERSION}oss_src_0.tgz )
set(TBB_HASH 9d8a4cdf43496f1b3f7c473a5248e5cc)

set(OPENVDB_VERSION 3_1_0)
set(OPENVDB_URI http://www.openvdb.org/download/openvdb_${OPENVDB_VERSION}_library.zip )
set(OPENVDB_HASH 0e25a2e183c46963899ab3f77e3533ac)

set(REQUESTS_VERSION v2.5.0)
set(REQUESTS_URI https://github.com/kennethreitz/requests/archive/${REQUESTS_VERSION}.zip)
set(REQUESTS_HASH 3dcf565844d575f1c58f2d0e0b9c659a)

set(NUMPY_VERSION v1.11.1)
set(NUMPY_URI https://github.com/numpy/numpy/archive/${NUMPY_VERSION}.zip)
set(NUMPY_HASH 6e96e023674b365d0f36fbbd01336ced)

set(LAME_VERSION 3.99.5)
set(LAME_URI http://downloads.sourceforge.net/project/lame/lame/3.99/lame-${LAME_VERSION}.tar.gz)
set(LAME_HASH 84835b313d4a8b68f5349816d33e07ce)

set(OGG_VERSION 1.3.2)
set(OGG_URI http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz)
set(OGG_HASH e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692)
 
set(VORBIS_VERSION 1.3.5)
set(VORBIS_URI http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz)
set(VORBIS_HASH 6efbcecdd3e5dfbf090341b485da9d176eb250d893e3eb378c428a2db38301ce)

set(THEORA_VERSION 1.1.1)
set(THEORA_URI http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2)
set(THEORA_HASH b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc)

set(VPX_VERSION 1.5.0)
set(VPX_URI http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-${VPX_VERSION}.tar.bz2)
set(VPX_HASH 306d67908625675f8e188d37a81fbfafdf5068b09d9aa52702b6fbe601c76797)

set(ORC_VERSION 0.4.25)
set(ORC_URI https://gstreamer.freedesktop.org/src/orc/orc-${ORC_VERSION}.tar.xz)
set(ORC_HASH c1b1d54a58f26d483f0b3881538984789fe5d5460ab8fab74a1cacbd3d1c53d1)

set(SCHROEDINGER_VERSION 1.0.11)
set(SCHROEDINGER_URI http://diracvideo.org/download/schroedinger/schroedinger-${SCHROEDINGER_VERSION}.tar.gz)
set(SCHROEDINGER_HASH 1e572a0735b92aca5746c4528f9bebd35aa0ccf8619b22fa2756137a8cc9f912)

set(X264_URI http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20160401-2245-stable.tar.bz2)
set(X264_HASH 1e9a7b835e80313aade53a9b6ff353e099de3856bf5f30a4d8dfc91281f786f5)

set(XVIDCORE_VERSION 1.3.4)
set(XVIDCORE_URI http://downloads.xvid.org/downloads/xvidcore-${XVIDCORE_VERSION}.tar.gz)
set(XVIDCORE_HASH 4e9fd62728885855bc5007fe1be58df42e5e274497591fec37249e1052ae316f)

set(OPENJPEG_VERSION 2.0)
set(OPENJPEG_URI https://github.com/uclouvain/openjpeg/archive/version.${OPENJPEG_VERSION}.tar.gz)
set(OPENJPEG_HASH 5480f801a9f88af1a456145e41f3adede1dfae425bbac66a19c7eeeba94a1249)

set(FAAD_VERSION 2-2.7)
set(FAAD_URI http://downloads.sourceforge.net/faac/faad${FAAD_VERSION}.tar.bz2)
set(FAAD_HASH 4c332fa23febc0e4648064685a3d4332)

set(FFMPEG_VERSION 3.0)
set(FFMPEG_URI http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2)
set(FFMPEG_HASH 026859cc76dddffd809cad879db07658)

set(FFTW_VERSION 3.3.4)
set(FFTW_URI http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz)
set(FFTW_HASH 2edab8c06b24feeb3b82bbb3ebf3e7b3)

set(ICONV_VERSION 1.14)
set(ICONV_URI http://ftp.gnu.org/pub/gnu/libiconv/libiconv-${ICONV_VERSION}.tar.gz)
set(ICONV_HASH e34509b1623cec449dfeb73d7ce9c6c6 ) 

set(LAPACK_VERSION 3.6.0)
set(LAPACK_URI http://www.netlib.org/lapack/lapack-${LAPACK_VERSION}.tgz)
set(LAPACK_HASH f2f6c67134e851fe189bb3ca1fbb5101 ) 


set(SNDFILE_VERSION 1.0.26)
set(SNDFILE_URI http://www.mega-nerd.com/libsndfile/files/libsndfile-${SNDFILE_VERSION}.tar.gz)
set(SNDFILE_HASH ec810a0c60c08772a8a5552704b63393)

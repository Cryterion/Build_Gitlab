# Main program
#
#!/bin/bash

if [[ $(basename $0) == main.sh ]]; then
  echo "Please use build.sh to start the build process"
  exit -1
fi

#load config
source build.conf

#destination
DEST_DIR=$SRC_DIR/../build-gcc_build_dir
if [ ! -d "${DEST_DIR}" ]; then
  mkdir $DEST_DIR
fi
cd $DEST_DIR

mkdir -p /opt/cross
sudo chown ${USER} /opt/cross
export PATH=/opt/cross/bin:$PATH

#Check and prepare directories, download required sources if needed
#Binutils
display_alert "Checking for binutils-${BIN_UTILS_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/binutils-${BIN_UTILS_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/binutils-${BIN_UTILS_VER}.tar.gz" ]; then
    display_alert "Downloading binutils-${BIN_UTILS_VER}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/binutils/binutils-${BIN_UTILS_VER}.tar.gz
  fi
  display_alert "Extracting binutils-${BIN_UTILS_VER}" "" ""
  tar -xf binutils-${BIN_UTILS_VER}.tar.gz
  rm binutils-${BIN_UTILS_VER}.tar.gz
else
  display_alert "Binutils-${BIN_UTILS_VER} sources already exist" "" "info"
fi
if [ -d "${DEST_DIR}/build-binutils" ]; then
  display_alert "Refreshing binutils build directory" "" "info"
  rm -r ${DEST_DIR}/build-binutils
fi
mkdir ${DEST_DIR}/build-binutils

#Gcc
display_alert "Checking for gcc-${GCC_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/gcc-${GCC_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/gcc-${GCC_VER}.tar.gz" ]; 
  then
    display_alert "Downloading gcc-${GCC_VERSION}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/gcc/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.gz
  fi
  display_alert "Extracting gcc-${GCC_VER}" "" ""
  tar -xf gcc-${GCC_VER}.tar.gz
  rm gcc-${GCC_VER}.tar.gz
else
  display_alert "Gcc-${GCC_VER} sources already exist" "" "info"
fi
if [ -d "${DEST_DIR}/build-gcc" ]; then
  display_alert "Refreshed gcc build directory" "" "info"
  rm -r ${DEST_DIR}/build-gcc
fi
mkdir -p ${DEST_DIR}/build-gcc

#Linux
display_alert "Checking for linux-${LINUX_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/linux-${LINUX_VER}" ];
then
  if [ ! -f "${DEST_DIR}/linux-${LINUX_VER}.tar.gz" ];
  then
    display_alert "Downloading linux-${LINUX_VER}" "" "info"
    wget -nv --show-progress https://www.kernel.org/pub/linux/kernel/v${LINUX_MVER}.x/linux-${LINUX_VER}.tar.gz
  fi
  display_alert "Extracting linux-${LINUX_VER}" "" ""
  tar -xf linux-${LINUX_VER}.tar.gz
  rm linux-${LINUX_VER}.tar.gz
else
  display_alert "Linux-${LINUX_VER} sources already exist" "" "info"
fi

#Glibc
display_alert "Check for glibc-${GLIB_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/glibc-${GLIB_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/glibc-${GLIB_VER}.tar.gz" ]; 
  then
    display_alert "Download glibc-${GLIBC_VER}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/glibc/glibc-${GLIB_VER}.tar.gz
  fi
  display_alert "Extracting glibc-${GLIBC_VER}" "" ""
  tar -xf glibc-${GLIB_VER}.tar.gz
  rm glibc-${GLIB_VER}.tar.gz
else
  display_alert "Glibc-${GLIB_VER} sources already exist" "" "info"
fi
if [ -d "${DEST_DIR}/build-glibc" ]; 
then
  display_alert "Refreshing glibc build directory" "" "info"
  rm -r ${DEST_DIR}/build-glibc
fi
mkdir ${DEST_DIR}/build-glibc

#Mpfr
display_alert "Checking for mpfr-${MPFR_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/mpfr-${MPFR_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/mpfr-${MPFR_VER}.tar.gz" ]; 
  then
    display_alert "Downloading mpfr-${MPFR_VER}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/mpfr/mpfr-${MPFR_VER}.tar.gz
  fi
  display_alert "Extracting mpfr-${MPFR_VER}" "" ""
  tar -xf mpfr-${MPFR_VER}.tar.gz
  rm mpfr-${MPFR}.tar.gz
else
  display_alert "Mpfr-${MPFR_VER} sources already exist" "" "info"
fi

#Gmp
display_alert "Checking for gmp-${GMP_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/gmp-${GMP_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/gmp-${GMP_VER}.tar.gz" ]; 
  then
    display_alert "Downloading gmp-${GMP_VER}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/gmp/gmp-${GMP_VER}.tar.xz
  fi
  display_alert "Extracting gmp-${GMP_VER}" "" ""
  tar -xf gmp-${GMP_VER}.tar.xz
  rm gmp-${GMP_VER}.tar.xz
else
  display_alert "Gmp-${GMP_VER} sources already exist" "" "info"
fi

#Mpc
display_alert "Checking for mpc-${MPC_VER} sources" "" ""
if [ ! -d "${DEST_DIR}/mpc-${MPC_VER}" ]; 
then
  if [ ! -f "${DEST_DIR}/mpc-${MPC_VER}.tar.gz" ]; 
  then
    display_alert "Downloading mpc-${MPC_VER}" "" "info"
    wget -nv --show-progress http://ftpmirror.gnu.org/mpc/mpc-${MPC_VER}.tar.gz
  fi
  display_alert "Extracting mpc-${MPC_VER}" "" ""
  tar -xf mpc-${MPC_VER}.tar.gz
  rm mpc-${MPC_VER}.tar.gz
else
  display_alert "Mpc-${MPC_VER} sources already exist" "" "info"
fi

#compile binutils
display_alert "Compiling Binutils" "" ""
cd ${DEST_DIR}/build-binutils
${DEST_DIR}/binutils-${BIN_UTILS_VER}/configure --prefix=/opt/cross --target=aarch64-linux -enable-languages=c,c++ --disable-multilib
if [ ! -f "Makefile" ];
then
  exit_with_error "Failed to configure Binutils"
fi
make -j4
make install

#compile Linux
display_alert "Compiling Linux Kernel" "" ""
cd ${DEST_DIR}/linux-${LINUX_VER}
make ARCH=arm64 INSTALL_HDR_PATH=/opt/cross/aarch64-linux headers_install
cd ..

#compile gcc stage 1
display_alert "Compiling GCC Stage 1" "" ""
cd ${DEST_DIR}/build-gcc
ln -s ../mpfr-${MPFR_VER} mpfr
ln -s ../gmp-${GMP_VER} gmp
ln -s ../mpc-${MPC_VER} mpc
ln -s ../isl-${ISL_VER} isl
ln -s ../cloog-${CLOOG_VER} cloog
../gcc-${GCC_VER}/configure --prefix=/opt/cross --target=aarch64-linux --enable-languages=c,c++ --disable-multilib
make -j4 all-gcc
make install-gcc
cd ..

#compile glibc
display_alert "Compiling GLIBC" "" ""
cd ${DEST_DIR}/build-glibc
../glibc-${GLIBC_VER}/configure --prefix=/opt/cross/aarch64-linux --build=$MACHTYPE --host=aarch64-linux --disable-multilib libc_cv_forced_unwind=yes
make install-bootstrap-header=yes install-headers
make -j4 csu/subdir_lib
install csu/crt1.o csu/crti.o csu/crtn.o /opt/cross/aarch64-linux/lib
aarch64-linux-gcc -nostdlib -nostartfiles -shared -x c /dev/null -o /opt/cross/aarch64-linux/lib/libc.so
touch /opt/cross/aarch64-linux/include/gnu/stubs.h
cd ..

#compile gcc stage 2
display_alert "Compiling GCC Stage 2" "" ""
cd build-gcc
make -j4 all-target-libgcc
make install-target-libgcc
cd ../build-glibc
make -j4
make install
cd ../build-gcc
make -j4
make install

aarch64-linux-gcc -v
aarch64-linux-g++ -v






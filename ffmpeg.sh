#!/bin/bash
cd /home/jwd/third_modules/ffmpeg
mkdir ffmpeg_sources ffmpeg_build bin
sudo apt-get update
sudo apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev

sudo apt-get install libasound2-dev
sudo apt-get install libgl1-mesa-dev
sudo apt-get install libglew-dev
sudo apt-get install libglm-dev

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2 && \
tar xjvf nasm-2.14.02.tar.bz2 && \
cd nasm-2.14.02 && \
./autogen.sh 

# 配置环境变量并配置nasm编译
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" ./configure --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" --bindir="/home/jwd/third_modules/ffmpeg/bin"

# 编译和安装
make -j 12 && make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 

# 配置环境变量并配置nasm编译
./configure   CFLAGS="-fPIC" CPPFLAGS="-fPIC"  --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" --bindir="/home/jwd/third_modules/ffmpeg/bin" 

# 编译和安装
make -j 12 &&  make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://github.com/mirror/x264.git 

# 进入x264目录
cd x264  

# 配置环境变量并配置libx264编译
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" PKG_CONFIG_PATH="/home/jwd/third_modules/ffmpeg/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" --bindir="/home/jwd/third_modules/ffmpeg/bin" --enable-static --enable-pic

# 编译和安装
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" make && make install

sudo apt-get install mercurial libnuma-dev && \
cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
if cd x265 2> /dev/null; then git pull && cd ..; else git clone https://gitee.com/mirrors_videolan/x265.git; fi && \
cd x265/build/linux && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/home/jwd/third_modules/ffmpeg/ffmpeg_build" -DENABLE_SHARED=off ../../source && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" make -j 12 && \
make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://github.com/webmproject/libvpx.git && \
cd libvpx && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" ./configure --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm --enable-pic && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" make -j 12 && \
make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
./configure CFLAGS="-fPIC" CPPFLAGS="-fPIC" --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build"   && \
make -j 12 && \
make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
git clone  --depth 1 https://gitee.com/hqiu/lame.git && \
cd lame && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" ./configure --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" --bindir="/home/jwd/third_modules/ffmpeg/bin"  --enable-nasm --with-pic && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" make -j 12 && \
make install

cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && \
cd opus && \
./autogen.sh && \
./configure --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build"  -with-pic&& \
make -j 12 && \
make install

sudo apt-get install openssl
sudo apt-get install libssl-dev

# 先执行：
cd /home/jwd/third_modules/ffmpeg/ffmpeg_sources && \
mv /mnt/hgfs/share/code/* ./ 

# 然后执行：
tar zxvf ffmpeg-4.3.9.tar.gz && \
cd ffmpeg-4.3.9 && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" PKG_CONFIG_PATH="/home/jwd/third_modules/ffmpeg/ffmpeg_build/lib/pkgconfig" CFLAGS="-O3 -fPIC" ./configure \
  --prefix="/home/jwd/third_modules/ffmpeg/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/home/jwd/third_modules/ffmpeg/ffmpeg_build/include" \
  --extra-ldflags="-L/home/jwd/third_modules/ffmpeg/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="/home/jwd/third_modules/ffmpeg/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-pic \
  --enable-shared   \
  --enable-openssl  \
  --enable-nonfree  \
  --disable-optimizations \
  --disable-stripping \
  --enable-debug=3 && \
PATH="/home/jwd/third_modules/ffmpeg/bin:$PATH" make -j 12 && \
make install && \
hash -r
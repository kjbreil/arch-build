FROM kjbreil/arch-base:2017.01.09
MAINTAINER kjbreil
RUN pacman -S --needed --noconfirm ruby openssh base-devel musl vim-minimal \
	tree nano git unrar unzip par2cmdline python2-markdown python2-cheetah \
	libmms libjpeg-turbo libtiff libpng libxrender graphite harfbuzz freetype2 \
	fontconfig mesa-libgl cairo giflib libexif libgdiplus mono libuv c-ares \
	libzen libmediainfo http-parser nodejs semver npm systemd python2-lxml arch-install-scripts
WORKDIR /opt/build
CMD ["make", "inside"]
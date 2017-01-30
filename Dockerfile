FROM kjbreil/arch-base
MAINTAINER kjbreil
RUN pacman -S --needed --noconfirm ruby openssh base-devel musl vim-minimal arch-install-scripts \
	tree nano git unrar unzip coreutils findutils jshon
WORKDIR /opt/build
CMD ["make", "inside"]
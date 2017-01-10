FROM kjbreil/arch-base:2017.01.09
MAINTAINER kjbreil
RUN pacman -S --needed --noconfirm ruby openssh base-devel musl vim-minimal \
	tree nano git unrar unzip   
WORKDIR /opt/build
CMD ["make", "inside"]
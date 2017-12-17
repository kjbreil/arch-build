FROM kjbreil/arch-base
MAINTAINER kjbreil
RUN pacman -S --needed --noconfirm ruby openssh base-devel musl vim-minimal arch-install-scripts \
	tree nano git unrar unzip coreutils findutils jshon go nodejs && \
	pacman -Scc
WORKDIR /opt/build
VOLUME /opt/build
CMD ["make", "inside"]
FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
    build-essential \
	libssl-dev \
	uuid-dev \
	libgpgme11-dev \
	squashfs-tools \
	libseccomp-dev \
	pkg-config \
	wget \
	git \
	debootstrap \
	jq
# ref https://www.sylabs.io/guides/3.0/user-guide/appendix.html#build-debootstrap

COPY . /builder_scripts/
RUN /builder_scripts/install-go.sh
ENV PATH="${PATH}:/usr/local/go/bin"
ENV GOPATH="/go"
#Install the oras enabled version
RUN /builder_scripts/install-singularity.sh

ENTRYPOINT ["/builder_scripts/build.sh"]

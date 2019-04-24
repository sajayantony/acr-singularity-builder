export VERSION=1.11 OS=linux ARCH=amd64 
wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz 
tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

export PATH=$PATH:/usr/local/go/bin
go get -u github.com/golang/dep/cmd/dep

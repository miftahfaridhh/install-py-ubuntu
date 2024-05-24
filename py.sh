sudo apt-get install \
    curl \
    gcc \
    libbz2-dev \
    libev-dev \
    libffi-dev \
    libgdbm-dev \
    liblzma-dev \
    libncurses-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    make \
    tk-dev \
    wget \
    zlib1g-dev -y

export PYTHON_VERSION=3.10.13
export PYTHON_MAJOR=3


curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar -xvzf Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}

./configure \
    --prefix=/opt/python/${PYTHON_VERSION} \
    --enable-shared \
    --enable-optimizations \
    --enable-ipv6 \
    LDFLAGS=-Wl,-rpath=/opt/python/${PYTHON_VERSION}/lib,--disable-new-dtags
make
sudo make install

cd ~

/opt/python/${PYTHON_VERSION}/bin/python${PYTHON_MAJOR} --version

sudo update-alternatives --remove python3 /usr/bin/python3.6
sudo update-alternatives --install /usr/bin/python3 python3 /opt/python/${PYTHON_VERSION}/bin/python${PYTHON_MAJOR} 1
sudo update-alternatives --config python3

python3 --version

python3 -m pip install --upgrade pip 

python3 -m pip install -r req.txt


# cd ~

# sudo sh -c 'echo "PATH=/opt/python/3.10.13/bin/:$PATH" >> /etc/profile.d/python.sh'
# sudo chmod +x /etc/profile.d/python.sh
# source /etc/profile.d/python.sh

# python3 --version



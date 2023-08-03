# Python PDM Base dockerfile image
FROM python:3.9.16-slim-buster as python

# Metadata
LABEL name="Python3.9 PDM"
LABEL maintainer="PythonBiellaGroup"
LABEL version="0.1"

ARG PDM_VERSION="2.7.0"

# Install libraries
RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    libpq-dev gcc wget gnupg2 curl openssh-client git make build-essential \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# add custom host file
# COPY hosts tmp/
# ADD hosts /tmp/hosts
# Warning: if you test on M1 and arch64 architecture you could have an issue with this line
# If you are using mac or arch64 change x86_64-linux-gnu with aarch64-linux-gnu
# RUN mkdir -p -- /lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /lib-override
# RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /lib-override/libnss_files.so.2
# ENV LD_LIBRARY_PATH /lib-override

# install PDM
RUN pip install -U pip setuptools wheel
RUN pip install pdm==${PDM_VERSION}

#if you want to test the image
# CMD ["tail", "-f", "/dev/null"]

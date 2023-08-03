FROM node:lts

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y \
    libpq-dev gcc wget curl gnupg2 openssh-client make build-essential git \
    && mkdir -p ~/.ssh

# COPY bin/ssh-config.sh /usr/bin/ssh-config.sh
# COPY ./config /root/.ssh/config
# RUN chmod 400 /root/.ssh/config
# RUN chmod +x /usr/bin/ssh-config.sh 

# add custom host file
# COPY hosts tmp/
# ADD hosts /tmp/hosts
# Warning: if you test on M1 and arch64 architecture you could have an issue with this line
# If you are using mac or arch64 change x86_64-linux-gnu with aarch64-linux-gnu
# RUN mkdir -p -- /lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /lib-override
# RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /lib-override/libnss_files.so.2
# ENV LD_LIBRARY_PATH /lib-override


# add custom config file
# COPY config tmp/
# ADD config temp/config
# ADD config /root/.ssh/config
# Warning: if you test on M1 and arch64 architecture you could have an issue with this line
# If you are using mac or arch64 change x86_64-linux-gnu with aarch64-linux-gnu
# RUN mkdir -p -- /lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /lib-override
# RUN perl -pi -e 's:/root/.ssh/config:/tmp/config:g' /lib-override/libnss_files.so.2
# ENV LD_LIBRARY_PATH /lib-override
# RUN chmod 400 /root/.ssh/config 

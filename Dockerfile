FROM debian:stable-slim
RUN apt-get update && apt-get install -y git sudo gnupg apt-utils
RUN useradd -ms /bin/bash cwuser -g root -G sudo && \
      cp /etc/sudoers /etc/sudoers.ORIG && \
      echo "cwuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/cwuser
USER cwuser
RUN git clone https://github.com/google/codeworld
WORKDIR /home/cwuser/codeworld
RUN ./install.sh
USER root
RUN mv /etc/sudoers.ORIG /etc/sudoers
USER cwuser
ENTRYPOINT [ "./run.sh" ]
EXPOSE 8080 9160


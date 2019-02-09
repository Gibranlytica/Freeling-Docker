FROM ubuntu:18.04

RUN apt-get update -q && \
    apt-get install -y locales apt-utils build-essential automake autoconf libtool && \
    apt-get install -y libicu-dev cmake libboost-regex-dev libboost-filesystem-dev \
                       libboost-program-options-dev libboost-thread-dev \
                       zlib1g-dev python3-dev swig 
RUN locale-gen en_US.UTF-8 
ENV FLINSTALL = /usr/local/
WORKDIR ${FLINSTALL}
ADD https://github.com/TALP-UPC/FreeLing/releases/download/4.1/FreeLing-4.1.tar.gz .
RUN tar xvzf FreeLing-4.1.tar.gz && \
    rm -rf FreeLing-4.1.tar.gz && \
    cd FreeLing* && \
    mkdir build && \
    cd build && \
    cmake -DPYTHON3_API=ON .. && \
    make install && \
    apt-get --purge -y remove build-essential \
            automake autoconf libtool cmake && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH = ${FLINSTALL}/lib/
ENV FREELINGDIR = ${FLINSTALL}

RUN rm -rf ${FLINSTALL}/FreeLing-4.1/de
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/fr
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/ru
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/sl
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/hr
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/gl
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/nb
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/pt
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/cs
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/as
RUN rm -rf ${FLINSTALL}/FreeLing-4.1/ca

WORKDIR /usr/local/FreeLing-4.1/APIs/python3/
EXPOSE 50005
CMD echo 'Hello world' | python3 sample.py

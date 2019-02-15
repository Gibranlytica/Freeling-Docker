FROM ubuntu:18.04

RUN apt-get update -q && \
    apt-get install -y locales apt-utils build-essential automake autoconf libtool && \
    apt-get install -y libicu-dev cmake libboost-regex-dev libboost-filesystem-dev \
                       libboost-program-options-dev libboost-thread-dev \
                       zlib1g-dev python3-dev swig 
RUN locale-gen en_US.UTF-8 
ENV FLINSTALL = /usr/local/
WORKDIR ${FLINSTALL}
#ADD https://github.com/TALP-UPC/FreeLing/releases/download/4.1/FreeLing-4.1.tar.gz .
ADD FreeLing-4.1.tar.gz /usr/local/
WORKDIR /usr/local/FreeLing-4.1
RUN mkdir build
WORKDIR /usr/local/FreeLing-4.1/build
RUN 
# RUN rm -rf FreeLing-4.1.tar.gz && \
#     cd FreeLing* && \
#     mkdir build && \
#     cd build && \
#     cmake -DPYTHON3_API=ON .. && \
#     make install && \
#     apt-get --purge -y remove build-essential \
#             automake autoconf libtool cmake && \
#     apt-get autoremove -y && \
#     apt-get clean -y && \
#     rm -rf /var/lib/apt/lists/*

ENV FREELINGDIR = ${FLINSTALL}
#COPY deleteOtherLanguages.sh /root/deleteOtherLanguages.sh
WORKDIR /root/
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
#RUN chmod +x /root/deleteOtherLanguages.sh
#RUN  ./root/deleteOtherLanguages.sh
WORKDIR ${FLINSTALL}/APIs/python3/
RUN ls ${FLINSTALL}
# COPY _pyfreeling.so .
# COPY pyfreeling.py .
# COPY sample.py .
# EXPOSE 50005
CMD echo 'Hello world' | python3 sample.py
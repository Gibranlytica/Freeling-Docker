FROM ubuntu:18.04

RUN apt-get update -q && \
    apt-get install -y locales apt-utils build-essential automake autoconf libtool && \
    apt-get install -y libicu-dev cmake libboost-regex-dev libboost-filesystem-dev \
                       libboost-program-options-dev wget libboost-thread-dev \
                       zlib1g-dev swig 
RUN locale-gen en_US.UTF-8 
ENV FLINSTALL /usr/local
WORKDIR ${FLINSTALL}
RUN wget https://github.com/TALP-UPC/FreeLing/releases/download/4.1/FreeLing-4.1.tar.gz -q --show-progress && \
    tar -xzf FreeLing-4.1.tar.gz && \
	rm -rf FreeLing-4.1.tar.gz
RUN ls /usr/local/FreeLing-4.1/
#ADD FreeLing-4.1.tar.gz ${FLINSTALL} 
RUN ls -d /usr/local/FreeLing-4.1/data/?? | grep -v "it" | grep -v "en" | xargs rm -rf 
RUN ls /usr/local/FreeLing-4.1/data/
WORKDIR /usr/local/FreeLing-4.1/build
RUN ls
RUN cmake .. && make -j 4 install
RUN apt-get --purge -y remove build-essential \
    automake autoconf libtool cmake && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}
ENV FREELINGDIR ${FLINSTALL}
#ARG primary_lang
#ARG secondary_lang
RUN rm -rf /usr/local/FreeLing-4.1
RUN apt-get --purge -y remove build-essential libicu-dev \
            libboost-regex-dev \
            libboost-program-options-dev libboost-thread-dev zlib1g-dev\
            automake autoconf libtool wget
CMD analyze -f it.cfg en.cfg --server --port 50005 --output json & 

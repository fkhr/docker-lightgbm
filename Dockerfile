FROM alpine:3.6

ENV  LIBSVM_VERSION     "322"
ENV  LIBLINEAR_VERSION  "211"
ENV  LIGHTGBM_VERSION   "2.0.11"

RUN set -x \
    && apk update \
    && apk --no-cache add \
        libstdc++ \
    && apk --no-cache add --virtual .builddeps \
        build-base \
        ca-certificates \
        cmake \
        wget \
    ## libsvm
    && wget -q -O - https://github.com/cjlin1/libsvm/archive/v${LIBSVM_VERSION}.tar.gz \
        | tar -xzf - -C / \
    && cd /libsvm-${LIBSVM_VERSION} \
    && make all lib \
    && cp svm-train svm-predict svm-scale /usr/local/bin/ \
    && cp libsvm.so* /usr/local/lib/ \
    ## liblinear
    && wget -q -O - https://github.com/cjlin1/liblinear/archive/v${LIBLINEAR_VERSION}.tar.gz \
        | tar -xzf - -C / \
    && cd /liblinear-${LIBLINEAR_VERSION} \
    && make all lib \
    && cp train predict /usr/local/bin/ \
    && cp liblinear.so* /usr/local/lib/ \
    ## lightgbm
    && apk --no-cache add \
        libgomp \ 
        libstdc++ \
    && wget -q -O - https://github.com/Microsoft/LightGBM/archive/v${LIGHTGBM_VERSION}.tar.gz \
        | tar -xzf - -C / \
    ## cli
    && cd /LightGBM-*/ \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j2 \
    && make install \
    ## python package (unstable)
    # && cd /LightGBM-* \
    # && python setup.py install \
    ## clean
    && apk del .builddeps \
    && rm -rf \
        /liblinear* \
        /libsvm* \
        /LightGBM-*
 


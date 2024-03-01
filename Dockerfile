FROM ubuntu:18.04

ENV HACK_VERSION v3.003
ENV MGENPLUS_VERSION 20150602
ENV DEJAVU_VERSION 2.37
ENV ICONSFORDEVS_VERSION master
ENV CICA_SOURCE_FONTS_PATH /work/sourceFonts

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    software-properties-common fontforge unar git curl && \
    mkdir /work
WORKDIR /work
COPY sourceFonts sourceFonts
RUN curl -k --fail -L https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip -o /tmp/hack.zip && \
    unar /tmp/hack.zip -o /tmp/hack && cp /tmp/hack/ttf/* sourceFonts/ && \
    curl -k --fail -L https://osdn.jp/downloads/users/8/8598/rounded-mgenplus-20150602.7z -o /tmp/rounded-mgenplus.7z && \
    unar /tmp/rounded-mgenplus.7z -o /tmp && \
    cp /tmp/rounded-mgenplus/rounded-mgenplus-1m-regular.ttf sourceFonts/ && \
    cp /tmp/rounded-mgenplus/rounded-mgenplus-1m-bold.ttf sourceFonts/ && \
    curl -k --fail -L https://github.com/googlefonts/noto-emoji/blob/e0aa9412575fc39384efd39f90c4390d66bdd18f/fonts/NotoEmoji-Regular.ttf?raw=true -o sourceFonts/NotoEmoji-Regular.ttf && \
    curl -k --fail -L http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.zip -o /tmp/dejavu.zip && \
    unar /tmp/dejavu.zip -o /tmp && \
    cp /tmp/dejavu-fonts-ttf-2.37/ttf/DejaVuSansMono.ttf sourceFonts/ && \
    cp /tmp/dejavu-fonts-ttf-2.37/ttf/DejaVuSansMono-Bold.ttf sourceFonts/ && \
    curl -k --fail -L https://github.com/mirmat/iconsfordevs/raw/master/fonts/iconsfordevs.ttf -o sourceFonts/iconsfordevs.ttf-o sourceFonts/iconsfordevs.ttf

COPY cica.py cica.py
COPY LICENSE.txt LICENSE.txt
COPY COPYRIGHT.txt COPYRIGHT.txt

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT entrypoint.sh

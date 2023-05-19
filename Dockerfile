FROM primovist/alpine-glibc
RUN apk add --no-cache dpkg
LABEL maintainer="durianice" \
         org.label-schema.name="snell-server"
 ENV LANG=C.UTF-8
 ENV PORT=37370
 ENV PSK=
 ENV OBFS=http
 COPY main.sh /usr/bin/
 RUN ARCHITECTURE=$(dpkg --print-architecture) && \
     ARCHITECTURE=${ARCHITECTURE#*-*-} && \
     SNELL_URL="https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-$ARCHITECTURE.zip" && \
     wget --no-check-certificate -O snell.zip $SNELL_URL && \
     unzip snell.zip && \
     rm -f snell.zip && \
     chmod +x snell-server && \
     mv snell-server /usr/bin/ && \
     chmod +x /usr/bin/main.sh
 ENTRYPOINT ["main.sh"]

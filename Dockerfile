FROM alpine:3.8
RUN apk add --update nginx python3 enchant && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip sopel &&\
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache
RUN addgroup -S sopel && adduser -H -S sopel -G sopel
COPY nginx.conf /etc/nginx/conf.d/nginx.conf
USER sopel

CMD ["nginx", "-g", "daemon off;"]

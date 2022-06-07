FROM tezos/tezos:master

# Install AWS CLI

USER root

RUN \
	apk -Uuv add groff less python3 py-pip curl jq py3-six py3-urllib3 py3-colorama && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY ./start-tezos.sh /home/tezos/start-tezos.sh
RUN chmod 755 /home/tezos/start-tezos.sh

COPY ./utc-time-math.py /home/tezos/utc-time-math.py
RUN chmod 755 /home/tezos/utc-time-math.py

USER tezos
EXPOSE 8732 9732
ENTRYPOINT ["/home/tezos/start-tezos.sh"]

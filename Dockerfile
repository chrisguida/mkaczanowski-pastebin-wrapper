FROM debian:buster-slim
ADD ./pastebin/target/armv7-unknown-linux-gnueabihf/release/pastebin /usr/local/bin/pastebin
RUN chmod a+x /usr/local/bin/pastebin
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
RUN apt update && apt install tini
#ENTRYPOINT ["pastebin", "--db /root/pastebin.db"]
#ENTRYPOINT ["pastebin"]
ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]

FROM debian:bookworm-slim

ARG UID=1001
ARG GID=1001

ARG DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NONINTERACTIVE_SEEN="true"

RUN groupadd --gid ${GID} bitcoin \
  && useradd --create-home --no-log-init -u ${UID} -g ${GID} bitcoin \
  && apt-get update -y \
  && apt-get --no-install-recommends -y install jq curl gnupg gosu ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG BITCOIN_BASE

ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV PATH=/opt/bitcoin/bin:$PATH

COPY ./build/src/bitcoind /opt/bitcoin/bin/drivechaind
COPY ./build/src/bitcoin-cli /opt/bitcoin/bin/drivechain-cli

COPY --chmod=755 entrypoint.sh /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

# REST interface
EXPOSE 8080

# P2P network (mainnet, testnet & regnet respectively)
EXPOSE 8333 18333 18444

# RPC interface (mainnet, testnet & regnet respectively)
EXPOSE 8332 18332 18443

# ZMQ ports (for transactions & blocks respectively)
EXPOSE 28332 28333

HEALTHCHECK --interval=300s --start-period=60s --start-interval=10s --timeout=20s CMD gosu bitcoin drivechain-cli -rpcwait -getinfo || exit 1

ENTRYPOINT ["/entrypoint.sh"]

CMD ["drivechaind"]


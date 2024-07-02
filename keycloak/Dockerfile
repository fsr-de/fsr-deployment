ARG VERSION=20.0

FROM quay.io/keycloak/keycloak:$VERSION AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM debian AS theme-loader

RUN mkdir /theme
WORKDIR /theme
ADD https://github.com/fsr-de/fsr-keycloak-theme/archive/refs/heads/main.tar.gz ./theme.tar.gz
RUN tar -xf theme.tar.gz

FROM quay.io/keycloak/keycloak:$VERSION
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
COPY --from=theme-loader --chown=keycloak:root /theme/fsr-keycloak-theme-main themes/fsr-keycloak-theme
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

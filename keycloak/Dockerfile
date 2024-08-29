ARG VERSION=20.0

FROM gradle:8.2-jdk17 AS plugin-builder

RUN git clone https://github.com/giz-berlin/keycloak-role-authenticator \
    && cd keycloak-role-authenticator \
    && sed -i -E "s/keycloakVersion = '[0-9\.]+'/keycloakVersion = '$VERSION'/" build.gradle \
    && gradle jar

FROM quay.io/keycloak/keycloak:$VERSION AS kc-builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres

COPY --from=plugin-builder keycloak-role-authenticator/build/libs/*.jar /opt/keycloak/providers

RUN /opt/keycloak/bin/kc.sh build

FROM debian AS theme-loader

RUN mkdir /theme
WORKDIR /theme
ADD https://github.com/fsr-de/fsr-keycloak-theme/archive/refs/heads/main.tar.gz ./theme.tar.gz
RUN tar -xf theme.tar.gz

FROM quay.io/keycloak/keycloak:$VERSION

COPY --from=kc-builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
COPY --from=theme-loader --chown=keycloak:root /theme/fsr-keycloak-theme-main themes/fsr-keycloak-theme
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

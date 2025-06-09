FROM stevenmassaro/recurring-task-base:v3.3.22

COPY age.sh age.sh
COPY free-space.sh free-space.sh
ENV COMMAND="./\$type.sh && curl -fsS -m 10 --retry 5 -o /dev/null \"\$HEALTHCHECKS_URL\""

RUN apk add --no-cache --update curl coreutils findutils \
    && chmod +x age.sh \
    && chmod +x free-space.sh

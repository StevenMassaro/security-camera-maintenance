FROM stevenmassaro/recurring-task-base:3.18

COPY run.sh run.sh
ENV COMMAND="./run.sh && curl -fsS -m 10 --retry 5 -o /dev/null \"\$HEALTHCHECKS_URL\""

RUN apk add --no-cache --update curl coreutils && chmod +x run.sh

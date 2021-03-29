FROM  centos
LABEL com.cerner.name='TLOCK CLI Scanner'
LABEL com.cerner.repo-url='https://github.com/ss088271/TwistCLI_CICD'

COPY scan.sh .scan
RUN chmod +x ./.scan

ARG USERNAME
ARG PASSWORD
ARG TLOCK_URL

RUN yum update -y ; yum install dnf -y \
  jq \
  docker \
  iptables

COPY scan.sh scan
RUN chmod a+x ./scan

RUN echo 'Generate TLOCK Token'; \
      echo "$TLOCK_URL/api/v1/authenticate"; \
      export TLOCK_TKN=$( \
      curl -ks \
      -H 'Content-Type: application/json' \
      -d "{\"username\":\"${USERNAME}\",\"password\":\"${PASSWORD}\"}" \
      "$TLOCK_URL/api/v1/authenticate" \
      | jq --raw-output '.token'); \
    echo 'Download TwistCLI'; \
      curl -k -L \
      -H "Authorization: Bearer ${TLOCK_TKN}" \
      -o twistcli \
      "${TLOCK_URL}/api/v1/util/twistcli";

RUN chmod a+x ./twistcli;

ENTRYPOINT ["./scan"]

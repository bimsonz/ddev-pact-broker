setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-pact-broker
  mkdir -p $TESTDIR
  export PROJNAME=test-pact-broker
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME} --project-type=php --docroot=public --create-docroot
  ddev start -y >/dev/null
}

health_checks() {
  # Check if the Pact Broker service is up and can serve requests.
  # Since Pact Broker runs on port 9292, we use that for the check.
  response=$(ddev exec curl -s http://pact-broker:${DDEV_SITENAME}-pact-broker:9292)
  if [[ "$response" == *'Pact Broker'* ]]; then
    echo "Pact Broker is up and running."
  else
    echo "Failed to access Pact Broker." >&2
    return 1
  fi
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  health_checks
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get ddev/ddev-pact-broker with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ddev/ddev-pact-broker
  ddev restart >/dev/null
  health_checks
}

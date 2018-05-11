#!/bin/bash
# aarch64-linux Cross Compiler build script
#
#

SRC_DIR="$(dirname "$(realpath "${BASH_SOURCE}")")"
# fallback for Trusty
[[ -z "${SRC_DIR}" ]] && SRC_DIR="$(pwd)"
#SRC_DIR="$(pwd)"

# check for whitespace in $SRC_DIR and exit for safety reasons
grep -q "[[:space:]]" <<<"$SRC_DIR}" && { echo "\"${SRC}\" contains whitespaces. Not supported. Aborting." >&2 ; exit 1 ; }

# load helper functions
if [ -f $SRC_DIR/lib/general.sh ]; then
  source $SRC_DIR/lib/general.sh
else
  echo "Error: missing build directory structure"
  echo "Please clone the full repository http::"
  exit -1
fi

# check for root privileges
if [[ $EUID != 0 ]]; then
  display_alert "This script requires root privileges, trying to use sudo" "" "wrn"
  sudo "$SRC_DIR/build.sh" "$@"
  exit $?
fi

#update
apt-get install -y build-essential bison g++ gawk gcc git 
#if [[ ! -f $SRC_DIR/.ignore_changes ]]; then
#  echo -e "[\e[0;32m o.k. \x1B[0m] This script will try to update"
#  git pull
#  CHANGED_FILES=$(git diff --name-only)
#  if [[ -n $CHANGED_FILES ]]; then
#    echo -e "[\e[0;35m warn \x1B[0m] Can't update since you made changes to: \e[0;32m\n${CHANGED_FILES}\x1B[0m"
#    echo -e "Press \e[0;33m<Ctril-C>\x1B[0m ro abort compilation, \e[0;33m<Enter>\x1B[0m to ignore and continure"
#    read
#  else
#    git checkout ${LIB_TAG:- master}
#  fi
#fi



source $SRC_DIR/lib/main.sh


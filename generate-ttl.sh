#!/bin/sh

#set -e
#echo "Please run this script from the _bin folder"

error() {
 echo "$@" 1>&2
}

SCRIPTPATH=$(cd ${0%/*}; pwd)

if [ -f ${SCRIPTPATH}/lv2_ttl_generator.exe ]; then
  GEN=${SCRIPTPATH}/lv2_ttl_generator.exe
  EXT=dll
else
  GEN=${SCRIPTPATH}/lv2_ttl_generator
  EXT=so
fi
if [ ! -x "${GEN}"  ]; then
  error "unable to find lv2_ttl_generator"
  exit 1
fi

SEARCHPATH=$1
if [ "x${SEARCHPATH}" = "x" ]; then
 if [ -d "lv2" ]; then
   SEARCHPATH="lv2"
 fi
 if [ ! -d "${SEARCHPATH}" ]; then
   SEARCHPATH=.
 fi
fi
if [ ! -d "${SEARCHPATH}" ]; then
 error "cannot search plugins in non-existing directory ${SEARCHPATH}"
 exit 1
fi


find  ${SEARCHPATH} -type d -name "*.lv2" -exec /bin/sh -c "cd {}; ${GEN} ./*.${EXT}" \;


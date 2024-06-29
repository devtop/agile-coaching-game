#!/bin/bash

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
SCRIPT_PATH="$(cd -- "$SCRIPT_PATH" && pwd)"    # absolutized and normalized
if [[ -z "$SCRIPT_PATH" ]] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

ROOTPATH="$(cd -- "$SCRIPT_PATH/../../" && pwd)"
SRCPATH="$ROOTPATH/src"
BUILDPATH="$ROOTPATH/build"

cd "$ROOTPATH"

for LANGUAGE in "de" "en"; do
  echo "Start buidling diy print sheet PDF $LANGUAGE"

  magick -quality 94 -density 300 "$BUILDPATH/$LANGUAGE/print/images/"*.jpg -page A4 "$BUILDPATH/$LANGUAGE/print/cards.pdf"
  echo -n .

  magick -quality 25 -compress jpeg -density 76 "$BUILDPATH/$LANGUAGE/print/images/"*.jpg -page A4 "$BUILDPATH/$LANGUAGE/print/cards_compact.pdf"
  echo -n .

  echo " "
done
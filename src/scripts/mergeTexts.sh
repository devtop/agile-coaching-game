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


  tail -n +1 \
    src/cards/method/*.$LANGUAGE.md \
    src/cards/culture/*.$LANGUAGE.md \
    src/cards/mission/*.$LANGUAGE.md  \
    src/cards/organization/*.$LANGUAGE.md \
    src/cards/selection/*.$LANGUAGE.md \
    src/cards/role/*.$LANGUAGE.md \
    src/cards/event/*.$LANGUAGE.md \
    > "$BUILDPATH/texts.$LANGUAGE.txt"

done 
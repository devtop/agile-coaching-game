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

    echo "Start build packages "$LANGUAGE

    cp "$SRCPATH/tokens/tokens_diy.pdf" "$BUILDPATH/$LANGUAGE/print/"
    echo -n .
    rm "$BUILDPATH/print_diy.$LANGUAGE.zip"
    echo -n .
    zip -j "$BUILDPATH/print_diy.$LANGUAGE.zip" \
        "$BUILDPATH/$LANGUAGE/print/rules.pdf" \
        "$BUILDPATH/$LANGUAGE/print/cards.pdf" \
        "$BUILDPATH/$LANGUAGE/print/tokens_diy.pdf"
    echo -n .
    rm "$BUILDPATH/print_mail.$LANGUAGE.zip"
    echo -n .
    zip -j "$BUILDPATH/print_mail.$LANGUAGE.zip" \
        "$BUILDPATH/$LANGUAGE/print/rules.pdf" \
        "$BUILDPATH/$LANGUAGE/print/cards_compact.pdf" \
        "$BUILDPATH/$LANGUAGE/print/tokens_diy.pdf" \
        "$BUILDPATH/textmerge.de.txt" \
        "$BUILDPATH/textmerge.en.txt"
    echo -n .
    zip -j "$BUILDPATH/professional_print.$LANGUAGE.zip" \
        "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pdf" \
        "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pdf" \
        "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pdf" \
        "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pdf" 
    echo -n .

    rm "$BUILDPATH/all.$LANGUAGE.zip"
    echo -n .
    zip -r "$BUILDPATH/all.$LANGUAGE.zip" \
        "build/$LANGUAGE/"
    echo .
done
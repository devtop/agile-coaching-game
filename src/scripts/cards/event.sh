#!/bin/bash

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
SCRIPT_PATH="$(cd -- "$SCRIPT_PATH" && pwd)"    # absolutized and normalized
if [[ -z "$SCRIPT_PATH" ]] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

ROOTPATH="$(cd -- "$SCRIPT_PATH/../../../" && pwd)"
SRCPATH="$ROOTPATH/src"
BUILDPATH="$ROOTPATH/build"

cd "$ROOTPATH"

for LANGUAGE in "de" "en"; do

    # EVENTS
    CATEGORY="$(cat "$SRCPATH/cards/event/back.$LANGUAGE.md")"
    CATEGORY="${CATEGORY^^}"
    mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/event"

    echo "Start build event cards $LANGUAGE "

    for file in src/cards/event/[0-9][0-9].md; do
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        cardnumber="${filename%.*}"
        #TEXT="$(cat "$SRCPATH/cards/event/$cardnumber.$LANGUAGE.md")"
        TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/event/$cardnumber.$LANGUAGE.md")"
        WC="$(wc -m < "$SRCPATH/cards/event/$cardnumber.$LANGUAGE.md")"
        echo "$cardnumber: $WC"
        FONTSIZE=28

        if [ $WC -gt 266 ]; then
        FONTSIZE=24
        fi
        if [ $WC -gt 350 ]; then
        FONTSIZE=22
        fi

        FONTSIZE=$(($FONTSIZE+8))
        magick "$SRCPATH/cards/event/front.png" \
        -pointsize 50 -fill "#ADADAD" -font "$ROOTPATH/ext/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
        -pointsize 30 -font "$ROOTPATH/ext/static/OpenSans-Regular.ttf" -draw "text 1040,190 '$cardnumber'" \
        -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220\
        -composite "$BUILDPATH/$LANGUAGE/images/cards/event/$cardnumber.png"

    #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
        #+antialias
    done

    magick "$SRCPATH/cards/event/back.png" \
    -pointsize 100 -fill "#ADADAD" -font "$ROOTPATH/ext/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
    "$BUILDPATH/$LANGUAGE/images/cards/event/back.png"
    echo -n .
        
    echo " "
done
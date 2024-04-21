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

  # EVENTS
  CATEGORY="$(cat "$SRCPATH/cards/event/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/event"

  echo "Starting $LANGUAGE events"

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
    -pointsize 50 -fill "#ADADAD" -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
    -pointsize 40 -font "build/static/OpenSans-Regular.ttf" -draw "text 1020,100 '$cardnumber'" \
    -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220\
    -composite "$BUILDPATH/$LANGUAGE/images/cards/event/$cardnumber.png"

  #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
    #+antialias
  done

  magick "$SRCPATH/cards/event/back.png" \
  -pointsize 100 -fill "#ADADAD" -font "build/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png"
 
  mkdir -p "$BUILDPATH/$LANGUAGE/print/images/"

  magick montage -page A4 -density 300 -gravity north-west \
   "$BUILDPATH/$LANGUAGE/images/cards/event/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/event.jpg"
 
  magick montage -page A4 -density 300 -gravity north-west \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/event_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/event/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/event_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/event-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/event_back.jpg"
  fi

  # METHODS
  CATEGORY="$(cat "$SRCPATH/cards/method/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/method"

  echo "Starting $LANGUAGE methods"

  for file in src/cards/method/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"
    #TEXT="$(cat "$SRCPATH/cards/event/$cardnumber.$LANGUAGE.md")"
    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/method/$cardnumber.$LANGUAGE.md")"
    WC="$(wc -m < "$SRCPATH/cards/method/$cardnumber.$LANGUAGE.md")"
    echo "$cardnumber: $WC"
    FONTSIZE=28

    if [ $WC -gt 266 ]; then
      FONTSIZE=24
    fi
    if [ $WC -gt 350 ]; then
      FONTSIZE=22
    fi

    FONTSIZE=$(($FONTSIZE+8))
    magick "$SRCPATH/cards/method/front.png" \
    -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
    -pointsize 40 -font "build/static/OpenSans-Regular.ttf" -draw "text 1020,100 '$cardnumber'" \
    -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220\
    -composite "$BUILDPATH/$LANGUAGE/images/cards/method/$cardnumber.png"
  #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
    #+antialias
  done

  magick "$SRCPATH/cards/method/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png"

  magick montage -page A4 -density 300 -gravity north-west \
   "$BUILDPATH/$LANGUAGE/images/cards/method/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/method.jpg"
 
  magick montage -page A4 -density 300 -gravity north-west \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/method_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/method/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/method_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/method-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/method_back.jpg"
  fi

  # MISSION
  CATEGORY="$(cat "$SRCPATH/cards/mission/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/mission"

  echo "Starting $LANGUAGE mission"

  for file in src/cards/mission/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"
    #TEXT="$(cat "$SRCPATH/cards/mission/$cardnumber.$LANGUAGE.md")"
    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/mission/$cardnumber.$LANGUAGE.md")"
    WC="$(wc -m < "$SRCPATH/cards/mission/$cardnumber.$LANGUAGE.md")"
    echo "$cardnumber: $WC"
    FONTSIZE=28

    if [ $WC -gt 266 ]; then
      FONTSIZE=24
    fi
    if [ $WC -gt 350 ]; then
      FONTSIZE=22
    fi

    FONTSIZE=$(($FONTSIZE+8))
    magick "$SRCPATH/cards/mission/front.png" \
    -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
    -pointsize 40 -font "build/static/OpenSans-Regular.ttf" -draw "text 1020,100 '$cardnumber'" \
    -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220 \
    -composite "$BUILDPATH/$LANGUAGE/images/cards/mission/$cardnumber.png"
  #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
    #+antialias
  done

  magick "$SRCPATH/cards/mission/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png"

  magick montage -page A4 -density 300 -gravity north-west \
   "$BUILDPATH/$LANGUAGE/images/cards/mission/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/mission.jpg"
 
  magick montage -page A4 -density 300 -gravity north-west \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/mission_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/mission/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/mission_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/mission-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/mission_back.jpg"
  fi

  # ORGANIZATION
  CATEGORY="$(cat "$SRCPATH/cards/organization/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/organization"

  echo "Starting $LANGUAGE organization"

  for file in src/cards/organization/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"
    #TEXT="$(cat "$SRCPATH/cards/organization/$cardnumber.$LANGUAGE.md")"
    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/organization/$cardnumber.$LANGUAGE.md")"
    WC="$(wc -m < "$SRCPATH/cards/organization/$cardnumber.$LANGUAGE.md")"
    echo "$cardnumber: $WC"
    FONTSIZE=28

    if [ $WC -gt 266 ]; then
      FONTSIZE=24
    fi
    if [ $WC -gt 350 ]; then
      FONTSIZE=22
    fi
    if [ $WC -gt 560 ]; then
      FONTSIZE=20
    fi

    FONTSIZE=$(($FONTSIZE+8))
    magick "$SRCPATH/cards/organization/front.png" \
    -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
    -pointsize 40 -font "build/static/OpenSans-Regular.ttf" -draw "text 1020,100 '$cardnumber'" \
    -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220\
    -composite "$BUILDPATH/$LANGUAGE/images/cards/organization/$cardnumber.png"
  #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
    #+antialias
  done

  magick "$SRCPATH/cards/organization/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png"

  magick montage -page A4 -density 300 -gravity north-west \
   "$BUILDPATH/$LANGUAGE/images/cards/organization/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/organization.jpg"
 
  magick montage -page A4 -density 300 -gravity north-west \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/organization_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/organization/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/organization_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/organization-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/organization_back.jpg"
  fi

  # CULUTRE
  CATEGORY="$(cat "$SRCPATH/cards/culture/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/culture"

  echo "Starting $LANGUAGE culture"

  for file in src/cards/culture/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"
    #TEXT="$(cat "$SRCPATH/cards/culture/$cardnumber.$LANGUAGE.md")"
    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/culture/$cardnumber.$LANGUAGE.md")"
    TEXT=$(sed 's|\*\*||g' <<< $TEXT)
    WC="$(wc -m < "$SRCPATH/cards/culture/$cardnumber.$LANGUAGE.md")"
    echo "$cardnumber: $WC"
    FONTSIZE=28

    if [ $WC -gt 266 ]; then
      FONTSIZE=24
    fi
    if [ $WC -gt 350 ]; then
      FONTSIZE=22
    fi
    if [ $WC -gt 560 ]; then
      FONTSIZE=20
    fi

    FONTSIZE=$(($FONTSIZE+8))
    magick "$SRCPATH/cards/culture/front.png" \
    -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 '$CATEGORY'" \
    -pointsize 40 -font "build/static/OpenSans-Regular.ttf" -draw "text 1020,100 '$cardnumber'" \
    -fill black -size 930x -pointsize $FONTSIZE caption:"$TEXT" -geometry +120+220\
    -composite "$BUILDPATH/$LANGUAGE/images/cards/culture/$cardnumber.png"
  #  -fill black -size 910x pango:"<span font_family=\"Open Sans\" font=\"$FONTSIZE\">$TEXT</span>" -geometry +130+230 \
    #+antialias
  done

  magick "$SRCPATH/cards/culture/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 220,300 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png"

    magick montage -page A4 -density 300 -gravity north-west \
   "$BUILDPATH/$LANGUAGE/images/cards/culture/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/culture.jpg"
 
  magick montage -page A4 -density 300 -gravity north-west \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/culture_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/culture/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/culture_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/culture-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/culture_back.jpg"
  fi


# SELECTION
  CATEGORY="$(cat "$SRCPATH/cards/selection/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/selection"

  echo "Starting $LANGUAGE selection"

  for file in src/cards/selection/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"

    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/selection/$cardnumber.$LANGUAGE.md")"

    magick "$SRCPATH/cards/selection/front.png" \
     -pointsize 50 -fill "#666666" -font "build/static/OpenSans-SemiBold.ttf" -gravity North \
     -draw "text 0,142 '$CATEGORY'" -draw "text 0,980 '$cardnumber'" \
     -font "build/static/OpenSans-Regular.ttf" -background "#eeeeee" -size 556x \
     caption:"$TEXT" -geometry +0+230 \
    -composite "$BUILDPATH/$LANGUAGE/images/cards/selection/$cardnumber.png"
  done

  magick "$SRCPATH/cards/selection/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -gravity North -draw "text 0,150 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png"

  magick montage -page A4 -density 300 -gravity North -rotate 90 \
   "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/selection.jpg"
 
  magick montage -page A4 -density 300 -gravity North -rotate 90 \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/selection_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/selection_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/selection-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/selection_back.jpg"
  fi

# ROLE
  CATEGORY="$(cat "$SRCPATH/cards/role/back.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/role"

  echo "Starting $LANGUAGE role"

  for file in src/cards/role/[0-9][0-9].md; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    cardnumber="${filename%.*}"

    TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/role/$cardnumber.$LANGUAGE.md")"

    magick "$SRCPATH/cards/role/front.$cardnumber.png" \
     -pointsize 50 -fill "#666666" -font "build/static/OpenSans-SemiBold.ttf" -gravity North \
     -draw "text 0,142 '$CATEGORY'" -draw "text 0,980 '$cardnumber'" \
     -font "build/static/OpenSans-Regular.ttf" -size 556x \
     caption:"$TEXT" -geometry +0+230 \
    -composite "$BUILDPATH/$LANGUAGE/images/cards/role/$cardnumber.png"
  done

  magick "$SRCPATH/cards/role/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -gravity North -draw "text 0,150 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png"

  magick montage -page A4 -density 300 -gravity North -rotate 90 \
   "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/role.jpg"
 
  magick montage -page A4 -density 300 -gravity North -rotate 90 \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/role_back.jpg"

  FILES=$(ls "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png | wc -l)
  (( SHEETS = (FILES+7)/8 ))
  if [ $SHEETS -gt 1 ]; then
    for (( i=0; i<$SHEETS; i++ ))
    do
      cp "$BUILDPATH/$LANGUAGE/print/images/role_back.jpg" "$BUILDPATH/$LANGUAGE/print/images/role-$i""b.jpg"
    done
    rm "$BUILDPATH/$LANGUAGE/print/images/role_back.jpg"
  fi

# SPECIAL CARDS
  echo "Starting $LANGUAGE special"

  TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/role/flip_on.$LANGUAGE.md")"
  magick "$SRCPATH/cards/role/flip.png" \
    -pointsize 50 -fill black -font "build/static/OpenSans-SemiBold.ttf" -gravity North \
    -font "build/static/OpenSans-Regular.ttf" -size 556x \
    caption:"$TEXT" -geometry +0+230 \
    -composite "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png"

  TEXT="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/role/flip_off.$LANGUAGE.md")"
  magick "$SRCPATH/cards/role/flip.png" \
    -pointsize 50 -fill black -font "build/static/OpenSans-SemiBold.ttf" -gravity North \
    -font "build/static/OpenSans-Regular.ttf" -size 556x \
    caption:"$TEXT" -geometry +0+230 \
    -composite "$BUILDPATH/$LANGUAGE/images/cards/role/flip_off.png"


  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/credits"
  CATEGORY="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/credits/credits.$LANGUAGE.md")"
  CATEGORY="${CATEGORY^^}"
  magick "$SRCPATH/cards/credits/back.png" \
  -pointsize 100 -fill white -font "build/static/OpenSans-SemiBold.ttf" -gravity North -draw "text 0,150 '$CATEGORY'" \
  "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png"

  TITLES="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/credits/titles.$LANGUAGE.md")"
  PERSONS="$(sed 's/&quot;/\"/g' < "$SRCPATH/cards/credits/persons.$LANGUAGE.md")"

  #magick "src/cards/credits/front.png"     -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" -draw "text 130,180 'MITWIRKENDE'" 
  #-pointsize 40 -fill black -gravity Northwest -font "build/static/OpenSans-Regular.ttf" -size 450x     caption:"Autorin\nProduktion\nÜbersetzung\nErzählungen" -geometry +600+220 -composite 
  #-gravity Northeast -font "build/static/OpenSans-SemiBold.ttf" -size 450x     caption:"Autorin\nProduktion\nÜbersetzung\nErzählungen" -geometry +600+220    -composite "build/test.png"

  magick "$SRCPATH/cards/credits/front.png" \
    -pointsize 50 -fill white -font "build/static/OpenSans-SemiBold.ttf" \
    -draw "text 130,180 '$CATEGORY'" \
    -fill black -pointsize 40 -gravity Northwest -font "build/static/OpenSans-Regular.ttf" -size 450x \
    caption:"$TITLES" -geometry +600+220 -composite \
    -gravity Northeast -font "build/static/OpenSans-Semibold.ttf" -size 450x \
    caption:"$PERSONS" -geometry +600+220 -composite \
    "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png"


  magick montage -page A4 -density 300 -gravity North -reverse \
    "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
    -rotate 90 "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/special.jpg"

  magick montage -page A4 -density 300 -gravity North \
  "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
  -rotate 90 "$BUILDPATH/$LANGUAGE/images/cards/role/flip_off.png" \
  -tile 2x4 -geometry +2+2 "$BUILDPATH/$LANGUAGE/print/images/special_back.jpg"

# Print Sheets PDF
  magick -quality 94 -density 300 "$BUILDPATH/$LANGUAGE/print/images/"* -page A4 "$BUILDPATH/$LANGUAGE/print/cards.pdf"
  magick -quality 54 -density 96 "$BUILDPATH/$LANGUAGE/print/images/"* -page A4 "$BUILDPATH/$LANGUAGE/print/cards_compact.pdf"
done
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

  echo "Starting build cards slot 1 for professional print $LANGUAGE"

  mkdir -p "$BUILDPATH/$LANGUAGE/print/pdf"
  echo -n .

#    magick -density 305 \
#      -quality 255 \
#      -compress pxr24 \
#      "$SRCPATH/images/ad_front.png" \
#      -rotate 270 \
#      -profile "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" \
#      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pdf"

#exit 0
  if [ -f "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" ]; then
    magick -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      -rotate 90 \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      -rotate 270 \
      -profile "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pre.pdf"
  else
    magick -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/role/flip_on.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/selection/"[0-9][0-9].png \
      -rotate 90 \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      "$SRCPATH/images/ad_front.png" \
      -rotate 270 \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pre.pdf"
  fi
  echo -n .
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4  -dNOPAUSE -dCompressFonts=true -dQUIET -dBATCH -r305 \
    -sOutputFile="$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pdf" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pre.pdf"
  echo -n .


  rm "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.front.pre.pdf"
  echo -n .


  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/back1/"
  rm "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png
  for (( i=0; i<11; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/role/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back1/"$(printf "%02d" $i)".png"
  done

  for (( i=11; i<12; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/role/flip_off.png" "$BUILDPATH/$LANGUAGE/images/cards/back1/"$(printf "%02d" $i)".png"
  done

  for (( i=12; i<32; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/selection/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back1/"$(printf "%02d" $i)".png"
  done

  if [ -f "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" ]; then
    magick -density 305 \
      -quality 100 \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      -rotate 270 \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      -rotate 90 \
      -profile "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pre.pdf"
  else
    magick -density 305 \
      -quality 100 \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/back1/"[0-9][0-9].png \
      -rotate 270 \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$BUILDPATH/$LANGUAGE/images/cards/credits/back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      "$SRCPATH/images/ad_back.png" \
      -rotate 90 \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pre.pdf"
  fi
  echo -n .

  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4  -dNOPAUSE -dCompressFonts=true -dQUIET -dBATCH -r305 \
    -sOutputFile="$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pdf" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pre.pdf"
  echo -n .

  rm "$BUILDPATH/$LANGUAGE/print/pdf/cards_1.back.pre.pdf"


  echo .
done

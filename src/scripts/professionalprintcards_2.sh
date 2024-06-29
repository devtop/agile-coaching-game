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

  echo "Starting build cards slot 2 for professional print $LANGUAGE"

  mkdir -p "$BUILDPATH/$LANGUAGE/print/pdf"
  echo -n .
  
  if [ -f "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" ]; then
    magick -quality 85 -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/culture/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/method/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/mission/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/organization/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/event/"[0-9][0-9].png \
      -density 305 \
      "$SRCPATH/images/ad_front.png" \
      -density 305 \
      "$SRCPATH/images/ad_front.png" \
      -rotate 270 \
      -profile "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pre.pdf"
  else
    magick -quality 85 -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/culture/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/method/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/mission/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/organization/"[0-9][0-9].png \
      "$BUILDPATH/$LANGUAGE/images/cards/event/"[0-9][0-9].png \
      -density 305 \
      "$SRCPATH/images/ad_front.png" \
      -density 305 \
      "$SRCPATH/images/ad_front.png" \
      -density 305 \
      -rotate 270 \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pre.pdf"
  fi
  echo -n .

  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4  -dNOPAUSE -dCompressFonts=true -dQUIET -dBATCH -r305 \
    -sOutputFile="$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pdf" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pre.pdf"
  echo -n .


  rm "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.front.pre.pdf"
  echo -n .



  mkdir -p "$BUILDPATH/$LANGUAGE/images/cards/back2/"
  rm "$BUILDPATH/$LANGUAGE/images/cards/back2/"*.png
  for (( i=0; i<22; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/culture/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back2/"$(printf "%03d" $i)".png"
  done

  for (( i=22; i<38; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/method/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back2/"$(printf "%03d" $i)".png"
  done

  for (( i=38; i<56; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/mission/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back2/"$(printf "%03d" $i)".png"
  done

  for (( i=56; i<76; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/organization/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back2/"$(printf "%03d" $i)".png"
  done

  for (( i=76; i<108; i++ ))
  do
      cp "$BUILDPATH/$LANGUAGE/images/cards/event/back.png" "$BUILDPATH/$LANGUAGE/images/cards/back2/"$(printf "%03d" $i)".png"
  done


  if [ -f "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" ]; then
    magick -quality 85 -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/back2/"[0-9][0-9][0-9].png \
      -density 305 \
      "$SRCPATH/images/ad_back.png" \
      -density 305 \
      "$SRCPATH/images/ad_back.png" \
      -rotate 90 \
      -profile "$ROOTPATH/ext/ISOcoated_v2_300_eci.icc" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pre.pdf"
  else
    magick -quality 85 -density 305 \
      "$BUILDPATH/$LANGUAGE/images/cards/back2/"[0-9][0-9][0-9].png \
      -density 305 \
      "$SRCPATH/images/ad_back.png" \
      -density 305 \
      "$SRCPATH/images/ad_back.png" \
      -rotate 90 \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pre.pdf"
  fi
  echo -n .
  
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4  -dNOPAUSE -dCompressFonts=true -dQUIET -dBATCH -r305 \
    -sOutputFile="$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pdf" \
      "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pre.pdf"
  echo -n .

  rm "$BUILDPATH/$LANGUAGE/print/pdf/cards_2.back.pre.pdf"
  echo -n .

  echo " "
done

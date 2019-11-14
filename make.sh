#!/bin/bash

#set -x

IN="$1"
TMP=temp.scad

if [ ! -f "$IN" -o "${IN: -5}" != ".scad" ] ; then 
	echo "Usage: $0 <INPUT.scad>"
	exit 23
fi

OUT=$(dirname "$IN")/out
mkdir -p "$OUT"

cat "$IN" | grep "^\s*PART" | while read L ; do 
	NAME=$(echo "$L" | cut -f2- -d')' | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | tr -d ' []);' | tr -c '[:alnum:]\n' '_')

        echo "exporting $OUT/$NAME"
        echo -e "use <$IN>\n$L\n" > "$TMP"
        openscad -o "$OUT/$NAME.3mf" "$TMP"
        openscad -o "$OUT/$NAME.stl" "$TMP"
        openscad -o "$OUT/$NAME.png" --viewall --autocenter "$TMP"

done





#!/bin/bash

#set -x

IN="$1"
TMP=temp.scad

if [ ! -f "$IN" -o "${IN: -5}" != ".scad" ] ; then 
	echo "Usage: $0 <INPUT.scad>"
	exit 23
fi

#OUT=$(dirname "$IN")/out
OUT="${IN%.scad}"
MD="$OUT/README.md"
rm "$MD"
mkdir -p "$OUT"

cat "$IN" | while read L ; do 
	if echo "$L" | grep -q "^\s*PART" ; then
		CMD=$(echo "$L" | cut -f2- -d')' | sed -e 's/\s*//' )
		NAME=$(echo "$CMD" | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | sed -e 's/\(\[[0-9x ]*\),/\1x/g' | tr -d ' []);' | tr -c '[:alnum:]\n' '_' | sed -e 's/_*$//')
	
	        echo "exporting $OUT/$NAME"
	        echo -e "use <$IN>\n$CMD\n" > "$TMP"
		echo -e "\n**$CMD**\n\n![$NAME.png]($NAME.png)\n\n    use <$IN>\n    $CMD\n\n[$NAME.3mf]($NAME.3mf) [$NAME.stl]($NAME.stl)\n\n" >> "$MD"
		continue	
	        openscad -o "$OUT/$NAME.3mf" "$TMP"
	        openscad -o "$OUT/$NAME.stl" "$TMP"
	        openscad -o "$OUT/$NAME.png" --viewall --autocenter "$TMP"
	elif echo "$L" | grep -q "///" ; then
		echo "${L#*///}" >> "$MD"
	fi

done





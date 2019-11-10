#!/bin/bash

set -x

t="ConH"
for L in 10 15 25 30 ; do 
	openscad -Dtype="\"$t\"" -DL=$L -ostl/BB20_${t}_${L}.stl BB20.scad
done
t="ConH1"
for L in 5 10 15 20 25 30 ; do 
	openscad -Dtype="\"$t\"" -DL=$L -ostl/BB20_${t}_${L}.stl BB20.scad
done

for t in 345 Con ConS ; do 
	openscad -Dtype="\"$t\""  -ostl/BB20_${t}.stl BB20.scad
done


for y in 1 2 4 8; do 
	x=1
	for t in Brick45 ; do 
		openscad -Dtype="\"$t\"" -Ddim="[$y,$y,1]" -ostl/BB20_${t}_${y}x1.stl BB20.scad
		openscad -Dtype="\"$t\"" -Ddim="[1,1,$y]" -ostl/BB20_${t}_1x${y}.stl BB20.scad
	done
	for t in Beam BeamM Beam2M ; do 
		openscad -Dtype="\"$t\"" -Ddim="[1,$y,1]" -ostl/BB20_${t}_${x}x${y}.stl BB20.scad
	done
	for t in BeamU BeamL Plate PlateR ; do 
		for x in 1 2 ; do 
			openscad -Dtype="\"$t\"" -Ddim="[$x,$y,1]" -ostl/BB20_${t}_${x}x${y}.stl BB20.scad
		done
	done
done



#!/bin/bash

set -x

for t in Con ConS ConH ConH1 ; do 
	openscad -Dtype="\"$t\""  -ostl/BB20_${t}.stl BB20.scad
done


for y in 1 2 4 8; do 
	x=1
	for t in Beam BeamM Beam2M ; do 
		openscad -Dtype="\"$t\"" -Ddim="[1,$y,1]" -ostl/BB20_${t}_${x}x${y}.stl BB20.scad
	done
	for t in BeamU BeamL Plate PlateR ; do 
		for x in 1 2 ; do 
			openscad -Dtype="\"$t\"" -Ddim="[$x,$y,1]" -ostl/BB20_${t}_${x}x${y}.stl BB20.scad
		done
	done
done



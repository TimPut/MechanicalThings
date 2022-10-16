#!/bin/bash
N=50
STEPS=$1
PATTERN=%04d.png
for a in $(seq 0 $STEPS)
do
        ((i=i%N)); ((i++==0)) && wait
        FILE=$(printf "$PATTERN" $a)
        echo "$FILE" &
        /Users/timput/Desktop/OpenSCAD.app/Contents/MacOS/OpenSCAD \
          --colorscheme Nature \
	  --projection o \
          --imgsize=1080,1080 \
          --camera=0,0,0,55,0,25,$2 \
          "-D\$t=$a/$STEPS" \
          -o "$FILE" $3 \
#          >/dev/null 2>&1 &
          # --imgsize=3840,2160 \
done

#ffmpeg -i "$PATTERN" -c:v libx264 -r 30 -pix_fmt yuv420p animation.mp4

#!/bin/bash
h=1

for((j=1;j<=23; j=j+1))
do
        if ((h<=9))
        then
		wget -O Koleksi_0$h.jpg -a foto.log https://loremflickr.com/320/240/kitten
                for((i=1; i<h; i=i+1))
                do
			if cmp -s "./Koleksi_0$i.jpg" "./Koleksi_0$h.jpg"; then
                                rm "./Koleksi_0$h.jpg"
				h=$((h-1))
				j=$((j-1))
				break
                        fi
                done
        else
		wget -O Koleksi_$h.jpg -a foto.log https://loremflickr.com/320/240/kitten
                for((i=1; i<h; i=i+1))
                do
			if((i<10))
                        then
				if cmp -s "./Koleksi_0$i.jpg" "./Koleksi_$h.jpg"; then
				        rm "./Koleksi_$h.jpg"
				        h=$((h-1))
					j=$((j-1))
				        break
                                fi
                        else
				if cmp -s "./Koleksi_$i.jpg" "./Koleksi_$h.jpg"; then
				        rm "./Koleksi_$h.jpg"
				        h=$((h-1))
					j=$((j-1))
				        break
                                fi
                        fi
                done
        fi
        h=$((h+1))
done

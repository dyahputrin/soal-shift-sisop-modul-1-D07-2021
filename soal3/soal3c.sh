
#!/bin/bash

ytd=$(date -d yesterday +"%d-%m-%Y")
now=$(date +"%d-%m-%Y")
cek=$(ls Kucing_$ytd)
ck=$?

if (( ck == 0 ))
then 	
	
	mkdir "Kelinci_$now"
	h=1

	for((j=1;j<=24; j=j+1))
	do
		if ((h<=9))
		then
			wget -O Koleksi_0$h.jpg -a foto.log https://loremflickr.com/320/240/bunny
		        for((i=1; i<q; i=i+1))
		        do
				if cmp -s "./Koleksi_0$i.jpg" "./Koleksi_0$h.jpg"; then
		                        rm "./Koleksi_0$h.jpg"
					h=$((h-1))     
					break
		                fi
		        done
		else
			wget -O Koleksi_$h.jpg -a foto.log https://loremflickr.com/320/240/bunny
		        for((i=1; i<h; i=i+1))
		        do
				if((i<10))
		                then
					if cmp -s "./Koleksi_0$i.jpg" "./Koleksi_$h.jpg"; then
						rm "./Koleksi_$h.jpg"
						h=$((h-1))
						break
		                        fi
		                else
					if cmp -s "./Koleksi_$i.jpg" "./Koleksi_$h.jpg"; then
						rm "./Koleksi_$h.jpg"
						h=$((h-1))
						break
		                        fi
		                fi
		        done
		fi
		h=$((h+1))
	done
	mv ./Koleksi_* "./Kelinci_$now/"
	mv ./foto.log "./Kelinci_$now/"
else
	mkdir "Kucing_$now"
	h=1

	for((j=1;j<=24; j=j+1))
	do
		if ((h<=9))
		then
			wget -O Koleksi_0$h.jpg -a foto.log https://loremflickr.com/320/240/kitten
		        for((i=1; i<q; i=i+1))
		        do
				if cmp -s "./Koleksi_0$i.jpg" "./Koleksi_0$h.jpg"; then
		                        rm "./Koleksi_0$h.jpg"
					h=$((h-1))     
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
						break
		                        fi
		                else
					if cmp -s "./Koleksi_$i.jpg" "./Koleksi_$h.jpg"; then
						rm "./Koleksi_$h.jpg"
						h=$((h-1))
						break
		                        fi
		                fi
		        done
		fi
		h=$((h+1))
	done
	mv ./Koleksi_* "./Kucing_$now/"
	mv ./foto.log "./Kucing_$now/"
fi







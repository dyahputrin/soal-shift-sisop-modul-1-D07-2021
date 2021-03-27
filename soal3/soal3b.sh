#!/bin/bash

sekarang=$(date +"%d-%m-%Y")
mkdir "$sekarang"

bash ./soal3a.sh

mv ./Koleksi_* "./$sekarang"
mv ./foto.log "./$sekarang"

#!/bin/bash

#1a
cat syslog.log | grep 'ERROR\|INFO' | cut -d ' ' -f 6-30 | sort
#atau
#cat syslog.log | cut -d ' ' -f 6-30 | sort 

#1b
#menggunakan cara manual, namun untuk mengecek  total error tiap pesan bisa dilihat dengan cara berikut:
#cat syslog.log | grep "ERROR" | cut -d ' ' -f 7-9 | sort | uniq -c | sort -nr

koneksitxt="Connection to DB failed"
koneksi=$(cat syslog.log | grep -c  "Connection to DB failed")

permissiontxt="Permission denied while closing ticket"
permission=$(cat syslog.log | grep -c "Permission denied while closing ticket")

modiftxt="The ticket was modified while updating"
modif=$(cat syslog.log | grep -c "The ticket was modified while updating")

existtxt="Ticket doesn't exist"
exist=$(cat syslog.log | grep -c "Ticket doesn't exist")

timeouttxt="Timeout while retrieving information"
timeout=$(cat syslog.log | grep -c "Timeout while retrieving information")

triedtxt="Tried to add information to closed ticket"
tried=$(cat syslog.log | grep -c "Tried to add information to closed ticket")

#printf "%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n" "$timeouttxt" "$timeout" "$koneksitxt" "$koneksi" "$triedtxt" "$tried" "$permissiontxt" "$permission" "$modiftxt" "$modif" "$existtxt" "$exist"

#1c
#menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
user=$(grep -oP "(?<=\().*(?=\))" syslog.log | sort | uniq)
#bisa juga ditambahkan uniq-c untuk melihat toal kemunculannya
#grep -oP "(?<=\().*(?=\))" syslog.log | sort | uniq -c
#untuk mencari jumlah kemunculan lognya lebih lengkap pada poin e
#userinfo=$(grep -E "INFO.*($username))" syslog.log | wc -l)
#usererror=$(grep -E "ERROR.*($username))" syslog.log | wc -l)

#1d
printf "ERROR,COUNT\n" >> error_message.csv
printf "%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n" "$timeouttxt" "$timeout" "$koneksitxt" "$koneksi" "$triedtxt" "$tried" "$permissiontxt" "$permission" "$modiftxt" "$modif" "$existtxt" "$exist" >>  error_message.csv

#1e
printf "USERNAME,INFO,ERROR\n" >> user_statistic.csv
#karena variable user sudah diurutkan sebelumnya jadi tidak perlu diurutkan lagi(Pada Poin C)
echo "$user" | while read username
do
    userinfo=$(grep -E "INFO.*($username))" syslog.log | wc -l)
    usererror=$(grep -E "ERROR.*($username))" syslog.log | wc -l)
    echo "$username,$userinfo,$usererror"
done >> user_statistic.csv;

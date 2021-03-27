
### Soal 1
### A. Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya
Untuk mengambil beberapa informasi saja atau kolom, dari file syslog.log saya menggunakan cara cut, yaitu langsung mengambil saja kolom ke 6-habis karena untuk format jenis log, pesan log, dan username dimulai dari kolom ke 6 yaitu jenis log, kolom ke 7-9 pesan log dan >= 10 username, sehingga saya hanya menggunakan cara seperti berikut
```
cat syslog.log | grep 'ERROR\|INFO' | cut -d ' ' -f 6-30 | sort
atau
cat syslog.log | cut -d ' ' -f 6-30 | sort 
```
```cat syslog.log``` digunakan untuk membaca konten yang ada didalam file _syslog.log_. apabila menggunakan ```grep 'ERROR\|INFO'```maka akan mengeksekusi semua baris yang terdapat kata ERROR atau INFO, namun karena isi dari file syslog.log setiap baris memiliki kata ERROR atau INFO jadi bisa menggunakan cara ke-2 dengan menghapus ```grep 'ERROR\|INFO'```, lalu untuk ```cut -d ' ' -f 6-30``` yaitu memotong atau hanya mengambil pada kolom 6-30, karena diatas sudah dijelaskan juga letak informasi yang dibutuhkan terdapat pada kolom berapa saja, dan juga pada soal juga diberitahu pola isi dari file syslog.log yaitu cut
```<log_type> <log_message> (<username>)```

### B. Menampilkan semua pesan error yang muncul beserta jumlah kemunculannya
Untuk menampilkan pesan error, saya menggunakan cara manual. namun untuk mengecek apakah apabila dilakukan manual itu datanya benar saya menggunakan cara seperti berikut<br />
```cat syslog.log | grep "ERROR" | cut -d ' ' -f 7-9 | sort | uniq -c | sort -nr```<br />
alasan menggunakan cara manual dari pada cara diatas, adalah apabila menggunakan cara diatas hanya akan memotong kolom 7-9 yang membuat salah adalah karena hanya bisa memotong hingga kolom ke 9, karena setiap pesan error terletak dari kolom 7 hingga 12 namun ada pesan error yang terletak pada kolom 10, sehingga apabila tetap memotong kolom 7-12 maka akan keluar usernamenya sedangkan kita hanya membutuhkan pesan error saja, sehingga saya menggunakan cara manual seperti berikut: <br />
```
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
```
Cara diatas yaitu menyimpan semua kata error yang terdapat pada file syslog.log ke dalam variable dan juga terdapat variable baru juga untuk menyimpan banyaknya error yang dimiliki setiap pesan error,<br/> sebagai contoh ```koneksi=$(cat syslog.log | grep -c  "Connection to DB failed")``` yaitu menghitung total yang setiap barisnya memiliki kalimat Connection to DB failed, menghitung totalnya menggunakan ```grep -c``` karena kita bisa menghitung total dan juga memilih kata yang kita cari <br/> <br/>
Karena semua total dan pesan error sudah disimpan ke dalam variable maka saya tinggal menampilkan datanya menggunakan echo/printf, seperti berikut: <br/>
```
printf "%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n" "$timeouttxt" "$timeout" "$koneksitxt" "$koneksi" "$triedtxt" "$tried" "$permissiontxt" "$permission" "$modiftxt" "$modif" "$existtxt" "$exist"
```

### C. Menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya
```user=$(grep -oP "(?<=\().*(?=\))" syslog.log | sort | uniq)```<br/>
Sebelum menampilkan jumlah error dan info setiap usernya, yang perlu dilakukan adalah mengambil data usernamenya terlebih dahulu,
mengambil data username pada syslog.log yaitu dengan cara ```grep -oP "(?<=\().*(?=\))"``` yang mana memiliki maksud/arti yaitu mengambil semua kata/data yang terletak didalam kurung contoh, ```(text)``` sehingga semua data/kata yang terletak didalam kurung akan di pilah/ambil, dan lakukan ```sort | uniq``` sort(diurutkan) digunakan agar bisa melakukan ```uniq```, ```uniq``` digunakan untuk mengambil kata2 yang sama dan dijadikan 1, namun untuk melakukan ```uniq``` harus melakukan ```sort``` atau diurutkan terlebih dahulu. setelah selesai mendapat data usernya, selanjutnya menghitung jumlah error dan info setiap usernya dilanjutkan pada poin e

### D. Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv
Karena pada poin b tadi semua yang kita butuhkan sudah kita masukkan ke variable, maka sekarang kita tinggal memanggilnya menggunakan printf dan menampilkan informasi tersebut ke dalam file bernama error_message.csv<br/>
```
printf "ERROR,COUNT\n" >> error_message.csv
printf "%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n%s,%d\n" "$timeouttxt" "$timeout" "$koneksitxt" "$koneksi" "$triedtxt" "$tried" "$permissiontxt" "$permission" "$modiftxt" "$modif" "$existtxt" "$exist" >>  error_message.csv
```
untuk memasukkan informasi-informasi tersebut ke dalam _error_message.csv_ cukup menggunakan cara berikut ```>> error_message.csv```

### E. Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv
```
printf "USERNAME,INFO,ERROR\n" >> user_statistic.csv
#karena variable user sudah diurutkan sebelumnya jadi tidak perlu diurutkan lagi(Pada Poin C)
echo "$user" | while read username
do
    userinfo=$(grep -E "INFO.*($username))" syslog.log | wc -l)
    usererror=$(grep -E "ERROR.*($username))" syslog.log | wc -l)
    echo "$username,$userinfo,$usererror"
done  >> user_statistic.csv;
```
Pertama yang dilakukan adalah memasukkan header ke dalam file user_statistic.csv ```printf "USERNAME,INFO,ERROR\n" >> user_statistic.csv``` selanjutnya, untuk bisa mendapatkan kemunculuan jumlah error dan info, yaitu melakukan perulangan while yang mana ```echo "$user"``` dijadikan sebagai input dalam perulangan ini. lalu untuk menghitung jumlah error dan jumlah infonya kita melakukan operasi didalam while yaitu menggunaan ```grep``` yang mencari kata INFO/ERROR pada setiap baris berdasarkan username ```$(grep -E "INFO.*($username))" syslog.log | wc -l)``` dan data usernya dipindahkan atau disalin ke variable username. Dan untuk mendapatkan jumlahnya menggunakan ```wc -l``` atau fungsi count untuk menghitung jumlahnya. dan masing2 operasi tersebut dimasukkan ke dalam variable dan tinggal memanggilnya dengan ```echo```<br/>

Untuk memasukkan informasi tersebut ke dalam file user_statistic.csv yaitu menggunakan ```>> user_statistic.csv``` diakhir perulangan whilenya.

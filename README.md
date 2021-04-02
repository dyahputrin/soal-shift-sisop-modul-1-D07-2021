### Laporan Resmi Soal Shift Modul 1 (D07)

----------------------

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

----------------------

### Soal 2
Pada soal 2, diberikan sebuah case dimana kita diminta untuk **mencari beberapa kesimpulan dari data penjualan** startup bernama "TokoShiSop". Data penjualan TokoShiSop ini disediakan  dalam file bernama "Laporan-TokoShiSop.tsv". <br />
Pada file Laporan-TokoShiSop.tsv terdapat 21 fields sebagai berikut:
No. | Nama Kolom
--- | ------------------
1   | Row ID        
2   | Order ID      
3   | Order Date    
4   | Ship Date     
5   | Ship Mode     
6   | Customer ID   
7   | Customer Name 
8   | Segment       
9   | Country       
10  | City          
11  | State         
12  | Postal Code  
13  | Region        
14  | Product ID    
15  | Category     
16  | Sub-Category  
17  | Product Name  
18  | Sales         
19  | Quantity      
20  | Discount      
21  | Profit        

**Penyelesaian pada soal ini menggunakan bash, AWK, dan command pendukung lainnya <br />**

### A : Mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka pilih Row ID yang paling besar) <br />
```
LC_NUMERIC=C awk -v profitPercentage=0 costPrice=0' 
BEGIN { FS=OFS="\t"; max=0; rowIDmax=1}
{
 costPrice=$18-$21;
 profitPercentage=($21/costPrice)*100;
 
 if(profitPercentage > max) {
 max=profitPercentage;
 }
 
 if(profitPercentage == max) {
  rowIDmax = $1;
 }
 
 #{print $1, profitPercentage}
 
}
END {printf ("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.4f %c.\n\n", rowIDmax, max, 37)}' Laporan-TokoShiSop.tsv > hasil.txt
```
Untuk mengetahui kesimpulan tersebut, pertama kita sediakan sebuah variable max yang diinisialisasi nilainya sama dengan 0. Lalu, hitung profitPercentage dari setiap row sesuai dengan rumus yang ada. Setelah itu, kita berikan sebuah conditional statement yaitu, apabila nilai profitPercentage lebih besar daripada nilai max, nilai dari variabel max diganti dengan nilai profitPercentage saat ini. Untuk mendapatkan Row ID, di awal kita buat variabel bernama rowIDmax yang diinisialisasi nilainya sama dengan 1. Setelah itu, kita berikan juga conditional statement yaitu, apabila nilai profitPercentage saat ini sama dengan nilai max saat ini, maka nilai dari variabel rowIDmax diganti dengan $1 (Row ID). Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator ```>>```.

### B : Mengetahui nama customer pada transaksi tahun 2017 di Albuquerque <br />
```
awk '
BEGIN{FS=OFS="\t"; printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")}
/Albuquerque/ && /-17/ {print $7|"uniq"}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Untuk mengetahui kesimpulan tersebut, kita dapat print baris unique Customer Name ($7) yang mengandung string "Albuquerque" dan "-17" (tahun 2017 pada format tgl). Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator ```>```.

### C : Mengetahui segment customer dan jumlah transaksinya yang paling sedikit <br />
```
awk '
BEGIN { countC=0;countHO=0;countCP=0;min=0; Segmen="Consumer"; FS=OFS="\t"}
{
 {
  if($8=="Consumer") countC++;
  if($8=="Home Office") countHO++;
  if($8=="Corporate") countCP++;
 }
 min=countC;
 if(countHO < min) {
  min=countHO;
  Segmen = "Home Office";
 }
 if(countCP < min) {
  min=countCP;
  Segmen = "Corporate"
 }	
}
END {printf("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", Segmen, min)}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Untuk mengetahui kesimpulan tersebut, kita dapat mendapatkannya dengan menghitung kemunculan tiap segment customer pada data penjualan. Hal itu dapat dialkukan dengan menghitung kemunculan masing-masing string pada $8 (segment customer) dan menyimpannya pada variabel yang berbeda-beda. Lalu, kita bandingkan nilai dari hasil perhitungannya untuk menentukan nilai yang paling kecil. Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator ```>```.

### D : Mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut <br />
```
LC_NUMERIC=C awk '
BEGIN { totalC=0; totalE=0; totalS=0; totalW=0; region="?"; FS=OFS="\t" }
{
 if($13=="Central") {
  totalC = totalC + $21;
 }
 else if($13=="East") {
  totalE = totalE + $21;
 }
 else if($13=="South") {
  totalS = totalS + $21;
 }
 else if($13=="West") {
  totalW = totalW + $21;
 }
 
 min=999999999999;
 if(totalC < min) {
  min = totalC;
  region = "Central";
 }
 if(totalE < min) {
  min = totalE;
  region = "East";
 }
 if(totalS < min) {
  min = totalS;
  region = "South";
 }
 if(totalW < min) {
  min = totalW;
  region = "West";
 }
}
END {printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n", region, min)}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Untuk mengetahui total keuntungan dari masing-masing region, kita dapat menghitung jumlah $21 (Profit) berdasarkan regionnya masing-masing. Pengkalsifikasian region dapat dilakukan dengan mengecek string "Central", "East", "West", "South" dengan $13 (Region). Lalu, kita dapat bandingkan jumlah profit dari masing-masing region dan temukan yang paling sedikit. Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator ```>```.

## Kendala
![alt text](https://github.com/dyahputrin/image/blob/273fa88933772fc9db3608b46c0d4eae5ccac6dd/error1.png)
Pada saat awal mengerjakan soal 2a, terdapat sedikit kesulitan saat ingin mengambil nilai dari kolom "Profit" menggunakan $21 karena output yang dikeluarkan tidak sesuai dengan ekspektasi. Ternyata, apabila kita hanya menuliskan code $21, output yang dikeluarkan adalah karakter ke-21 yang dipisahkan dengan space (by default). Oleh karena itu, apabila separator yang kita inginkan berupa "tab" kita perlu menambahkan code ```FS=OFS="\t"``` di awal.
![alt_text](https://github.com/dyahputrin/image/blob/1b4d2346d878da7e4104a852014ebb9b7887c6e4/error2.png)
Kendala selanjutnya ialah melakukan operasi aritmatika dengan angka desimal dimana separator nya menggunakan tanda baca titik. Dari gambar diatas, apabila kita mengambil sample dan menghitung secara manual, maka hasil yang dikeluarkan kurang tepat. Oleh karena itu, perlu ditambahkan code ```LC_NUMERIC=C```.
![alt_text](https://github.com/dyahputrin/image/blob/1b4d2346d878da7e4104a852014ebb9b7887c6e4/error3.png)
Kendala yang ketiga adalah pada soal 2c. Terdapat sedikit kesulitan saat ingin menampilkan nama para customer tanpa perlu perulangan. Namun, hal itu dapat diatasi dengan menambahkan ``` "uniq" ``` pada saat melakukan print.

----------------------

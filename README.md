# soal-shift-sisop-modul-1-D07-2021
## Laporan Penjelasan dan Penyelesaian Soal Shift Modul 1 <br />
Kelompok D07:
1. Dyah Putri Nariswari (05111940000047)
2. Migel Aulia Mandiri Putra (05111940000194)
3. Gian Ega Wijaya (05111940000214)

### Soal 2
Pada soal 2, diberikan sebuah case dimana kita diminta untuk **mencari beberapa kesimpulan dari data penjualan** startup bernama "TokoShiSop". Data penjualan TokoShiSop ini disediakan  dalam file bernama "Laporan-TokoShiSop.tsv". <br />
Pada file Laporan-TokoShiSop.tsv terdapat 21 fields sebagai berikut:
1. Row ID
2. Order ID
3. Order Date
4. Ship Date
5. Ship Mode
6. Customer ID
7. Customer Name
8. Segment
9. Country
10. City
11. State
12. Postal Code
13. Region
14. Product ID
15. Category
16. Sub-Category
17. Product Name
18. Sales
19. Quantity
20. Discount
21. Profit

**Penyelesaian pada soal ini menggunakan bash, AWK, dan command pendukung lainnya <br />**

**Kesimpulan 1 : Mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka pilih Row ID yang paling besar) <br />**
Untuk mengetahui kesimpulan tersebut, pertama kita sediakan sebuah variable max yang diinisialisasi nilainya sama dengan 0. Lalu, hitung profitPercentage dari setiap row sesuai dengan rumus yang ada. Setelah itu, kita berikan sebuah conditional statement yaitu, apabila nilai profitPercentage lebih besar daripada nilai max, nilai dari variabel max diganti dengan nilai profitPercentage saat ini. Untuk mendapatkan Row ID, di awal kita buat variabel bernama rowIDmax yang diinisialisasi nilainya sama dengan 1. Setelah itu, kita berikan juga conditional statement yaitu, apabila nilai profitPercentage saat ini sama dengan nilai max saat ini, maka nilai dari variabel rowIDmax diganti dengan $1 (Row ID). Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator " >> ".

**Kesimpulan 2 : Mengetahui nama customer pada transaksi tahun 2017 di Albuquerque <br />**
Untuk mengetahui kesimpulan tersebut, kita dapat print baris yang mengandung pola yang dimasukkan awk ' /Albuquerque/ && /-17/ {print $7|"uniq"} ' Laporan-TokoShsSop.tsv <br />
Pola tersbut memiliki arti dimana kita mengeluarkan output berupa unique Customer Name ($7) yang mengandung string "Albuquerque" dan "-17" (tahun 2017 pada format tgl). Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator " > ".

**Kesimpulan 3 : Mengetahui segment customer dan jumlah transaksinya yang paling sedikit <br />**
Untuk mengetahui kesimpulan tersebut, kita dapat mendapatkannya dengan menghitung kemunculan tiap segment customer pada data penjualan. Hal itu dapat dialkukan dengan menghitung kemunculan masing-masing string pada $8 (segment customer) dan menyimpannya pada variabel yang berbeda-beda. Lalu, kita bandingkan nilai dari hasil perhitungannya untuk menentukan nilai yang paling kecil. Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator " > ".

**Kesimpulan 4 : Mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut <br />**
Untuk mengetahui total keuntungan dari masing-masing region, kita dapat menghitung jumlah $21 (Profit) berdasarkan regionnya masing-masing. Pengkalsifikasian region dapat dilakukan dengan mengecek string "Central", "East", "West", "South" dengan $13 (Region). Lalu, kita dapat bandingkan jumlah profit dari masing-masing region dan temukan yang paling sedikit. Setelah itu, keluarkan output nya sesuai format yang telah ditentukan dan redirect ke file hasil.txt dengan operator " > ".

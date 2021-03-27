# soal 2a
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

# soal 2b
awk '
BEGIN{FS=OFS="\t"; printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")}
/Albuquerque/ && /-17/ {print $7|"uniq"}' Laporan-TokoShiSop.tsv >> hasil.txt

# soal 2c
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

# soal 2d
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

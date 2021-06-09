# hse21_H3K27ac_G4_human

## Анализ пиков гистоновой метки

У меня разбирается метка H3K27ac и тип клетки SK-N-SH. Ген hg38. Эксперименты ENCFF138VUT и ENCFF188BQP.    

Скачиваем данные:    
wget https://www.encodeproject.org/files/ENCFF188BQP/@@download/ENCFF188BQP.bed.gz.    
wget https://www.encodeproject.org/files/ENCFF138VUT/@@download/ENCFF138VUT.bed.gz.    

И оставляем первые 5 столбцов(остальные не нужны):    
cat ENCFF138VUT.bed | cut -f1-5 > "H3K27ac_SK-N-SH.ENCFF138VUT.hg38.bed".    
cat ENCFF188BQP.bed | cut -f1-5 > "H3K27ac_SK-N-SH.ENCFF188BQP.hg38.bed".     

Тк ген 38-ой, а не 19-ый, его нужно сконвертировать. Для конвертации выполняем:    
wget https://hgdownload.cse.ucsc.edu/goldenpath/hg38/liftOver/hg38ToHg19.over.chain.gz.    
liftOver H3K27ac_SK-N-SH.ENCFF138VUT.hg38.bed hg38ToHg19.over.chain.gz H3K27ac_SK-N-SH.ENCFF138VUT.hg19.bed H3K27ac_SK-N-SH.ENCFF138VUT.unmapped.bed.    
liftOver H3K27ac_SK-N-SH.ENCFF188BQP.hg38.bed hg38ToHg19.over.chain.gz H3K27ac_SK-N-SH.ENCFF188BQP.hg19.bed H3K27ac_SK-N-SH.ENCFF188BQP.unmapped.bed.    

Теперь воспользуемся кодом [draw_hist.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/draw_hist.R) для построения гистограмм и подсчета числа пиков.     

Количество пиков по файлам:     
ENCFF188BQP.hg19 - 109028.    
ENCFF138VUT.hg19 - 69227.    
ENCFF188BQP.hg38 - 109149.    
ENCFF138VUT.hg38 - 69317.    
 
Гистограммы:     
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.H3K27ac_SK-N-SH.ENCFF188BQP.hg19.png).    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.H3K27ac_SK-N-SH.ENCFF138VUT.hg19.png).    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.H3K27ac_SK-N-SH.ENCFF188BQP.hg38.png).    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.H3K27ac_SK-N-SH.ENCFF138VUT.hg38.png).    

Выкидываем длинные пики:    
Порог длины - 5000.    
Скрипт для реализации тот же, просто надо посмотреть чуть дальше [draw_hist.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/draw_hist.R).       

Количество пиков в фильтрованных файлах:     
ENCFF188BQP.hg19 - 107692.    
ENCFF138VUT.hg19 - 66883.    

Гистограммы:     
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/filter_peaks.H3K27ac_SK-N-SH.ENCFF188BQP.hg19.filtered.hist.png).    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/filter_peaks.H3K27ac_SK-N-SH.ENCFF138VUT.hg19.filtered.hist.png).   


(Тут расположение относительно аннотированных генов).    


Теперь объединяем два отфильтрованных эксперимента с помощью команды:     
cat  *.hg19.filtered.bed  |   sort -k1,1 -k2,2n   |   bedtools merge   >  H3K27ac_SK-N-SH.merge.hg19.bed.     

Данные проверил, мердж получился корректным. Ссылка на сессию будет позже.


## Анализ участков вторичной структуры ДНК

Скачиваю файлы со вторичной структурой(я выбрал G4_seq_Li_K), тк у меня их два, то надо будет их объединить с помощью команды:    
cat  GSM3003539_Homo_all_w15_th-1_minus.hits.max.K.w50.25.bed GSM3003539_Homo_all_w15_th-1_plus.hits.max.K.w50.25.bed  |   sort -k1,1 -k2,2n   |   bedtools merge   >  Homo_all.bed.      

Теперь снова с помощью скрипта [draw_hist.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/draw_hist.R) строим гистограмму.    

Количество пиков в мердже:     
Homo_all - 428654.    

Гистограмма:       
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.Homo_all.png).    


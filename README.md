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


Расположение относительно аннотированных генов:    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/BQP.png).    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/VUT.png).    


Теперь объединяем два отфильтрованных эксперимента с помощью команды:     
cat  *.hg19.filtered.bed  |   sort -k1,1 -k2,2n   |   bedtools merge   >  H3K27ac_SK-N-SH.merge.hg19.bed.     

Данные проверил, мердж получился корректным. Ссылка на сессию будет дальше в ридми.    

Количество пиков в объединении:     
merge.hg19 - 107692. 

(Тут будет гистограмма)

## Анализ участков вторичной структуры ДНК

Скачиваю файлы со вторичной структурой(я выбрал G4_seq_Li_K), тк у меня их два, то надо будет их объединить с помощью команды:    
cat  GSM3003539_Homo_all_w15_th-1_minus.hits.max.K.w50.25.bed GSM3003539_Homo_all_w15_th-1_plus.hits.max.K.w50.25.bed  |   sort -k1,1 -k2,2n   |   bedtools merge   >  Homo_all.bed.      

Теперь снова с помощью скрипта [draw_hist.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/draw_hist.R) строим гистограмму.    

Количество пиков в мердже:     
Homo_all - 428654.    

Гистограмма:       
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.Homo_all.png).    

Расположение относительно аннотированных генов:    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/all.png).    


## Анализ пересечений гистоновой метки и вторичной структуры ДНК

Для начала с помощью такой команды строим пересечение структуры ДНК и гистоновой метки:      
bedtools intersect  -a Homo_all.bed   -b  H3K27ac_SK-N-SH.merge.hg19.bed  >  H3K27ac_SK-N-SH.intersect_with_Homo_all.bed.     

Снова с помощью скрипта [draw_hist.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/draw_hist.R) строим гистограмму.  
Количество пиков в мердже:     
Homo_all - 42295.   

Гистограмма:       
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/len_hist.H3K27ac_SK-N-SH.intersect_with_Homo_all.png).    


Расположение относительно аннотированных генов:    
![alt_text](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/images/intersect.png).    


Теперь визуализируем все полученные результаты в одной сессии геномного браузера, [ссылка](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr1%3A197718725-198468724&hgsid=1124087857_3az0ARxaThJAVNnPUXaAM1OphAwo). 

(Тут нужно 1-2 скрина) 


Для того, чтобы ассоциировать пересечения с ближайшими генами воспользуемся скриптом [ChIPpeakAnno.R](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/src/ChIPpeakAnno.R).    
Файл ассоциаций: [intersect_with_Homo_all.genes.txt](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/data/H3K27ac_SK-N-SH.intersect_with_Homo_all.genes.txt).      
Файл уникальных генов: [intersect_with_Homo_all.genes_uniq.txt](https://github.com/DoctorWho57-179/hse21_H3K27ac_G4_human/blob/main/data/H3K27ac_SK-N-SH.intersect_with_Homo_all.genes_uniq.txt).     

Всего ассоциированных генов 11478, из них 7117 уникальных.

(тут будет GO анализ)

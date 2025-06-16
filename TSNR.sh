#!/bin/bash
##calculate mean and standard deviation of *realigned* functional images with fslmaths,
##divide mean by standard deviation image (=TSNR image)
##and then extract the average of non-zero voxels of the resulting image with fslstats

basepath="/mnt/DATA/MS/DPARSF/FunImgAR/"
outpath="/mnt/DATA/MS/DPARSF/"

for i in $(ls ${basepath})
do
echo $i >> ${outpath}/1_subj_list.txt
cd ${basepath}/${i}
#mv ra${i}-d0600.nii.gz ${i}.nii.gz
#rm -r vol0299.nii.gz
tcsh -c "fslmaths ra${i}.slicemocoxy_afni.slomoco_pestica.nii -Tstd std_${i}.nii.gz"
tcsh -c "fslmaths ra${i}.slicemocoxy_afni.slomoco_pestica.nii -Tmean mean_${i}.nii.gz"
tcsh -c "fslmaths mean_${i}.nii.gz -div std_${i}.nii.gz TSNR_${i}.nii.gz"
tcsh -c "fslstats TSNR_${i}.nii.gz -l 0 -M" >> TSNR_${i}.txt
cat TSNR_${i}.txt >> ${outpath}/2_TSNR_output.txt
done

cd ${outpath}
paste -d '\t' ./?_*.txt | column >> TSNR_table.txt
sed -i "1i participant\tTSNR" ${outpath}/TSNR_table.txt
rm ${outpath}/1_subj_list.txt
rm ${outpath}/2_TSNR_output.txt

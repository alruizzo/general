#!/bin/bash

## A.L.R.R. (@alruizzo, 21.08.2024)
## Script to add the prefix 'sub' to the participants' folders and the participants' names...
## ...to their files. Only anatomical ('mprage') and diffusion-weighted imaging ('dMRI')...
## ...done this time (for reasons of this particular project).

## Define directories where the data are (once, baseline, once followup)
SOURCEPATH=/home/data/dsf4b/followup

## Loop through each participant's folder and then through each MRI folder and files to...
## ...change the participant ánd imaging folder names, and their respective file names to...
## ...match BIDS standard as closely as possible
for SUBJECT in ${SOURCEPATH}/*
do
	SUBJECTNAME=`basename $SUBJECT`
	cd $SUBJECT
	for folder in ${SUBJECT}/*
	do
		FOLDERNAME=`basename $folder`
		if [[ $FOLDERNAME == dMRI* ]]	# diffusion-weighted imaging folders
			then
			suffix="${FOLDERNAME//dMRI_1p5_dir103/}" # leaving phase encoding info
			cd $folder
			for file in ${folder}/*
			do
				filename=`basename $file`
				ext="${file##*.}"	# getting the files' extension
				if [[ $filename == *nii* ]]	# adding .nii to extension
				then
				mv $file ${folder}/sub-${SUBJECTNAME}-dwi${suffix}.nii.${ext}
				else
				mv $file ${folder}/sub-${SUBJECTNAME}-dwi${suffix}.${ext}
				fi
			done
			mv $folder ${SOURCEPATH}/${SUBJECTNAME}/dwi${suffix} # changing folder's name
		elif [[ $FOLDERNAME == mpr* ]]	# anatomical, T1-weighted folder
		then
		cd $folder
		for file in ${folder}/*
		do
			filename=`basename $file`
			ext="${file##*.}"
			if [[ $filename == *nii* ]]
			then
			mv $file ${folder}/sub-${SUBJECTNAME}-T1w.nii.${ext}
			else
			mv $file ${folder}/sub-${SUBJECTNAME}-T1w.${ext}
			fi
		done
		mv $folder ${SOURCEPATH}/${SUBJECTNAME}/anat # changing folder's name
		fi
	done
mv $SUBJECT ${SOURCEPATH}/sub-${SUBJECTNAME}	# changing participants' folders names
done

echo Done!


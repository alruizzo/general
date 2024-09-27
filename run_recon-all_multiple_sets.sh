#!/bin/bash

## A.L.R.R. (@alruizzo, 22.08.2024)
## Script to run recon-all for all data sets of both baseline and followup

## Define source directory and the two subdirectories (for baseline and...
## ...follow-up).
SOURCEPATH=/home/data/dsf4b
SUBDIR1=baseline
SUBDIR2=followup

## Create the freesurfer subjects' directory
mkdir -p $SOURCEPATH/freesurfer/subjects

## Change the default 'SUBJECTS_DIR' directory of Freesurfer
export SUBJECTS_DIR=$SOURCEPATH/freesurfer/subjects

## Loop to get into each participant's folder, get the participant's name...
## ...check that we're in a participant's folder (and not other files),... 
## ...perform recon-all in the baseline data first, then enter each...
## ...participant's folder and check whether there is a 'followup' folder...
## ...If so, then also perform recon-all in the follow-up data. Note the...
## ..."__1" and "__2" corresponding to 'baseline' and 'follow-up,'...
## ...respectively, next to the participant's name and before '-T1w.'
for SUBJECT in ${SOURCEPATH}/*
do
	SUBJECTNAME=`basename $SUBJECT`
	if [[ -d $SUBJECT ]]
	then
	recon-all -all -s ${SUBJECTNAME}_1 -i ${SUBJECT}/${SUBDIR1}/anat/${SUBJECTNAME}__1-T1w.nii.gz
	cd $SUBJECT
	if [[ -d $SUBDIR2 ]]
	then
	recon-all -all -s ${SUBJECTNAME}_2 -i ${SUBJECT}/${SUBDIR2}/anat/${SUBJECTNAME}__2-T1w.nii.gz
	fi
	fi
done

echo Done!


#!/bin/bash

## A.L.R.R. (@alruizzo, 25.09.2024)
## Script to calculate the base template (in case of two time points)

## Define source directory and the two subdirectories (for baseline and...
## ...follow-up).
SOURCEPATH=/home/data/dsf4b
SUBDIR1=baseline
SUBDIR2=followup

## Change the default 'SUBJECTS_DIR' directory of Freesurfer
export SUBJECTS_DIR=$SOURCEPATH/freesurfer/subjects

## Loop to get into each participant's folder, get the participant's name...
## ...check that we're in a participant's folder (and not other files). If... 
## ...the participant has both timepoints (according to the source dir),...
## ...do template with both. Otherwise, include only one. Again, the "__1"...
## ...and "__2" correspond to 'baseline' and 'follow-up,' respectively.
for SUBJECT in ${SOURCEPATH}/*
do
	SUBJECTNAME=`basename $SUBJECT`
	if [[ $SUBJECTNAME == sub* ]]
	then
	if [[ -d ${SUBJECT}/$SUBDIR2 ]]
	then
	echo ${SUBJECT} both timepoints
	recon-all -base tmpl-${SUBJECTNAME} -tp ${SUBJECTNAME}_1 -tp ${SUBJECTNAME}_2 -all
	else
	echo $SUBJECT only baseline
	recon-all -base tmpl-${SUBJECTNAME} -tp ${SUBJECTNAME}_1 -all
	fi
	fi
done

echo Done on $(date)!


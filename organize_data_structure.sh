#!/bin/bash

## A.L.R.R. (@alruizzo, 22.08.2024)
## Script to re-organize the data starting from participants' folders...
## ...and including baseline and follow-up folders inside each of those.

## Define source directory and the two subdirectories (for baseline and...
## ...follow-up).
SOURCEPATH=/home/data/dsf4b
SUBDIR1=baseline
SUBDIR2=followup

## Loops to get into each subdirectories, obtain participants' codes,...
## ...create participants' folders in the source directory, and, finally...
## ...move the corresponding folders and files to the (new) participants...
## ...folders
for SUBJECT in ${SOURCEPATH}/${SUBDIR1}/*
do
	SUBJECTNAME=`basename $SUBJECT`
	base="${SUBJECTNAME//__1/}"
	mkdir -p ${SOURCEPATH}/$base/${SUBDIR1}
	mv $SUBJECT/* ${SOURCEPATH}/$base/${SUBDIR1}
done
for SUBJECT in ${SOURCEPATH}/${SUBDIR2}/*
do
	SUBJECTNAME=`basename $SUBJECT`
	base="${SUBJECTNAME//__2/}"
	mkdir -p ${SOURCEPATH}/$base/${SUBDIR2}
	mv $SUBJECT/* ${SOURCEPATH}/$base/${SUBDIR2}/
done

echo Done!


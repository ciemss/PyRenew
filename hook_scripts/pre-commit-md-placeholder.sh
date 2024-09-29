#!/usr/bin/env sh

TUTORIALS_DIR=docs/source/tutorials

# For each *qmd file in docs/source/tutorials, create a
# corresponding md file under docs/source/tutorials
COUNTER=0

# Removing everything under docs/source/tutorials/*.md with
# the exception of the index.md file.
# This is to ensure that the index.md file is not deleted.
MD_FILES=$(find $TUTORIALS_DIR -type f -name '*.md' -not -name 'index.md')

# Counting which of the rst files are not in model/docs
for md in $MD_FILES; do
    # Capture the basename
    bname=$(basename $md .md)

    # Check if the corresponding qmd file exists
    if [ ! -f ${TUTORIALS_DIR}/${bname}.qmd ]; then
        echo "Removing $md"
        rm $md
	COUNTER=$((COUNTER+1))
    fi
done

for qmd in ${TUTORIALS_DIR}/*.qmd; do
    # Capture the basename
    bname=$(basename $qmd .qmd)

    # Check if the corresponding md file already exists
    if [ -f ${TUTORIALS_DIR}/${bname}.md ]; then
        continue
    fi

    # Increment counter
    COUNTER=$((COUNTER+1))

    # Create the md file
    md=${TUTORIALS_DIR}/${bname}.md
    echo "Creating $md"

    # Print a message pointing to github.com/CDCgov/ to the md file
    echo "## Placeholder file" > $md
    echo " Please do not edit this file directly." >> $md
    echo " This file is just a placeholder." >> $md
    echo " For the source file, see:" >> $md
    echo " https://github.com/CDCgov/PyRenew/tree/main/${TUTORIALS_DIR}/${bname}.qmd" >> $md

done

# Exit with 1 if COUNTER != 0
if [ $COUNTER -ne 0 ]; then
    echo "Tutorials' markdown placeholder files were generated."
    exit 1
fi

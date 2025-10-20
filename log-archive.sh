#!/bin/bash

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SOURCE_DIR=$1
ARCHIVE_DIR="$HOME/Archive/logs"
ARCHIVE_NAME="logs_archive_$TIMESTAMP.tar.gz

if [ "$#" -eq 0 ]; then
    echo "ERROR: No Source Provided. Archive Not Created."
    exit
fi

# Verify if the archive and logs directories exist and creates them if they don't
verify_archive_dir() {
    if [ -d "$ARCHIVE_DIR"]; then
        echo "Archive Directory Found."
    else
        echo "Archive Directory Not Found. Creating Archive Directory..."
        mkdir -p $ARCHIVE_DIR
        verify_archive_dir
    fi
}

# Creates the log archive file and verifies that it has been created
create_archive() {
    if [ -f "$ARCHIVE_DIR/$ARCHIVE_NAME" ]; then
        echo "$ARCHIVE_NAME Created Successfully."
    else
        echo "Creating $ARCHIVE_NAME..."
        tar -czvf "$ARCHIVE_DIR/$ARCHIVE_NAME" $SOURCE_DIR
        create_archive
    fi
}

verify_archive_dir
create_archive

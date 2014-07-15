#!/bin/ash

AKAROS_MNT=/mnt
AKAROS_GOROOT=/go
CPIO_FILE=$AKAROS_MNT/go.cpio
LISTEN_PORT=5555

# Make sure we are at /
cd /

# Run the root script to get our folder mounted properly
ash root $@

# Create $AKAROS_GOROOT
mkdir -p ${AKAROS_GOROOT#/}

# Extract the $CPIO_FILE into $AKAROS_GOROOT
cd $AKAROS_GOROOT
cpio -d -i < $CPIO_FILE
cd /

# Start the listen daemon to wait for incoming rpc calls
listen1 tcp!*!$LISTEN_PORT /bin/ash &

# Start up ash so we can debug stuff if necessary
ash

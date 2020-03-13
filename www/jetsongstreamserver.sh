#!/bin/bash
STREAM_RECEIVER_ADDRESS=$1
STREAM_RECEIVER_PORT=$2
GST_LAUNCH="gst-launch-1.0 -v"
GST_DEBUG="--gst-debug=3"
INPUT="nvarguscamerasrc ! 'video/x-raw(memory:NVMM),width=1280,height=720,framerate=30/1,format=(string)NV12' ! nvvidconv ! 'video/x-raw(memory:NVMM),format=(string)I420'"

# Stream via RTP over UDP
STREAM_OUTPUT="omxh264enc bitrate=8000000 ! 'video/x-h264, stream-format=byte-stream' ! h264parse ! rtph264pay config-interval=10 pt=96 ! udpsink host=<host address> port=<port number>"

# Show in local GL window
VIEW_OUTPUT="nvegltransform ! nveglglessink -e"

if [ $# == 0 ]; then
    eval $GST_LAUNCH $INPUT ! $VIEW_OUTPUT
elif [ $# == 2 ]; then
    eval $GST_LAUNCH $INPUT ! $STREAM_OUTPUT
fi
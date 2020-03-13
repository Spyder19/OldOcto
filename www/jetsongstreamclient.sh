UNPACK_RTP_H264_PAYLOAD="'application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=H264, payload=96' ! rtph264depay ! avdec_h264"
GST_UDPSRC="gst-launch-1.0 -v --gst-debug=3 udpsrc port=<port number>"
VIDEO_SINK="videoconvert ! autovideosink"

eval $GST_UDPSRC ! $UNPACK_RTP_H264_PAYLOAD ! $VIDEO_SINK
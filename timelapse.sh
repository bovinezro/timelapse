#! /bin/sh

#script to fetch images from IP security cameras to create a timelapse video

#modify INTERVAL to change how often images are fetched. Default 5m (5 minutes)
INTERVAL="5m"
#modify MAX to change number of images fetched. Default (and max value) is 99999
MAX=99999
COUNTER=0
INC=""

while [ $COUNTER -le $MAX ]
do
  if [ $COUNTER -le 9 ]
  then
    INC="0000"$COUNTER
  elif [ $COUNTER -le 99 ]
  then
    INC="000"$COUNTER
  elif [ $COUNTER -le 999 ]
  then
    INC="00"$COUNTER
  elif [ $COUNTER -le 9999 ]
  then
    INC="0"$COUNTER
  else
    INC=$COUNTER
  fi

#camera credentials are left out for security. These are all HIKVision cameras
#the path to the images may differ for other cameras

  #backyard
  wget -O "byard"$INC "http://USER:PASS@IP/ISAPI/Streaming/channels/101/picture"
  #driveway
  wget -O "drive"$INC "http://USER:PASS@IP/ISAPI/Streaming/channels/101/picture"
  #front door
  wget -O "front"$INC "http://USER:PASS@IP/ISAPI/Streaming/channels/101/picture"

  sleep $INTERVAL
  let "COUNTER=$COUNTER+1"
done

#create video files from still images. This can also be split off and run as a
#separate script if desired.
cat front* | ffmpeg -framerate 15 -f image2pipe -i - front.mp4
cat drive* | ffmpeg -framerate 15 -f image2pipe -i - drive.mp4
cat byard* | ffmpeg -framerate 15 -f image2pipe -i - byard.mp4
exit 0

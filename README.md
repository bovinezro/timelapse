# timelapse
Shell script to fetch images from IP security cameras to create a timelapse video

Some details are left out for security. Most IP cameras will have a specific path to return a static image at native resolution; this will differ between cameras.
Most IP cameras will also accept credentials passed in a URL, but this may not always be true.

Default configuration will fetch one image from each camera every 5 minutes; the resulting video will contain 99999 frames and be about 111 minutes long (15 fps).
This will cover a time period of about 347 days. The 1080p cameras I use return an image between about 500-1000kB, so plan accordingly.

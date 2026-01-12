# Avidemux Video Appender
Batch script which appends videos via avidemux and outputs them as an mp4.

## Usage
Create a list of videos that you want to be appended with the names {name}1, {name}2, {name}3, etc.
```
Run: ./AppendToMP4.bat {name}
Or: 
Run ./AppendToMP4.bat and type in the name when prompted.

Example: video1.mkv, video2.mvk, video3.mkv, 
./AppendToMP4.bat video.mkv
Outputs: video.mp4
```
## Limitations
Standard powershell command limit is 8,191 characters. If you are planning on appending a lot of videos, you can shorten the video name or run this in parts. However, I would suggest writing a python script at that point.
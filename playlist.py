#!/usr/bin/python
import subprocess

f = open("/home/volumio/Alarm Playlist.m3u",'r')
g = open('/home/volumio/AlarmPlaylist.m3u','w')
for line in f:
    g.write(line.replace('/Users/Giancarlo/Music/iTunes/iTunes Music/', ''))
g.close()
f.close()

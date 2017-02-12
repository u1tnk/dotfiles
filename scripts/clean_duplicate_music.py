#!/usr/bin/env python
# -*- coding:utf-8 -*-
from gmusicapi import Mobileclient

api = Mobileclient()
api.login('hoge@gmail.com', 'xxxxxxx', Mobileclient.FROM_MAC_ADDRESS)

library = api.get_all_songs()
nonFilteringSong = []
filteringSong = []
overlapSong = []

for i in library:
    song = {'title':i['title'], 'album': i['album'], 'trackNumber': i['trackNumber']}
    nonFilteringSong.append(song)

for i in range(len(library)):
    song = {'title':library[i]['title'], 'album': library[i]['album'], 'trackNumber': library[i]['trackNumber']}
    if song in filteringSong:
        if not ('no text' in song['title']) :
            overlapSong.append(library[i]['id'])
            print(library[i]['title'], library[i]['album'])
    else :
        filteringSong.append(song)

# api.delete_songs(overlapSong)

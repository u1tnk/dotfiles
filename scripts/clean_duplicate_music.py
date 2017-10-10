#!/usr/bin/env python
# -*- coding:utf-8 -*-

from gmusicapi import Mobileclient

api = Mobileclient()
api.login('hoge@gmail.com', 'xxxxx', Mobileclient.FROM_MAC_ADDRESS)

library = api.get_all_songs()
filteringSong = []
overlapSong = []

for i in range(len(library)):
    song = {'title':library[i]['title'].replace('.mp3', ''), 'album': library[i]['album'], 'trackNumber': library[i]['trackNumber']}
    if song in filteringSong:
        if not ('no text' in song['title']) :
            overlapSong.append(library[i]['id'])
            print(library[i]['title'], library[i]['album'])
    else :
        filteringSong.append(song)

# api.delete_songs(overlapSong)

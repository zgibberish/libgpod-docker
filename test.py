import gpod

mnt = "/ipodmnt"
itdb = gpod.itdb_parse(mnt, None)
num_tracks = gpod.itdb_tracks_number(itdb)
num_playlists = gpod.itdb_playlists_number(itdb)
print(f"device has {num_tracks} tracks")
print(f"device has {num_playlists} playlists")

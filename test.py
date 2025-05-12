import gpod

mnt = "/ipodmnt"
itdb = gpod.Database(mnt)
print(itdb)
for track in itdb:
    print(track)

itdb = gpod.itdb_parse(mnt, None)
print(itdb)

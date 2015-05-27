Good pratices
===============

It is highly discouraged to execute processes from `/home/rioc` (especially to
write), but rather use `/scratch` or `/local` of each node. Indeed, writing on
`/home/rioc` may overload the NFS server.

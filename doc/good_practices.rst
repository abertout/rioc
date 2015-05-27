Good pratices
===============


It is hightly discouraged to execute processes from `/home/rioc` (especially to
write), but rather use `/scratch` ou `/local` of each node. Indeed, writing on
`/home/rioc` may overload the NFS serveur

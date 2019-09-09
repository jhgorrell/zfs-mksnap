zfs-mksnap/README
==================================================

``zfs-mksnap`` makes a snapshot of a ZFS filesystem.  It
figures out the currently mounted FS, so you can snapshot by
path. (This saves having to figure out the dataset name.)

Links:

- Github: https://github.com/jhgorrell/zfs-mksnap




Quickstart
--------------------------------------------------

::

    git clone https://github.com/jhgorrell/zfs-mksnap.git
    cd zfs-mksnap
    make install


USAGE
--------------------------------------------------

Running ``zfs-mksnap`` with no args attempts to snapshot the
current dir with the current date.

::

    # default
    zfs-mksnap

    # set the snapname
    zfs-mksnap --name checkpoint


ENV VARS:

- ``ZFS_MKSNAP_DATE_FMT`` defaults to ``%Y%m%dT%H%M%S``.



LICENSE
--------------------------------------------------

``zfs-mksnap`` is GPL v3 or later.

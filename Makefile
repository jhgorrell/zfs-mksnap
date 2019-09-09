#
# zfs-mksnap/Makefile ---
#

SHELL:=bash
.SUFFIXES:

_default:

#####

BIN_DIR:=/usr/local/bin

install:
	sudo install -m 555 zfs-mksnap ${BIN_DIR}

#####

# change this for your site.
TEST_ZFS_PATH:=/zfs2/home

# The paths
test_help:
	./zfs-mksnap --help
	./zfs-mksnap -h

test_noargs:
	./zfs-mksnap
	sleep 1

test_not_zfs:
	./zfs-mksnap /var/tmp

test_home_1:
	./zfs-mksnap /zfs2/home
	sleep 1

test_home_2:
	cd ${TEST_ZFS_PATH} && ${PWD}/zfs-mksnap
	sleep 1

test_home_3:
	cd ${TEST_ZFS_PATH} && ${PWD}/zfs-mksnap -n test-3-$$(date +%s)
	sleep 1

test_home_4:
	ZFS_MKSNAP_DATE_FMT=test-4-%s ./zfs-mksnap ${TEST_ZFS_PATH}
	sleep 1

test+=test_help
test+=test_noargs
test+=test_not_zfs
test+=test_home_1
test+=test_home_2
test+=test_home_3
test+=test_home_4

test: ${test}

#####

shellcheck:
	shellcheck ./zfs-mksnap

precommit+=tests
precommit+=shellcheck

precommit: ${precommit}

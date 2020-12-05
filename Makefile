#
# zfs-mksnap/Makefile ---
#

SHELL:=bash
.SUFFIXES:

_default: shellcheck

#####

_apt_get_install:
	sudo apt-get install python3-docutils shellcheck

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

test_prefix_1:
	./zfs-mksnap -p TEST- ${TEST_ZFS_PATH}

test_prefix_2:
	./zfs-mksnap -p TEST- -n $$(date +%s) ${TEST_ZFS_PATH}

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
test+=test_prefix_1
test+=test_prefix_2
test+=test_home_1
test+=test_home_2
test+=test_home_3
test+=test_home_4

test: ${test}

# remove snaps with "test" in the name
clean_snapshots_test:
	for snap in $$(sudo zfs list -r -t snap -H -o name | grep -i -e test | sort) ; \
	do \
	  echo $${snap} ; \
	  sudo zfs destroy $${snap} ; \
	done

#####

shellcheck:
	shellcheck ./zfs-mksnap

%.html: %.rst
	rst2html \
	  --title="zfs-mksnap" \
	  --no-generator \
	  ${@:%.html=%.rst} ${@}

precommit+=test
precommit+=shellcheck

precommit: ${precommit}

# Copyright 2012 Mathieu Chouinard 
# Distributed under the terms of the GNU General Public License v2

# Source: =sys-fs/diskdev_cmds-332.14_p1 from default Gentoo overlay
# Changes: cleanup, EAPI bump, version bump (filename)

EAPI=7

MY_PV=${PV}.linux3

DESCRIPTION="HFS and HFS+ utils ported from OSX, supplies mkfs and fsck"
HOMEPAGE="http://opendarwin.org"
SRC_URI="http://cavan.codon.org.uk/~mjg59/${PN}/${PN}-${MY_PV}.tar.gz"
LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/clang"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	into /
	dosbin fsck_hfs.tproj/fsck_hfs
	dosbin newfs_hfs.tproj/newfs_hfs
	dosym newfs_hfs /sbin/mkfs.hfs
	dosym newfs_hfs /sbin/mkfs.hfsplus
	dosym fsck_hfs /sbin/fsck.hfs
	dosym fsck_hfs /sbin/fsck.hfsplus
	doman newfs_hfs.tproj/newfs_hfs.8
	doman fsck_hfs.tproj/fsck_hfs.8
	dosym newfs_hfs.8 /usr/share/man/man8/mkfs.hfs.8
	dosym newfs_hfs.8 /usr/share/man/man8/mkfs.hfsplus.8
	dosym fsck_hfs.8 /usr/share/man/man8/fsck.hfs.8
	dosym fsck_hfs.8 /usr/share/man/man8/fsck.hfsplus.8
}

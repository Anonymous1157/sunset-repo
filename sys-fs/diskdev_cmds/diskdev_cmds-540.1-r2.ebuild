# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =sys-fs/diskdev_cmds-332.14_p1 from default Gentoo overlay

EAPI=8

MY_PV=${PV}.linux3
FEDORA_PN=hfsplus-tools

DESCRIPTION="HFS and HFS+ utils ported from OSX, supplies mkfs and fsck"
HOMEPAGE="http://opendarwin.org"
SRC_URI="https://src.fedoraproject.org/repo/pkgs/${FEDORA_PN}/${PN}-${MY_PV}.tar.gz/0435afc389b919027b69616ad1b05709/${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"
BDEPEND="llvm-core/clang"

PATCHES=(
"${FILESDIR}/${FEDORA_PN}-learn-to-stdarg.patch"
"${FILESDIR}/${FEDORA_PN}-no-blocks.patch"
"${FILESDIR}/${FEDORA_PN}-sysctl.patch"
)

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

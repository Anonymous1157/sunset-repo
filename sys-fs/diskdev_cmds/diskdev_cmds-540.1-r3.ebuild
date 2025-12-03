# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# Source: =sys-fs/diskdev_cmds-332.14_p1-r4 from default Gentoo overlay

EAPI=8

inherit flag-o-matic toolchain-funcs

MY_PV=${PV}.linux3
FEDORA_PN=hfsplus-tools

DESCRIPTION="HFS and HFS+ utils ported from OSX, supplies mkfs and fsck"
HOMEPAGE="http://opendarwin.org"
SRC_URI="https://src.fedoraproject.org/repo/pkgs/${FEDORA_PN}/${PN}-${MY_PV}.tar.gz/0435afc389b919027b69616ad1b05709/${PN}-${MY_PV}.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ppc ppc64 x86"
DEPEND="dev-libs/openssl:0="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=(
"${FILESDIR}/${FEDORA_PN}-no-blocks.patch"
"${FILESDIR}/${FEDORA_PN}-learn-to-stdarg.patch"
"${FILESDIR}/${FEDORA_PN}-sysctl.patch"
"${FILESDIR}/${PN}-AR.patch"
)

src_compile() {
	# -Werror=strict-alising
	# https://bugs.gentoo.org/863893
	# Upstream is entirely dead (since 2006!) and apple's opensource dump isn't
	# exactly where you go to report (0) bugs to an automated feed.
	#
	# Do not trust with LTO either.
	append-flags -fno-strict-aliasing
	filter-lto

	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

src_install() {
	into /
	dosbin fsck_hfs.tproj/fsck_hfs
	dosbin newfs_hfs.tproj/newfs_hfs
	dosym newfs_hfs /sbin/mkfs.hfs
	dosym newfs_hfs /sbin/mkfs.hfsplus
	dosym fsck_hfs /sbin/fsck.hfs
	dosym fsck_hfs /sbin/fsck.hfsplus
	doman newfs_hfs.tproj/newfs_hfs.8
	newman newfs_hfs.tproj/newfs_hfs.8 mkfs.hfs.8
	newman newfs_hfs.tproj/newfs_hfs.8 mkfs.hfsplus.8
	doman fsck_hfs.tproj/fsck_hfs.8
	newman fsck_hfs.tproj/fsck_hfs.8 fsck.hfs.8
	newman fsck_hfs.tproj/fsck_hfs.8 fsck.hfsplus.8
}

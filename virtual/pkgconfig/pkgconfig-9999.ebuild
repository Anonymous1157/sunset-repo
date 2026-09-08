# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =virtual/pkgconfig-3 from default Gentoo overlay

EAPI=8

DESCRIPTION="Virtual for the pkg-config implementation"
SLOT="0"
IUSE="+native-symlinks"

# NB: dev-util/u-config is in Guru as of editing this ebuild
RDEPEND="|| (
	dev-util/pkgconf[native-symlinks(+)=]
	dev-util/u-config[symlink(-)=]
	)"

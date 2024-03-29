# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

DESCRIPTION="OpenZone mouse cursor theme for X11 and Wayland"
HOMEPAGE="https://github.com/ducakar/openzone-cursors"

if [[ "${PV%9999}" == "${PV}" ]] ; then
#	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://codeload.github.com/ducakar/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

LICENSE="BSD"
SLOT="0"
RESTRICT="mirror"

BDEPEND="media-gfx/icon-slicer"

src_prepare() {
	default
	# Use the Gentoo cursor theme directory. Also works around incorrect usage of DESTDIR to mean PREFIX.
	sed -e 's_/share/icons_/usr/share/cursors/xorg-x11_g' -i Makefile
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit git-r3

DESCRIPTION="An old-fashioned look X11 cursor theme"
HOMEPAGE="https://github.com/mdomlop/retrosmart-x11-cursors"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

BDEPEND="virtual/imagemagick-tools[png]
x11-apps/xcursorgen"

src_prepare() {
	default
	# Use the Gentoo cursor theme directory.
	sed -e 's_share/icons_share/cursors/xorg-x11_g' -i Makefile
}

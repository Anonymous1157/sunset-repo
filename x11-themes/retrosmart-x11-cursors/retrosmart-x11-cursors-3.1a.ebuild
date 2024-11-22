# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

DESCRIPTION="An old-fashioned look X11 cursor theme"
HOMEPAGE="https://github.com/mdomlop/retrosmart-x11-cursors"
SRC_URI="https://github.com/mdomlop/retrosmart-x11-cursors/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

BDEPEND="virtual/imagemagick-tools[png]
x11-apps/xcursorgen"

src_install() {
	default
	rm -rf "${D}/usr/share/icons/share"
	for i in $(ls "${D}/usr/share/icons/")
	do
		dosym -r "/usr/share/icons/${i}" "/usr/share/cursors/xorg-x11/${i}"
	done
}

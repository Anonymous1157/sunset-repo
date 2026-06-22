# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit autotools udev

DESCRIPTION="Open Source Nintendo Wii Remote Linux Device Driver "
HOMEPAGE="http://xwiimote.github.io/xwiimote"
GIT_HASH="4df713d9037d814cc0c64197f69e5c78d55caaf1"
SRC_URI="https://github.com/${PN}/${PN}/archive/${GIT_HASH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${GIT_HASH}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X debug doc"

DEPEND="
	virtual/libudev:=
	sys-libs/ncurses:=
	"
RDEPEND="${DEPEND}
	virtual/udev
	"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	"

src_prepare() {
	default
	eautoreconf
	if use doc
	then
		doxygen -u "doc/Doxyfile.in" 2>/dev/null || die "Updating Doxygen configuration failed"
	fi
}

src_configure() {
	econf $(use_with doc doxygen) $(use_enable debug)
}

src_install() {
	default
	rm "${ED}/usr/$(get_libdir)/libxwiimote.la"
	udev_dorules "res/70-udev-xwiimote.rules"
	if use X
	then
		insinto "/usr/share/X11/xorg.conf.d"
		doins "res/50-xorg-fix-xwiimote.conf"
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

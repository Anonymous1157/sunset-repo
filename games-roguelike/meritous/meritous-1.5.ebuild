# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit xdg toolchain-funcs

DESCRIPTION="action-adventure dungeon crawler with unique charged area attack combat"
HOMEPAGE="https://asceai.net/meritous/"
SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
media-libs/libsdl
media-libs/sdl-image
media-libs/sdl-mixer
virtual/zlib:=
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/intltool"

PATCHES=(
	"${FILESDIR}/gcc15.patch"
)

src_compile() {
	emake prefix="${EPREFIX}/usr" CC="$(tc-getCC)"
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
}

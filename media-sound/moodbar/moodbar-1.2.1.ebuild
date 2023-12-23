# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit meson

DESCRIPTION="Generates audio timeline visualization data for use with Clementine and Amarok"
HOMEPAGE="https://github.com/exaile/moodbar"
SRC_URI="https://github.com/exaile/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="lto"

DEPEND="
	sci-libs/fftw:3.0
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	dev-libs/glib:2
	"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	"

src_configure() {
	local emesonargs=(
		$(meson_use lto b_lto)
	)

	meson_src_configure
}

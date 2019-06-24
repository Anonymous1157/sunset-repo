# Copyright 1999-2019 Gentoo Authors
# Copyright 2019 Sunset <sunsetsergal@gmail.com>
# Distributed under the terms of the GNU General Public License v2

# Source: =media-sound/milkytracker-1.0.0 from default Gentoo overlay

EAPI=7

inherit cmake-utils desktop

DESCRIPTION="FastTracker 2 inspired music tracker"
HOMEPAGE="https://milkytracker.titandemo.org/"
SRC_URI="https://github.com/milkytracker/MilkyTracker/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-3 MPL-1.1 ) AIFFWriter.m BSD GPL-3 GPL-3+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack"

RDEPEND="
	dev-libs/zziplib
	media-libs/libsdl2[X]
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/MilkyTracker-${PV}"
SS="${WORKDIR}/${P}_build"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR=share/doc/${PF}
		$(cmake-utils_use_find_package alsa ALSA)
		$(cmake-utils_use_find_package jack JACK)
		-DSDL2MAIN_LIBRARY="" # Redundant but makes build fail if not defined
		-DBUILD_SHARED_LIBS=OFF # Parts of code built as *.a libraries not intended to be built as *.so and installed
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newicon resources/pictures/carton.png ${PN}.png
	make_desktop_entry ${PN} MilkyTracker ${PN} \
		"AudioVideo;Audio;Sequencer"
}

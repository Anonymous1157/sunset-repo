# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit cmake

DESCRIPTION="GZDoom's music system as a standalone library"
HOMEPAGE="https://github.com/coelckers/ZMusic"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

LICENSE="BSD DUMB-0.9.3 GPL-3 LGPL-3 LGPL-2.1 ZLIB"
SLOT="0"
IUSE="alsa system-gme"

RESTRICT="mirror"

DEPEND="
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	system-gme? ( media-libs/game-music-emu )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DDYN_FLUIDSYNTH=OFF
		-DDYN_SNDFILE=OFF
		-DDYN_MPG123=OFF
		-DFORCE_INTERNAL_GME="$(usex !system-gme)"
		-DFORCE_INTERNAL_ZLIB=no
		-DCMAKE_DISABLE_FIND_PACKAGE_ALSA="$(usex !alsa)"
	)
	cmake_src_configure
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =games-simulation/simutrans-124.2.1 from default Gentoo overlay

EAPI=8

inherit cmake flag-o-matic xdg subversion

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="https://www.simutrans.com/"

# If you want to version bump the ebuild, get the SVN revision of the release
#  you want from the release announcement:
#  <https://forum.simutrans.com/index.php/board,3.0.html>
ESVN_REPO_URI="svn://servers.simutrans.org/simutrans/trunk@11671"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+midi fontconfig upnp zstd doc tools"

DEPEND="
	app-arch/bzip2
	media-libs/freetype
	media-libs/libpng:0=
	media-libs/libsdl2[sound,video]
	virtual/zlib:=
	midi? ( media-sound/fluidsynth:=[sdl] )
	fontconfig? ( media-libs/fontconfig )
	upnp? ( net-libs/miniupnpc:= )
	zstd? ( app-arch/zstd )
"
RDEPEND="
	${DEPEND}
	midi? ( media-sound/fluid-soundfont )
	!<games-simulation/simutrans-paksets-${PV}
"
BDEPEND="
	doc? ( app-text/doxygen[dot] )
	virtual/pkgconfig
"

# TODO see if the note on the RESTRICT is still accurate
RESTRICT="test" # Opens the program and doesn't close it.

src_configure() {
	# TODO see if either of these are actually needed anymore (probably not)
	strip-flags # bug #293927
	append-flags -fno-strict-aliasing # bug #859229

	local mycmakeargs=(
		-DSIMUTRANS_USE_REVISION="${ESVN_WC_REVISION}"
		-DSIMUTRANS_BACKEND="sdl2"
		-DSIMUTRANS_MULTI_THREAD=1
		-DSIMUTRANS_USE_FONTCONFIG=$(usex fontconfig)
		-DSIMUTRANS_USE_UPNP=$(usex upnp)
		-DSIMUTRANS_USE_ZSTD=$(usex zstd)
		-DSIMUTRANS_USE_FLUIDSYNTH_MIDI=$(usex midi)
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=$(usex !doc)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use tools && cmake_src_compile makeobj nettool
	use doc && cmake_src_compile docs
}

src_install() {
	cmake_src_install
	use tools && {
		newbin "${BUILD_DIR}/src/nettool/nettool" simutrans-nettool
		newbin "${BUILD_DIR}/src/makeobj/makeobj" simutrans-makeobj
	}
	use doc && {
		dodoc -r "${BUILD_DIR}/documentation/simutrans"
		dodoc -r "${BUILD_DIR}/documentation/sqapi"
	}
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "New versions of Simutrans can download paksets (game data) on their own."
	elog "This ebuild makes no attempt to install any fallback pakset."
	use tools && {
		elog ""
		elog "Tools have been installed as \"simutrans-*\" to avoid collisions as they have"
		elog "extremely generic names."
	}
}

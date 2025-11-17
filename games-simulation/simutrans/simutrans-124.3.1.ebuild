# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =games-simulation/simutrans-124.2.1 from default Gentoo overlay

EAPI=8

inherit autotools desktop flag-o-matic toolchain-funcs xdg subversion

MY_PV=${PV//./-}

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="https://www.simutrans.com/"

# If you want to version bump the ebuild, get the SVN revision of the release
#  you want from the release announcement:
#  <https://forum.simutrans.com/index.php/board,3.0.html>
ESVN_REPO_URI="svn://servers.simutrans.org/simutrans/trunk@11671"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+midi fontconfig upnp zstd"

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
	app-arch/unzip
	virtual/pkgconfig
"

# TODO see if the note on the RESTRICT is still accurate
RESTRICT="test" # Opens the program and doesn't close it.

src_prepare() {
	default
	xdg_environment_reset

	# TODO see if either of these are actually needed anymore (probably not)
	strip-flags # bug #293927
	append-flags -fno-strict-aliasing # bug #859229

	eautoreconf
}

src_configure() {
	default

	# NOTE: some flags need to be 0, some need to be empty to turn them off
	cat > config.default <<-EOF || die
		BACKEND=sdl2
		OSTYPE=linux
		OPTIMISE=0
		STATIC=0
		WITH_REVISION=${ESVN_WC_REVISION}
		MULTI_THREAD=1
		USE_UPNP=$(usex upnp 1 '')
		USE_FREETYPE=1
		USE_ZSTD=$(usex zstd 1 '')
		USE_FONTCONFIG=$(usex fontconfig 1 '')
		USE_FLUIDSYNTH_MIDI=$(usex midi 1 '')
		VERBOSE=1

		HOSTCC = $(tc-getCC)
		HOSTCXX = $(tc-getCXX)
	EOF
}

src_install() {
	newbin build/default/sim ${PN}
	insinto usr/share/${PN}
	doins -r simutrans/*
	doicon src/simutrans/${PN}.svg
	domenu src/linux/simutrans.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "New versions of Simutrans can download paksets (game data) on their own."
	elog "This ebuild makes no attempt to install any fallback pakset."
}

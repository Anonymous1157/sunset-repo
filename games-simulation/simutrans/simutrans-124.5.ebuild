# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =games-simulation/simutrans-124.2.1 from default Gentoo overlay

EAPI=8

inherit cmake flag-o-matic xdg

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="https://www.simutrans.com/"

MY_PV=${PV//./-}
# If you want to version bump the ebuild, get the SVN revision of the release
#  you want from the release announcement:
#  <https://forum.simutrans.com/index.php/board,3.0.html>
ESVN_WC_REVISION="11993"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/${MY_PV}/${PN}-src-${MY_PV}.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+midi fontconfig upnp zstd tools"

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
	virtual/pkgconfig
"

# Does not work without paksets present
RESTRICT="test"

src_unpack() {
	# The zip releases flip on a whim between files in "/" or "/trunk"!
	# You may need to rewrite this when bumping the version
	mkdir "${S}"
	cd "${S}"
	unpack "${PN}-src-${MY_PV}.zip"
}

src_prepare() {
	default
	cmake_src_prepare

	# Metainfo file missing from zip release
	touch "src/linux/com.simutrans.Simutrans.metainfo.xml.in"
	sed -e "/com.simutrans.Simutrans.metainfo.xml/d" -i "cmake/SimutransInstall.cmake"

	# Android metadata file missing from zip release, which is also updated
	#  unconditionally despite this not being an Android app build
	touch "src/android/AndroidAppSettings.cfg.in"

	# Script to build UI themes hardcodes location of makeobj
	sed -e "s#^.*src/makeobj/makeobj#${BUILD_DIR}/src/makeobj/makeobj#g" -i "themes.src/build_themes.sh"
}

src_configure() {
	# Last checked both of these workarounds still necessary 20260626
	strip-flags # bug #293927
	append-flags -fno-strict-aliasing # bug #859229

	local mycmakeargs=(
		-DSIMUTRANS_USE_REVISION="${ESVN_WC_REVISION}"
		-DSIMUTRANS_BACKEND="sdl2"
		-DSIMUTRANS_MULTI_THREAD=true
		-DSIMUTRANS_USE_FONTCONFIG=$(usex fontconfig)
		-DSIMUTRANS_USE_UPNP=$(usex upnp)
		-DSIMUTRANS_USE_ZSTD=$(usex zstd)
		-DSIMUTRANS_USE_FLUIDSYNTH_MIDI=$(usex midi)
		# Doxyfile missing from zip release (you may be noticing a pattern)
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=true
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	# Prebuilt UI themes missing from zip release
	cmake_src_compile makeobj
	( cd "themes.src" && /bin/sh "build_themes.sh" )

	use tools && cmake_src_compile nettool
}

src_install() {
	cmake_src_install
	use tools && {
		newbin "${BUILD_DIR}/src/nettool/nettool" ${PN}-nettool
		newbin "${BUILD_DIR}/src/makeobj/makeobj" ${PN}-makeobj
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

# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

LUA_COMPAT=( lua5-{1,2} luajit )

inherit meson lua-single desktop

MY_PN=The-Powder-Toy

DESCRIPTION="A desktop version of the classic 'falling sand' physics sandbox"
HOMEPAGE="https://powdertoy.co.uk/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="$WORKDIR/${MY_PN}-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
DEPEND="lua? ( ${LUA_DEPS} )
	media-libs/libpng:0/16
	media-libs/libsdl2
	curl? ( net-misc/curl )
	fftw? ( sci-libs/fftw )
	app-arch/bzip2
	dev-libs/jsoncpp"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

IUSE="lto +lua +fftw +curl cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3"

PATCHES=(
	"${FILESDIR}/powdertoy-97.0.352-gcc-13.patch"
	)

RESTRICT="mirror"

src_configure() {
	local SSEFLAG=none
	use cpu_flags_x86_sse && SSEFLAG=sse
	use cpu_flags_x86_sse2 && SSEFLAG=sse2
	use cpu_flags_x86_sse3 && SSEFLAG=sse3

	local LUAFLAG=none
	use lua && LUAFLAG=$ELUA

	local emesonargs=(
		$(meson_use lto b_lto)
		$(meson_use fftw gravfft)
		$(meson_use curl http)
		-Drender_icons_with_inkscape=disabled
		-Dworkaround_noncpp_lua=true # I don't know if this breaks things
		-Dlua=$LUAFLAG
		-Dx86_sse=$SSEFLAG
	)
	meson_src_configure
}

src_install() {
	# Project does not have a working meson install target
	newbin "${BUILD_DIR}/powder" ${PN}
	newicon -s 256 resources/generated_icons/icon_exe.png ${PN}.png
	newicon -s 16 resources/generated_icons/icon_exe_16.png ${PN}.png
	newicon -s 32 resources/generated_icons/icon_exe_32.png ${PN}.png
	newicon -s 48 resources/generated_icons/icon_exe_48.png ${PN}.png
	newman resources/powder.man ${PN}.6
	make_desktop_entry ${PN} "The Powder Toy" ${PN} "Game;Simulation"
}

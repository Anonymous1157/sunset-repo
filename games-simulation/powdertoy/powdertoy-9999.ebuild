# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson desktop

MY_PN="The-Powder-Toy"

DESCRIPTION="Physics sandbox game"
HOMEPAGE="https://powdertoy.co.uk/"
EGIT_REPO_URI="https://github.com/${MY_PN}/${MY_PN}.git"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

DEPEND="|| ( dev-lang/luajit dev-lang/lua:5.1 )
dev-libs/openssl
media-libs/libsdl2
net-misc/curl
sci-libs/fftw:=
sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

IUSE="+lto cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3"

#S="${WORKDIR}/${MY_PN}"

src_configure() {
	# This game can technically run on i586 CPUs but the build defaults to SSE2
	local SSEFLAG=none
	use cpu_flags_x86_sse && SSEFLAG=sse
	use cpu_flags_x86_sse2 && SSEFLAG=sse2
	use cpu_flags_x86_sse3 && SSEFLAG=sse3

	# Game automagically depends on everything in DEPENDS if it's available
	# You probably want the full feature set so none of it is configurable here

	local emesonargs=(
		$(meson_use lto b_lto)
		-Dx86_sse=$SSEFLAG
	)
	meson_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/powder" powdertoy
	newicon -s 256 resources/icon/new-unused/icon_256.png ${PN}.png
	newicon -s 128 resources/icon/new-unused/icon_128.png ${PN}.png
	newicon -s scalable resources/icon/new-unused/icon.svg ${PN}.svg
	newman resources/powder.man powdertoy.6
	make_desktop_entry powdertoy "The Powder Toy" powdertoy "Game;Simulation"
}

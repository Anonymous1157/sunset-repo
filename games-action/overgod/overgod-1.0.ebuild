# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit toolchain-funcs xdg

DESCRIPTION="Slow and lumbering arcade game similar to Asteroids"
HOMEPAGE="https://www.allegro.cc/depot/Overgod"
# This would be correct to download from Sourceforge but we really want
#  Debian's patches so just fetch Debian's orig as well
#SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/Overgod%20${PV}/${PN}.tar.gz -> ${P}.tar.gz"
SRC_URI="mirror://debian/pool/main/o/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/o/${PN}/${PN}_${PV}-6.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/allegro:0"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=(
	"${WORKDIR}/debian/patches/"
)

src_prepare() {
	default
	cp "${WORKDIR}/debian/${PN}.sh" "${WORKDIR}/${PN}"
	sed -e 's_/usr/lib/games/_/usr/lib/_' -i "${WORKDIR}/${PN}"
	cp "${PN}.cfg" "default.cfg"
}

src_compile() {
	CFILES="actor.c bullet.c cloud.c cmds.c display.c displ_in.c eclass.c enemy.c game.c input.c levels.c light.c main.c menu.c palette.c pickup.c score.c sound.c stuff.c tile.c"
	$(tc-getCC) $(allegro-config --cflags --cppflags --libs) -fgnu89-inline -lm \
		${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o ${PN} ${CFILES} || die
}

src_install() {
	dobin "${WORKDIR}/${PN}"
	exeinto "/usr/lib/${PN}"
	doexe "${PN}"
	dodoc readme.txt
	doman "${WORKDIR}/debian/${PN}.6"
	insinto "/usr/share/applications"
	doins "${WORKDIR}/debian/${PN}.desktop"
	insinto "/usr/share/pixmaps"
	doins "${WORKDIR}/debian/${PN}.xpm"
	insinto "/usr/share/games/${PN}"
	doins -r gfx/ wavs/ "default.cfg"
}

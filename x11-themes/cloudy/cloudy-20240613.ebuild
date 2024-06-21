# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

DESCRIPTION="Gtk2, Gtk3, Gnome Shell, Cinnamon & Metacity themes base on Arc-Theme"
HOMEPAGE="https://github.com/i-mint/Cloudy"

MY_PN="Cloudy"

EGIT_COMMIT="47cb23533ec9faa754daeb1ee888614e67ba856c"
SRC_URI="https://github.com/i-mint/Cloudy/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-themes/gtk-engines-adwaita
x11-themes/gtk-engines-murrine"

RESTRICT="mirror"

src_install() {
	insinto /usr/share/themes
	for i in "${S}"/*/gtk-3.0
	do
		doins -r "${i%/gtk-3.0}"
	done
}

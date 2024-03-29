# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Light Mac-like theme for GTK+2/3, Metacity, xfwm based off Arc-Theme"
HOMEPAGE="https://www.deviantart.com/etlesteam/art/Gnome-Xpro-686002343"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1518377113/s/b2564b3c59b6216b85f5251b02ed531f55f170f0ca3f6b1be85da25ef2471e49a20173aa084860df29fd842cd12d1d03e642768d5bf5c0af9a491050eda7671f/t/1559340727/lt/download/Gnome-Xpro.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/${MY_DIR}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-themes/gtk-engines-adwaita
x11-themes/gtk-engines-murrine"

MY_DIR="Gnome-Xpro"
RESTRICT="mirror"

src_prepare() {
	default
	# Fix MATE tray icon hardcoded size
	sed -e '/NaTrayApplet-icon-size: 16px/d' -i "${S}/gtk-3.0/gtk.css"
}

src_install() {
	insinto /usr/share/themes
	doins -r "${S}"
}

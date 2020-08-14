# Copyright 2019 Sunset <sunsetsergal@gmail.com>
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

DESCRIPTION="A theme providing a consistent look for all standard toolkits in XFCE"
HOMEPAGE="https://sourceforge.net/projects/xfce-evolution/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"
RDEPEND="x11-themes/gtk-engines-murrine"

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack ${A}
}

src_install() {
	mkdir -p "${ED}/usr/share/themes"

	MY_S="${S}/Xfce Evolution"
	MY_D="${ED}/usr/share/themes/XfceEvolution"

	cp -R "${MY_S}" "${MY_D}"
	for i in Bronze Crux Devilsclaw Graphite Greybird Icelake Irix Rainyday Raleigh Redmond Solaris Straw Summerfield Summerstorm; do
		cp -R "${MY_S} $i" "${MY_D}$i"
		for j in "gtk-2.0/assets" "gtk-3.0/assets" "gtk-3.0/settings.ini"; do
			rm "${MY_D}$i/$j"
			ln -s "../../XfceEvolution/$j" "${MY_D}$i/$j"
		done
	done

	find "${ED}/usr/share/themes" -name '*.sh' -delete -or -name 'xfce-evolution_mark' -delete
	rm -rf "${ED}/usr/share/themes/XfceEvolution/TOOLS"
	rm -rf "${ED}/usr/share/themes/XfceEvolution/original"

	chmod -R a-x "${MY_D}"
}

pkg_postinst() {
	elog "Qt5 is supported via gtk2 plugin from dev-qt/qtstyleplugins"
}

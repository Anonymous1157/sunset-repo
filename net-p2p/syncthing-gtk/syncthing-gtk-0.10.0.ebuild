# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-single-r1 optfeature xdg

DESCRIPTION="GTK3 & Python GUI for syncthing"
HOMEPAGE="https://github.com/syncthing-gtk/syncthing-gtk"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="${PYTHON_DEPS}
	x11-libs/gtk+:3[introspection]
	libnotify? ( x11-libs/libnotify[introspection] )
	appindicator? ( dev-libs/libayatana-appindicator[introspection(+)] )
	$(python_gen_cond_dep '
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/bcrypt[${PYTHON_USEDEP}]
	')"
RDEPEND="${DEPEND}
	sys-process/psmisc
	net-p2p/syncthing"
BDEPEND="${PYTHON_DEPS}"

IUSE="+libnotify +appindicator"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	default

	# Convince meson to use EPYTHON
	sed -e "s#python3#${EPYTHON}#" -i meson.build

	# Convince python_fix_shebang to fix these files too
	#  (See upstream commit 2f13fcaa for why these are still python2)
	sed -e "s#python2#${EPYTHON}#" -i plugins/syncthing-plugin-nemo.py
	sed -e "s#python2#${EPYTHON}#" -i plugins/syncthing-plugin-caja.py
	python_fix_shebang "${S}"

	# Fix tray icon on KDE Plasma Wayland (Workaround for upstream bug #115)
	sed -e '/is_embedded or IS_KDE/s#or IS_KDE##' -i syncthing_gtk/statusicon.py

	# This backend never existed?? Referencing it breaks fallback
	sed -e 's#StatusIconQt5, ##' -i syncthing_gtk/statusicon.py
}

src_install() {
	meson_src_install
	python_optimize
}

pkg_postinst() {
	optfeature "Caja file manager integration" dev-python/python-caja
	optfeature "Nautilus file manager integration" dev-python/nautilus-python
	optfeature "Gnome file manager integration" gnome-extra/gnome-shell-extension-appindicator
}

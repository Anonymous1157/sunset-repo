# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 optfeature

DESCRIPTION="GTK3 & Python GUI for syncthing"
HOMEPAGE="https://github.com/syncthing-gtk/syncthing-gtk"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
	dev-python/pygobject[cairo,${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	libnotify? ( x11-libs/libnotify )"
RDEPEND="${DEPEND}
	sys-process/psmisc
	net-p2p/syncthing
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"

IUSE="+libnotify"

pkg_postinst() {
	optfeature "Caja file manager integration" dev-python/python-caja
	optfeature "Nautilus file manager integration" dev-python/nautilus-python
	optfeature "Gnome file manager integration" gnome-extra/gnome-shell-extension-appindicator
}

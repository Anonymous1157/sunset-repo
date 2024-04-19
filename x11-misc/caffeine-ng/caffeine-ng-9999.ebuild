# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Taken from Jorgicio's Gentoo overlay and modified
# Source: =x11-misc/caffeine-ng-9999 from pf4public overlay

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 gnome2 meson

DESCRIPTION="Stop the desktop from becoming idle in full-screen mode. (Fork of Caffeine)"
HOMEPAGE="https://codeberg.org/WhyNotHugo/caffeine-ng"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=dev-python/pyxdg-0.25[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	>=dev-python/docopt-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/ewmh-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/setproctitle-1.1.10[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/wheel-0.29.0[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-libs/libappindicator:3[introspection]
	x11-libs/gtk+:3
	x11-libs/libnotify[introspection]
	dev-python/pulsectl[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	!x11-misc/caffeine"

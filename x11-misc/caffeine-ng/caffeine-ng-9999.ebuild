# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Taken from Jorgicio's Gentoo overlay and modified
# Source: =x11-misc/caffeine-ng-9999 from pf4public overlay

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11,12} )
#DISTUTILS_USE_PEP517=no

inherit gnome2 meson python-r1

DESCRIPTION="Stop the desktop from becoming idle in full-screen mode. (Fork of Caffeine)"
HOMEPAGE="https://codeberg.org/WhyNotHugo/caffeine-ng"

if [[ "${PV%9999}" == "${PV}" ]];then
	SRC_URI="https://codeberg.org/WhyNotHugo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/WhyNotHugo/${PN}.git"
	SRC_URI="" # cursed ebuild will try to download something without this
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		>=dev-python/pyxdg-0.25[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		>=dev-python/docopt-0.6.2[${PYTHON_USEDEP}]
		>=dev-python/ewmh-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/setproctitle-1.1.10[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/wheel-0.29.0[${PYTHON_USEDEP}]
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
		dev-python/pulsectl[${PYTHON_USEDEP}]
	')
	dev-libs/libappindicator:3[introspection]
	x11-libs/gtk+:3
	x11-libs/libnotify[introspection]
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	!x11-misc/caffeine
	"

src_configure() {
	python_foreach_impl meson_src_configure
}

src_compile() {
	python_foreach_impl meson_src_compile
#	python_fix_shebang "${BUILD_DIR}/caffeine"
}

src_install() {
	python_foreach_impl meson_src_install
	python_foreach_impl python_optimize
	python_replicate_script "${D}/usr/bin/caffeine"
}

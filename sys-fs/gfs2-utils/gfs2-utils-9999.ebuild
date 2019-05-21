# Copyright 2019 Sunset <sunsetsergal@gmail.com>
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit libtool autotools

DESCRIPTION="Tools for creating, checking and working with gfs2 filesystems"
HOMEPAGE="https://pagure.io/gfs2-utils"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

RESTRICT="mirror"
LICENSE="LGPL-2.1+ GPL-2+"
SLOT="0"
IUSE="nls debug gprof gcov test"

RDEPEND="sys-libs/zlib
sys-libs/ncurses:=
sys-apps/util-linux"
DEPEND="sys-kernel/linux-headers
${RDEPEND}"
BDEPEND="nls? ( sys-devel/gettext )
test? ( dev-libs/check )"

src_prepare() {
	default

	if use test ; then
		# Avoid "maintainer mode" QA warning by forcing the recipe for
		# the test suite to use autom4te directly instead of via "missing"
		sed -e '/AUTOTEST = /s/$(AUTOM4TE)/autom4te/' \
			-i "${S}/tests/Makefile.am" || die "sed failed"
	else
		# Prevent building any tests
		# (Some build automagically if dev-libs/check is installed)
		sed -e "/\tdoc \\\\/{N;s_ \\\\\n\ttests_\n_}" \
			-i "${S}/Makefile.am" || die "sed failed"
	fi

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_enable debug)
		$(use_enable gcov)
		$(use_enable gprof)
	)
	econf ${myeconfargs[@]}
}

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

DESCRIPTION="An icon theme mainly based in the Haiku OS look"
HOMEPAGE="https://github.com/mdomlop/retrosmart-icon-theme"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

RESTRICT="mirror"
LICENSE="GPL-3 MIT" # Some files are from unknown source and might be dirty but I don't know how to specify that
SLOT="0"

BDEPEND="virtual/imagemagick-tools[png]"

src_prepare() {
	default
	# Don't let the makefile install docs, emerge will do it better
	sed -e 's_^	install -Dm 644.*$__g' -i makefile*
}

src_configure() {
	# Not a normal (i.e. Autotools) configure script
	elog "Scanning an absurd number of files with no progress indicator..."
	./configure
}

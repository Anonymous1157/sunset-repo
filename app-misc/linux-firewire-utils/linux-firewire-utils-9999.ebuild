# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit autotools

DESCRIPTION="Utilities to list and configure FireWire devices"
HOMEPAGE="https://github.com/cladisch/linux-firewire-utils"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="https://github.com/cladisch/linux-firewire-utils/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${PN}-use-autotools-prefix.patch"
)

DEPEND="sys-kernel/linux-headers"

src_prepare() {
	default
	eautoreconf
}

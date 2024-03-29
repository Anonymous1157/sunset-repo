# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit meson

DESCRIPTION="Utilities to list and configure FireWire devices"
HOMEPAGE="http://ieee1394.docs.kernel.org/"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="https://git.kernel.org/pub/scm/utils/ieee1394/${PN}.git/snapshot/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://git.kernel.org/pub/scm/utils/ieee1394/${PN}.git"
fi

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

DEPEND="sys-kernel/linux-headers"

PATCHES=(
	"${FILESDIR}/2004-add-phy-id-for-nec-pd7285x.patch"
)

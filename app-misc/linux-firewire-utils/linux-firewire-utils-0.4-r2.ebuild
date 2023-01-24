# Copyright 2023 Gentoo Authors
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
	"${FILESDIR}/1001-use-autotools-prefix.patch"
	"${FILESDIR}/2001-fix-build-instructions.patch"
	"${FILESDIR}/2002-update-oui-url.patch"
	"${FILESDIR}/2004-add-phy-id-for-nec-pd7285x.patch"
	"${FILESDIR}/3001-crpp-code-refactoring-with-2to3.patch"
	"${FILESDIR}/3002-crpp-use-true-division-for-integer-result.patch"
	"${FILESDIR}/3003-crpp-declare-import-of-some-functions.patch"
	"${FILESDIR}/3004-crpp-use-open-function-instead-of-file.patch"
	"${FILESDIR}/3005-crpp-use-binary-representation.patch"
)

DEPEND="sys-kernel/linux-headers"
RDEPEND=">=dev-lang/python-3" # The "crpp" script, used for "lsfirewire -v -v"

src_prepare() {
	default
	eautoreconf
}

# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="i2c driver for Asus AURA RGB lighting in GPUs"
HOMEPAGE="https://github.com/twifty/aura-gpu"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
SLOT="0"
if [[ "${PV%9999}" == "${PV}" ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

MODULE_NAMES="aura-gpu(extra:${S})"

PATCHES=(
	"${FILESDIR}/${PN}-new-makefile.patch"
	"${FILESDIR}/${PN}-add-supported-cards.patch"
	"${FILESDIR}/${PN}-add-driver-info.patch"
)

pkg_setup() {
	linux-mod_pkg_setup
	# linux-mod_pkg_setup -> linux-info_pkg_setup -> linux-info_get_any_version -> get_version -> KV_OUT_DIR
	BUILD_PARAMS="KERNELDIR=${KV_OUT_DIR}"
}

# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="IT8705F/IT871xF/IT872xF hardware monitoring driver"
HOMEPAGE="https://github.com/a1wong/it87"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
SLOT="0"
if [[ "${PV%9999}" == "${PV}" ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

CONFIG_CHECK="~!SENSORS_IT87"
ERROR_SENSORS_IT87="Please make sure SENSORS_IT87=m or you won't be able to load this module!\n"
ERROR_SENSORS_IT87+="(You don't have to disable it entirely since we package a depmod.d file)"
MODULE_NAMES="it87(hwmon:${S})"
BUILD_TARGETS="clean modules"

src_install() {
	linux-mod_src_install

	dodoc README ISSUES

	# Tell kmod to prefer this module over the kernel tree one
	mkdir -p "${ED}/lib/depmod.d" || die
	echo "override ${PN} ${KV_FULL} hwmon" > "${ED}/lib/depmod.d/${PN}.conf" || die
}

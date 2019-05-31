# Copyright 2019 Sunset <sunsetsergal@gmail.com>
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit meson linux-info systemd

DESCRIPTION="Facebook's userspace out-of-memory killer for Linux systems"
HOMEPAGE="https://github.com/Anonymous1157/oomd"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	# EBUILD NOT COMPLETELY WORKING YET
	#KEYWORDS="~amd64 ~x86"
	KEYWORDS=""
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="systemd test"
DOCS="README.md docs/*.md"

RDEPEND="dev-libs/jsoncpp
systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}
test? ( dev-cpp/gtest )"
#BDEPEND=""

CONFIG_CHECK="~PSI ~!PSI_DEFAULT_DISABLED"
ERROR_PSI="${PN} requires CONFIG_PSI=y to function!"
ERROR_PSI_DEFAULT_DISABLED="${PN} requires psi=1 in the kernel boot options to function!"

src_prepare() {
	default

	# Build system and test suite hardcode sources directory name
	ln -s "${P}" "${WORKDIR}/${PN}"

	sed "s!/usr/local/bin/oomd_bin!/usr/bin/oomd!g" -i "etc/oomd.service"
}

# Build system automagically picks up dependencies in release version
# Changes in my fork require a newer version of meson than upstream's build system
if [[ "${PV}" != "0.1.0" ]] ; then
src_configure() {
	local emesonargs=(
		$(meson_feature systemd)
		$(meson_feature test)
	)
	meson_src_configure
}
fi

src_install() {
	meson_src_install
	mv "${ED}/usr/bin/oomd_bin" "${ED}/usr/bin/oomd"
	dodoc ${DOCS}
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	use systemd && systemd_newunit etc/oomd.service oomd.service
	insinto /etc
	newins etc/desktop.json oomd.json
}

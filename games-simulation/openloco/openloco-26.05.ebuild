# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit cmake xdg

MY_PN="OpenLoco"
OG_PN="OpenGraphics"
OG_PV="0.1.8"

DESCRIPTION="An open source re-implementation of Chris Sawyer's Locomotion"
HOMEPAGE="https://openloco.io/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz
	https://github.com/${MY_PN}/${OG_PN}/archive/refs/tags/v${OG_PV}.tar.gz -> ${MY_PN}-${OG_PN}-${OG_PV}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libpng:=
	dev-libs/libzip:=
	media-libs/openal
	media-libs/libsdl3
	dev-cpp/yaml-cpp
	dev-libs/libfmt
	dev-cpp/tbb"
DEPEND="${RDEPEND}
	dev-cpp/sfl-library"

src_prepare() {
	# Kludge to use system sfl
	sed -e "/sfl::sfl/d" -i "${S}/src/Core/CMakeLists.txt"

	# Put data files in /usr/share subfolder
	sed -e "/install(DIRECTORY/s#_BINDIR}/data#_DATAROOTDIR}/${MY_PN}#g" -i "${S}/CMakeLists.txt"
	sed -e 's# / "data"#.parent_path() / "share/OpenLoco"#g' -i "${S}/src/OpenLoco/src/Environment.cpp"

	cmake_src_prepare
}

src_configure() {
	# Build system supports using ccache automatically if available. We don't want
	# to do this, Portage will handle it. However the variable to use ccache is
	# only defined by the build system if ccache is installed and found, so we
	# need a hack to avoid a QA warning if sys-devel/ccache is not installed.
	local ARG_CCACHE=""
	has_version -b "sys-devel/ccache" && ARG_CCACHE="-DOPENLOCO_USE_CCACHE=false"

	local mycmakeargs=(
		-DFETCHCONTENT_FULLY_DISCONNECTED=true
		-DFETCHCONTENT_SOURCE_DIR_OPENLOCO_OBJECTS="${WORKDIR}/${OG_PN}-${OG_PV}/"
		-DFETCHCONTENT_SOURCE_DIR_SFL="${EPREFIX}/usr/include"
		-DOPENLOCO_BUILD_TESTS=false
		-DSTRICT=false # Turn off -Werror
		$ARG_CCACHE
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "You must provide original game data from Locomotion to play OpenLoco!"
	elog "It's possible to unpack from a retail game disc with app-arch/unshield:"
	elog " unshield x -g \"Default File Group\" /path/to/cdrom/data1.cab"
	elog " unshield x -g \"Default File Group\" /path/to/cdrom/data2.cab"
	elog " mv \"Default File Group\" OpenLoco"
	elog " cp -R /path/to/cdrom/Data OpenLoco/"
	elog "Move this folder somewhere convenient (f.e. ~/.local/share/games/OpenLoco)"
	elog "then run OpenLoco for the first time *from a terminal* to provide the"
	elog "location of this folder. It prompts *in the terminal* for this path."
}

# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit cmake

DESCRIPTION="Low-level C++ wrapper around the Berkeley sockets library"
HOMEPAGE="https://fpagliughi.github.io/sockpp/"
SRC_URI="https://github.com/fpagliughi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="~amd64"

IUSE="static-libs doc utils test"

# Implicit depend on C and C++ standard libraries and nothing else
BDEPEND="test? ( dev-cpp/catch:0 )"

RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare
	if use doc
	then
		# Convince the docs to end up in /usr/share/doc/${P}
		sed -e "/OUTPUT_DIRECTORY/s#doc#doc/@CMAKE_PROJECT_NAME@-@CMAKE_PROJECT_VERSION@#g" -i "doc/Doxyfile.cmake"
		doxygen -u "doc/Doxyfile.cmake" 2>/dev/null || die "Updating Doxygen configuration failed"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DSOCKPP_BUILD_SHARED=ON
		-DSOCKPP_BUILD_STATIC=$(usex static-libs)
		-DSOCKPP_BUILD_DOCUMENTATION=$(usex doc)
		-DSOCKPP_BUILD_EXAMPLES=$(usex utils)
		-DSOCKPP_BUILD_TESTS=$(usex test)
		-DSOCKPP_BUILD_CAN=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use utils
	then
		# Binary names are quite generic and this is the easiest fix
		cd "${D}/usr/bin"
		for i in *
		do
			mv "$i" "${PN}-$i"
		done
	fi
}

src_test() {
	cd "${CMAKE_USE_DIR}_build/tests/unit"
	cmake_src_test
}

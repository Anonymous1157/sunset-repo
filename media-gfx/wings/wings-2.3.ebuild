# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =media-gfx/wings-2.2.6.1 from default Gentoo overlay

EAPI=7
inherit toolchain-funcs

DESCRIPTION="Wings 3D is an advanced subdivision modeler"
HOMEPAGE="http://www.wings3d.com/"
SRC_URI="https://github.com/dgud/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>dev-lang/erlang-21[wxwidgets]
	dev-libs/cl
	media-libs/glu
	media-libs/libsdl[opengl]
	virtual/opengl
"
DEPEND="
	${RDEPEND}
	sci-libs/libigl
	dev-cpp/eigen
"

src_prepare() {
	sed -i -e 's# -Werror##g;s# -O3##g' $(find -name Makefile) || die
	sed -i -e 's#DEPS += libigl eigen##g' $(find -name Makefile) || die
	sed -i -e 's#../_deps/eigen#/usr/include/eigen3#g' $(find -name Makefile) || die
	sed -i -e 's#../_deps/libigl/include#/usr/include/igl#g' $(find -name Makefile) || die
	default
}

src_compile() {
	export ERL_PATH="/usr/$(get_libdir)/erlang/lib/"
	tc-export CC
	# Work around parallel make issues
	# Set ER_LIBS to the top source directory
	emake vsn.mk
	for subdir in intl_tools e3d src plugins_src icons; do
		emake -C ${subdir} opt ERL_LIBS="${S}"
	done
	default
}

src_install() {
	WINGS_PATH=${ERL_PATH}/${P}
	dodir ${WINGS_PATH}

	find -name 'Makefile*' -exec rm -f '{}' \;

	insinto ${WINGS_PATH}
	doins -r e3d ebin icons plugins priv psd shaders src textures tools

	newbin "${FILESDIR}"/wings.sh-r1 wings
	dodoc AUTHORS README.md
}

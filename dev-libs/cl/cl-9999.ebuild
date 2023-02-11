# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =dev-libs/cl-1.2.4-r2 from default Gentoo overlay

EAPI=8

inherit git-r3

DESCRIPTION="OpenCL bindings for Erlang"
HOMEPAGE="https://github.com/tonyrog/cl"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-lang/erlang-16
	dev-util/rebar:0
	virtual/opencl
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e 's# -Werror##g;s# -O3##g' $(find -name Makefile) || die
	default
}

src_compile() {
	rebar compile || die
}

src_install() {
	ERLANG_DIR="/usr/$(get_libdir)/erlang/lib"
	CL_DIR="${ERLANG_DIR}/${P}"
	insinto "${CL_DIR}"
	doins -r ebin src include c_src examples priv
}

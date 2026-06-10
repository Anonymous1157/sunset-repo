# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit cmake

DESCRIPTION="Header-only C++11 library that provides several new or lesser-known containers"
HOMEPAGE="https://github.com/slavenf/sfl-library"
SRC_URI="https://github.com/slavenf/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

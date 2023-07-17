# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

DESCRIPTION="Recompress FLAC files while preserving tags"
HOMEPAGE="https://github.com/chungy/reflac"
SRC_URI="https://github.com/chungy/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-shells/bash"
BDEPEND="app-text/asciidoc"

DOCS=(
	"${S}/README.adoc"
	"${S}/NEWS.adoc"
)

src_install() {
	emake install prefix=/usr DESTDIR="${D}"
	einstalldocs
}

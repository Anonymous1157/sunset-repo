# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Magic 8-ball toy"
HOMEPAGE="https://github.com/Anonymous1157/8ball"
EGIT_COMMIT="c65519d441d97de08d04945ad97a0cff15f0d017"
SRC_URI="https://github.com/Anonymous1157/8ball/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

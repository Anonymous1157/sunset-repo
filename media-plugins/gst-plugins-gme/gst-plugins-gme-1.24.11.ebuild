# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: =media-plugins/gst-plugins-mpg123-1.22.3-r1 from default Gentoo overlay

EAPI=7
GST_ORG_MODULE=gst-plugins-bad

inherit gstreamer-meson

DESCRIPTION="Various video game music formats decoder plugin for GStreamer"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

RDEPEND="
	media-libs/game-music-emu[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"

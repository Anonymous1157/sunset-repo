# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=7

inherit xdg

DESCRIPTION="An icon theme inspired by material design"
HOMEPAGE="https://github.com/daniruiz/Flat-Remix"

if [[ "${PV%9999}" == "${PV}" ]] ; then
	SRC_URI="https://github.com/daniruiz/Flat-Remix/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

src_prepare() {
	# Partial deduplication, reduces install size by more than half
	# (It's possible to do even better but this is a complexity tradeoff,
	#  and the theme should really be restructured not to need this at all)
	for i in Green Red Yellow Black Brown Cyan Grey Magenta Orange Teal Violet
	do
		for j in actions apps devices panel status animations categories emblems mimetypes
		do
			rm -rf Flat-Remix-$i-Dark/$j
			ln -s ../Flat-Remix-Blue-Dark/$j Flat-Remix-$i-Dark/$j
		done
	done

	default
}

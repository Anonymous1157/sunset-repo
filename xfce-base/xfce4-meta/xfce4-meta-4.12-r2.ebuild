# Copyright 1999-2018 Gentoo Foundation
# Copyright 2019 Sunset <sunsetsergal@gmail.com>
# Distributed under the terms of the GNU General Public License v2

# Source: =xfce-base/xfce4-meta-4.12-r1 from default Gentoo overlay

EAPI=6

DESCRIPTION="The Xfce Desktop Environment (meta package)"
HOMEPAGE="https://www.xfce.org/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="minimal +svg +themes gtk3"

RDEPEND="themes? (
		>=x11-themes/gtk-engines-xfce-3:0
		gtk3? ( >=x11-themes/gtk-engines-xfce-3:3 )
	)
	x11-themes/hicolor-icon-theme
	>=xfce-base/xfce4-appfinder-4.12
	>=xfce-base/xfce4-panel-4.12
	>=xfce-base/xfce4-session-4.12
	>=xfce-base/xfce4-settings-4.12
	>=xfce-base/xfdesktop-4.12
	>=xfce-base/xfwm4-4.12
	!minimal? (
		media-fonts/dejavu
		virtual/freedesktop-icon-theme
		)
	svg? ( gnome-base/librsvg )"

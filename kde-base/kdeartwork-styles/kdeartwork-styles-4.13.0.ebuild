# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-styles/kdeartwork-styles-4.13.0.ebuild,v 1.2 2014/04/17 00:43:41 johu Exp $

EAPI=5

KMMODULE="styles"
KMNAME="kdeartwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Extra KWin styles and window decorations"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kwin '' 4.11)
"
RDEPEND="${DEPEND}"

KMEXTRA="
	kwin-styles/
"

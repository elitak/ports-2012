# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kiriki/kiriki-4.13.1.ebuild,v 1.1 2014/05/13 17:43:16 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Kiriki - a gtali clone for KDE4"
HOMEPAGE="
	http://www.kde.org/applications/games/kiriki/
	http://games.kde.org/game.php?game=kiriki
"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

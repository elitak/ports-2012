# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.13.1.ebuild,v 1.1 2014/05/13 17:43:47 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug openal"

DEPEND="
	openal? (
		media-libs/libsndfile
		media-libs/openal
	)
"
RDEPEND="${DEPEND}
	!<kde-base/kbreakout-4.10.50:4
"

KMSAVELIBS="true"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use openal USE_OPENAL_SNDFILE)
	)

	kde4-base_src_configure
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-bittorrent/lc-bittorrent-0.6.60.ebuild,v 1.3 2014/04/03 08:07:13 zlogene Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Full-featured BitTorrent client plugin for LeechCraft."

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug geoip"

DEPEND="~app-leechcraft/lc-core-${PV}
		net-libs/rb_libtorrent"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show
		geoip? ( dev-libs/geoip )"

src_configure(){
	local mycmakeargs="
		$(cmake-utils_use_enable geoip BITTORRENT_GEOIP)
	"
	cmake-utils_src_configure
}

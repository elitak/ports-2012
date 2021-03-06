# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-sdl/emul-linux-x86-sdl-20140406.ebuild,v 1.2 2014/05/04 12:23:23 pacho Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="LGPL-2 LGPL-2.1 ZLIB"
KEYWORDS="-* amd64"
IUSE="abi_x86_32"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-xlibs-${PV}
	~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-soundlibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}
	abi_x86_32? (
		>=media-libs/openal-1.15.1-r1[abi_x86_32(-)]
	)"

src_prepare() {
	emul-linux-x86_src_prepare

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(cat "${FILESDIR}/remove-native")
}

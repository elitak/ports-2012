# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-1.4-r1.ebuild,v 1.1 2008/05/16 22:09:38 george Exp $

inherit eutils

DESCRIPTION="gnat module for eselect."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
RDEPEND="app-admin/eselect"

MODULEDIR="/usr/share/eselect/modules"

# NOTE!!
# This path is duplicated in gnat-eselect module,
# adjust in both locations!
LIBDIR="/usr/share/gnat/lib"

src_install() {
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	newins "${FILESDIR}"/gnat.eselect-${PV} gnat.eselect
	dodir ${LIBDIR}
	insinto ${LIBDIR}
	# !ATTN!
	# Make sure to adjust version of installed file to a proper one if there is
	# a change!
	newins "${FILESDIR}"/gnat-common-${PVR}.bash gnat-common.bash
}

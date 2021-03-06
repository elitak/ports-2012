# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bbe/bbe-0.2.2.ebuild,v 1.8 2013/06/30 18:17:32 ago Exp $

EAPI=5

inherit autotools

DESCRIPTION="Sed-like editor for binary files."
HOMEPAGE="http://sourceforge.net/projects/bbe-/"
SRC_URI="mirror://sourceforge/${PN}-/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	sed -i -e '/^htmldir/d' doc/Makefile.am || die
	eaclocal
	eautoreconf
}

src_configure() {
	econf --htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
}

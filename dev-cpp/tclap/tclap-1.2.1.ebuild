# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tclap/tclap-1.2.1.ebuild,v 1.5 2014/01/14 18:13:42 grobian Exp $

EAPI="5"
inherit eutils

DESCRIPTION="Simple templatized C++ library for parsing command line arguments."
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	econf $(use_enable doc doxygen)
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}/usr/share/doc/${PF}/html" install
}

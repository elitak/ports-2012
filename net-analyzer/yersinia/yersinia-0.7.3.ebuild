# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/yersinia/yersinia-0.7.3.ebuild,v 1.4 2014/05/04 08:26:43 ago Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="A layer 2 attack framework"
HOMEPAGE="http://www.yersinia.net/"
SRC_URI="http://www.yersinia.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk ncurses"

RDEPEND="
	ncurses? ( >=sys-libs/ncurses-5.5 )
	gtk? ( =x11-libs/gtk+-2* )
	>=net-libs/libnet-1.1.2
	>=net-libs/libpcap-0.9.4
"
DEPEND="
	virtual/pkgconfig
	${RDEPEND}
"

DOCS=( AUTHORS ChangeLog FAQ README THANKS TODO )

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7.1-no-ncurses.patch
	epatch "${FILESDIR}"/${PN}-0.7.3-tinfo.patch

	eautoreconf
}

src_configure() {
	econf \
		--enable-admin \
		--with-pcap-includes=/usr/include \
		$(use_with ncurses) \
		$(use_enable gtk)
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

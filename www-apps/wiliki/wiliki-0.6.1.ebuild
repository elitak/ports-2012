# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wiliki/wiliki-0.6.1.ebuild,v 1.1 2010/07/02 00:21:32 chiiph Exp $

EAPI="3"

inherit webapp eutils

MY_PN="WiLiKi"
MY_P=${MY_PN}-${PV}

DESCRIPTION="WiLiKi is a lightweight Wiki engine written in and running on Gauche Scheme."
HOMEPAGE="http://practical-scheme.net/wiliki/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cgi fastcgi"

DEPEND="dev-scheme/gauche
	cgi? ( virtual/httpd-cgi )
	fastcgi? ( virtual/httpd-fastcgi )"
RDEPEND="${DEPEND}"

need_httpd_cgi

WEBAPP_MANUAL_SLOT="yes"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-po-gentoo.patch
	epatch "${FILESDIR}"/${P}-cgi-gentoo.patch
}

src_install() {
	webapp_src_preinst
	emake DESTDIR="${D}" install || die "Install failed"

	insinto "${MY_CGIBINDIR}"
	doins -r src/wiliki.cgi src/wiliki2.cgi || die "doins failed"
	fperms +x "${MY_CGIBINDIR}"/wiliki.cgi || die "fperms failed"

	insinto "${MY_HTDOCSDIR}"
	doins src/wiliki.css src/wiliki2.css || die "doins failed"

	dodir "${MY_HOSTROOTDIR}"/${PF}/data || die "dodir failed"
	webapp_serverowned "${MY_HOSTROOTDIR}"/${PF}/data

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "Quickstart:"
	einfo "	modify wiliki.cgi to customize the WiLiKi's behavior"
	einfo "	modify wiliki.css to customize the WiLiKi's look"
	einfo
	einfo " http://localhost/cgi-bin/wiliki.cgi"
	einfo

	webapp_pkg_postinst
}

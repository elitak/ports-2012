# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/servefile/servefile-0.4.3.ebuild,v 1.1 2013/12/31 19:41:44 sping Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Serve a single file via HTTP"
HOMEPAGE="http://seba-geek.de/stuff/servefile/"
SRC_URI="http://seba-geek.de/proj/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND=""
RDEPEND="( sys-apps/iproute2 sys-apps/net-tools )
	ssl? ( dev-python/pyopenssl )
	sys-apps/grep
	sys-apps/sed
	virtual/python-argparse"

src_install() {
	distutils_src_install
	dodoc ChangeLog || die
	doman ${PN}.1 || die
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xtrabackup-bin/xtrabackup-bin-2.1.7.ebuild,v 1.2 2014/03/01 22:27:57 mgorny Exp $

EAPI=5

MY_PN="percona-${PN/-bin}"
MY_PVR="${PV}-721"
MY_P="${MY_PN}-${PV}"
MY_PF="${MY_PN}-${MY_PVR}"

inherit eutils

DESCRIPTION="MySQL hot backup software that performs non-blocking backups for
InnoDB and XtraDB databases"
HOMEPAGE="http://www.percona.com/software/percona-xtrabackup"
SRC_URI="
	amd64? (
		http://www.percona.com/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/x86_64/${MY_PF}-Linux-x86_64.tar.gz -> ${MY_P}-x86_64.tar.gz
	)
	x86? (
		http://www.percona.com/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/i686/${MY_PF}-Linux-i686.tar.gz -> ${MY_P}-x86_32.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libaio
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error"

if use amd64; then
	S="${WORKDIR}/${MY_P}-Linux-x86_64"
elif use x86; then
	S="${WORKDIR}/${MY_P}-Linux-i686"
fi

src_prepare() {
	# bug 501904 - CVE-2014-2029
	epatch "${FILESDIR}/${P}-no-versioncheck.patch"
}

src_install() {
	for bin in innobackupex xbcrypt xbstream xtrabackup xtrabackup_55 xtrabackup_56; do
		dobin bin/${bin}
	done
	dosym /usr/bin/innobackupex /usr/bin/innobackupex-1.5.1
}

pkg_postinst() {
	einfo "xtrabackup 2.1.x is for MySQL/MariaDB 5.5 and 5.6 only"
}

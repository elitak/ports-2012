# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/rts_pstor/rts_pstor-1.10-r1.ebuild,v 1.2 2013/07/03 00:36:45 vikraman Exp $

EAPI=4

inherit linux-mod

DESCRIPTION="PCIE RTS5209 card reader driver for Linux"
HOMEPAGE="http://www.realtek.com.tw/Downloads/downloadsView.aspx?PNid=15&PFid=25&Level=4&Conn=3&DownTypeID=3"
SRC_URI="http://dev.gentoo.org/~vikraman/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

MODULE_NAMES="rts_pstor(kernel/drivers/scsi)"
BUILD_TARGETS="default"

src_prepare() {
	sed -i -e 's/\/lib\/modules\/\$(shell uname -r)\/build\//\$(KERNELDIR)/g' Makefile || die "Sed failed!"
	[ ${KV_MAJOR} -ge 3 ] && [ ${KV_MINOR} -ge 8 ] && epatch "${FILESDIR}/${PN}-linux-3.8.patch"
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
}

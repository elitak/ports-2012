# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.3.4.ebuild,v 1.4 2014/04/18 08:14:49 pacho Exp $

EAPI=5
AUTOTOOLS_AUTORECONF=1
inherit autotools-multilib

DESCRIPTION="The Ogg Vorbis sound file format library"
HOMEPAGE="http://xiph.org/vorbis"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND="media-libs/libogg[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"

AUTOTOOLS_PRUNE_LIBTOOL_FILES=all

src_prepare() {
	sed -i \
		-e '/CFLAGS/s:-O20::' \
		-e '/CFLAGS/s:-mcpu=750::' \
		configure.ac || die

	# Un-hack docdir redefinition.
	find -name 'Makefile.am' \
		-exec sed -i \
			-e 's:$(datadir)/doc/$(PACKAGE)-$(VERSION):@docdir@/html:' \
			{} + || die

	AT_M4DIR="m4" \
	autotools-multilib_src_prepare
}

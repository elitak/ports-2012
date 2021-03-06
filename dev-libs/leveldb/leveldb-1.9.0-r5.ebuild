# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/leveldb/leveldb-1.9.0-r5.ebuild,v 1.4 2013/05/14 11:46:12 ago Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="a fast key-value storage library written at Google"
HOMEPAGE="http://code.google.com/p/leveldb/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="+snappy static-libs"

DEPEND="
	snappy? (
		app-arch/snappy
		static-libs? ( app-arch/snappy[static-libs] )
	)"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.9.0-configure.patch
}

src_configure() {
	# These vars all get picked up by build_detect_platform
	# which the Makefile runs for us automatically.
	tc-export AR CC CXX
	export OPT="-DNDEBUG ${CPPFLAGS}"
	# Probably needs more filling out
	export TARGET_OS
	case ${CHOST} in
	*) TARGET_OS="Linux";;
	esac
	export USE_SNAPPY=$(usex snappy)
	export USE_TCMALLOC=no
}

src_compile() {
	emake $(usex static-libs '' 'LIBRARY=') all libmemenv.a
}

src_test() {
	emake check
}

src_install() {
	insinto /usr/include
	doins -r include/* helpers/memenv/memenv.h
	dolib.so libleveldb*$(get_libname)*
	use static-libs && dolib.a libleveldb.a
	dolib.a libmemenv.a
}

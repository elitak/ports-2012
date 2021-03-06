# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/libxml/libxml-0.1.1.ebuild,v 1.1 2013/10/19 09:55:02 gienah Exp $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to libxml2"
HOMEPAGE="http://hackage.haskell.org/package/libxml"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~x86 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-haskell/mtl:=[profile?]
	>=dev-lang/ghc-6.10.4:=
	dev-libs/libxml2
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6.0.3
	virtual/pkgconfig
"

src_prepare() {
	sed -e 's@includes: libxml/xmlIO.h libxml/xmlmemory.h@pkgconfig-depends: libxml-2.0@' \
		-i "${S}/${PN}.cabal" \
		|| die "Could not patch libxml2 configuration in ${PN}.cabal"
}

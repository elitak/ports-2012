# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/rfc5051/rfc5051-0.1.0.3.ebuild,v 1.1 2013/11/20 14:24:00 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Simple unicode collation as per RFC5051."
HOMEPAGE="http://hackage.haskell.org/package/rfc5051"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="mkunicodedata"

RDEPEND=">=dev-lang/ghc-7.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10.0.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag mkunicodedata mkunicodedata)
}

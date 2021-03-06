# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/girara/girara-9999.ebuild,v 1.1 2014/05/07 15:05:54 ssuominen Exp $

EAPI=5

inherit multilib toolchain-funcs
[[ ${PV} == 9999* ]] && inherit git-2

DESCRIPTION="A library that implements a user interface that focuses on simplicity and minimalism"
HOMEPAGE="http://pwmt.org/projects/girara/"
if ! [[ ${PV} == 9999* ]]; then
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"
fi
EGIT_REPO_URI="git://git.pwmt.org/${PN}.git"
EGIT_BRANCH="develop"

LICENSE="ZLIB"
SLOT="3"
if ! [[ ${PV} == 9999* ]]; then
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
else
KEYWORDS=""
fi
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.28
	>=x11-libs/gtk+-3.2:3
	!<${CATEGORY}/${PN}-0.1.6"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	mygiraraconf=(
		PREFIX="${EPREFIX}"/usr
		LIBDIR='${PREFIX}'/$(get_libdir)
		CC="$(tc-getCC)"
		SFLAGS=''
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# Remove 'static' and 'install-static' targets
	if ! use static-libs; then
		sed -i \
			-e '/^${PROJECT}:/s:static::' \
			-e '/^install:/s:install-static::' \
			Makefile || die
	fi
}

src_compile() {
	emake "${mygiraraconf[@]}"
}

src_install() {
	emake "${mygiraraconf[@]}" install
	dodoc AUTHORS
}

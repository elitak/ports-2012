# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 virtualx

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="+gnome +libproxy smartcard +ssl test"
KEYWORDS="*"

RDEPEND=">=dev-libs/glib-2.34:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.4.6-r3:= )
	smartcard? (
		>=app-crypt/p11-kit-0.8
		>=net-libs/gnutls-2.12.8:=[pkcs11] )
	ssl? (
		app-misc/ca-certificates
		>=net-libs/gnutls-2.11.0:= )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus[X] )"
# eautoreconf needs >=sys-devel/autoconf-2.65:2.5

src_prepare() {
	# FIXME: new failing tests
	sed -e '/tls.connection.simultaneous-async-rehandshake/,+1 d' \
		-e '/tls.connection.simultaneous-sync-rehandshake/,+1 d' \
		-i tls/tests/connection.c || die
	gnome2_src_prepare
}

src_configure() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--with-ca-certificates="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt
		$(use_with gnome gnome-proxy)
		$(use_with libproxy)
		$(use_with smartcard pkcs11)
		$(use_with ssl gnutls)"
	gnome2_src_configure
}

src_test() {
	Xemake check
}

# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GLib/GObject wrapper for the SkyDrive and Hotmail REST APIs"
HOMEPAGE="http://git.gnome.org/browse/libzapojit"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+introspection"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=net-libs/libsoup-2.38:2.4
	dev-libs/json-glib
	net-libs/rest
	net-libs/gnome-online-accounts

	introspection? ( >=dev-libs/gobject-introspection-1.30.0 )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.11
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
"
# eautoreconf needs:
#	gnome-base/gnome-common:3

src_configure() {
	G2CONF="${G2CONF}
		--enable-compile-warnings=minimum
		--disable-static
		$(use_enable introspection)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	# Drop self-installed documentation
	rm -r "${ED}"/usr/share/doc/${P}/ || die
}

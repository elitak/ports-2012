# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"

inherit mate multilib

DESCRIPTION="Fork of bluez-gnome focused on integration with MATE"
HOMEPAGE="http://mate-desktop.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+introspection test"

RESTRICT="test"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7.0
	dev-libs/dbus-glib
	dev-libs/libunique:1"

RDEPEND="${COMMON_DEPEND}
	app-mobilephone/obexd
	virtual/udev
	introspection? ( dev-libs/gobject-introspection )"

DEPEND="${COMMON_DEPEND}
	<net-wireless/bluez-5.0
	!net-wireless/bluez-gnome
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/mate-doc-utils-1.2.1
	app-text/scrollkeeper
	dev-libs/libxml2
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-libs/libX11
	x11-libs/libXi
	x11-proto/xproto
	>=mate-base/mate-common-1.2.1"

src_prepare() {
	# Fix test
	sed -i 's:applet/bluetooth-:applet/mate-bluetooth-:g' \
		po/POTFILES.skip || die

	# Tarball has no proper build system, should be fixed on next release.
	mate_gen_build_system

	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS README NEWS ChangeLog"

	gnome2_src_configure \
		$(use_enable introspection) \
		--disable-moblin \
		--disable-desktop-update \
		--disable-icon-update \
		--disable-schemas-compile
}

src_install() {
	gnome2_src_install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/80-mate-rfkill.rules
}

pkg_postinst() {
	gnome2_pkg_postinst

	enewgroup plugdev

	elog "Don't forget to add yourself to the plugdev group "
	elog "if you want to be able to control bluetooth transmitter."
}

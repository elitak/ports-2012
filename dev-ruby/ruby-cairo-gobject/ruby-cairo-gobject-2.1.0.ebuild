# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-cairo-gobject/ruby-cairo-gobject-2.1.0.ebuild,v 1.1 2014/01/15 18:39:23 naota Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit ruby-ng-gnome2

RUBY_S="ruby-gnome2-all-${PV}/cairo-gobject"

DESCRIPTION="Ruby cairo-gobject bindings"
KEYWORDS="~amd64"
IUSE=""

DEPNED="${DEPNED} x11-libs/cairo"
RDEPEND="${RDEPEND} x11-libs/cairo"

ruby_add_rdepend "dev-ruby/rcairo
	>=dev-ruby/ruby-glib2-${PV}"

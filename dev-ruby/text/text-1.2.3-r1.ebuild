# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/text/text-1.2.3-r1.ebuild,v 1.5 2014/04/24 17:41:36 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A collection of text algorithms"
HOMEPAGE="https://github.com/threedaymonk/text"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64"
IUSE=""

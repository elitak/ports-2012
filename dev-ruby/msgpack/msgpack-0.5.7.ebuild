# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/msgpack/msgpack-0.5.7.ebuild,v 1.2 2013/12/22 18:40:57 blueness Exp $

EAPI=5

# jruby → uses a binary extension
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="Binary-based efficient data interchange format for ruby binding"
HOMEPAGE="http://msgpack.sourceforge.jp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc"

ruby_add_bdepend "doc? ( dev-ruby/yard )"

all_ruby_prepare() {
	sed -i -e '/bundler/I s:^:#:' Rakefile || die
}

each_ruby_prepare() {
	case "${RUBY}" in
		*ruby18)
			# Fix tests as .clear is not available in ruby18
			# Tests are working, but are very slow on ruby18
			sed -i -e 's/s.clear/s.replace ""/' spec/buffer_spec.rb || die
			# Avoid tests requiring ruby 1.9+
			sed -i -e '/frozen short strings/,/end/ s:^:#:' \
				-e '/frozen long strings/,/end/ s:^:#:' spec/unpacker_spec.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die "Configuration of extension failed."
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/msgpack$(get_modname) lib/${PN} || die "Unable to install msgpack library."
}

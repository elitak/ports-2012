# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MediaWiki-API/MediaWiki-API-0.390.0.ebuild,v 1.6 2014/05/04 15:14:40 zlogene Exp $

EAPI=5

MODULE_AUTHOR="EXOBUZZ"
MODULE_VERSION="0.39"
inherit perl-module

DESCRIPTION="A OO interface to the Mediawiki API"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=dev-perl/DateTime-1
	dev-perl/DateTime-Format-ISO8601
	dev-perl/JSON
	dev-perl/libwww-perl
	virtual/perl-Encode
	virtual/perl-Test-Simple
"

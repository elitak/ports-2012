# Copyright 2013-2014 Jonathan Vasquez <jvasquez1011@gmail.com>
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils mount-boot

# Variables
_LV="KS.01"                     # Local Version
_PLV="${PV}-${_LV}"             # Package Version + Local Version (Module Dir)
_KN="linux-${_PLV}"             # Kernel Directory Name
_KD="/usr/src/${_KN}"           # Kernel Directory
_CONF="xyinn.conf"				# Blacklisted Kernel Modules
_BD="/boot/kernels/${_PLV}"     # Kernel /boot Directory

# Main
DESCRIPTION="Precompiled Vanilla Kernel (Kernel Ready-to-Eat [KRE])"
HOMEPAGE="http://xyinn.org/"
SRC_URI="http://xyinn.org/gentoo/kernels/${_PLV}/kernel-${_PLV}.tar.xz"

RESTRICT="mirror strip"
LICENSE="GPL-2"
SLOT="${_PLV}"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_compile()
{
	# Unset ARCH so that you don't get Makefile not found messages
	unset ARCH && return;
}

src_install()
{
	# Install Kernel
	mkdir -p ${D}/${_BD}
	cp ${S}/kernel/System.map-${_PLV} ${D}/${_BD}/System.map
	cp ${S}/kernel/vmlinuz-${_PLV} ${D}/${_BD}/vmlinuz
	cp ${S}/kernel/config-${_PLV} ${D}/${_BD}/config

	# Install Modules
	mkdir -p ${D}/lib/modules/
	cp -r ${S}/modules/${_PLV} ${D}/lib/modules

	# Install Headers
	mkdir -p ${D}/usr/src
	cp -r ${S}/headers/${_KN} ${D}/usr/src

	# Install Blacklist
	mkdir -p ${D}/etc/modprobe.d/
	cp ${S}/modules/${_CONF} ${D}/etc/modprobe.d/
}

pkg_postinst()
{
	# Set a symlink to this kernel if /usr/src/linux doesn't exist

	# Do not create symlink via 'symlink' use flag. This package will be re-emerged
	# when an 'emerge @module-rebuild' is done. If a person does this and the symlink use flag
	# is set, it will change the symlink to this ebuild, possibly not recompiling packages that
	# are suppose to be recompiled for another kernel.

	if [[ ! -e "/usr/src/linux" ]]; then
		einfo "Creating symlink to ${_KD}"
		cd /usr/src && ln -s ${_KN} linux
	fi
}

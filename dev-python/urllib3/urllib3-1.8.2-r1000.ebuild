# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="3.1 *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more."
HOMEPAGE="https://urllib3.readthedocs.org/ https://github.com/shazow/urllib3 https://pypi.python.org/pypi/urllib3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RDEPEND="$(python_abi_depend -i "2.* 3.1" dev-python/backports.ssl_match_hostname)
	$(python_abi_depend dev-python/six)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? (
		$(python_abi_depend dev-python/mock)
		$(python_abi_depend -e "3.1 *-jython" www-servers/tornado)
	)"

DOCS="CHANGES.rst CONTRIBUTORS.txt README.rst"

src_prepare() {
	distutils_src_prepare

	# Fix compatibility with Python 3.1.
	sed -e "s/if sys.version_info < (2, 7):/if sys.version_info < (2, 7) or sys.version_info[:2] == (3, 1):/" -i urllib3/connection.py

	# Use system version of dev-python/six.
	sed \
		-e "s/from .packages import six/import six/" \
		-e "s/from .packages.six import/from six import/" \
		-i urllib3/*.py
	sed -e "s/from ..packages import six/import six/" -i urllib3/*/*.py
	sed \
		-e "s/from urllib3.packages import six/import six/" \
		-e "s/from urllib3.packages.six import/from six import/" \
		-i test/*.py
	rm urllib3/packages/six.py

	# Disable minimum percentage of coverage for tests to pass.
	sed -e "/cover-min-percentage = 100/d" -i setup.cfg
}

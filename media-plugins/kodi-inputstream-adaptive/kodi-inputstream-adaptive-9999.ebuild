# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/peak3d/inputstream.adaptive.git"
SRC_URI=""

case ${PV} in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/peak3d/inputstream.adaptive.git"
	EGIT_BRANCH="Omega"
	inherit git-r3
	;;
*)
	KEYWORDS="~amd64 ~x86"
	CODENAME="Omega"
	SRC_URI="https://github.com/peak3d/inputstream.adaptive/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/inputstream.adaptive-${PV}-${CODENAME}"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
RESTRICT="!test? ( test )"
IUSE="test"

COMMON_DEPEND="
	dev-libs/expat
	dev-libs/pugixml
	=media-tv/kodi-21*
	"
DEPEND="
	${COMMON_DEPEND}
	test? ( dev-cpp/gtest )
	"
RDEPEND="
	${COMMON_DEPEND}
	"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

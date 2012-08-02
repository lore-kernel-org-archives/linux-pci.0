Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57689 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2HBF6y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 01:58:54 -0400
Date: Thu, 2 Aug 2012 07:58:39 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jiang Liu <liuj97@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 12/32] PCI/ARM: use PCIe capabilities access functions
 to simplify implementation
Message-ID: <20120802055839.GA12241@avionic-0098.adnet.avionic-design.de>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
 <1343836477-7287-13-git-send-email-jiang.liu@huawei.com>
 <5019654D.2000408@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
In-Reply-To: <5019654D.2000408@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 11:20:13AM -0600, Stephen Warren wrote:
> On 08/01/2012 09:54 AM, Jiang Liu wrote:
> > From: Jiang Liu <jiang.liu@huawei.com>
> >=20
> > Use PCIe capabilities access functions to simplify PCIe ARM implementat=
ion.
> >=20
> > Signed-off-by: Jiang Liu <liuj97@gmail.com>
>=20
> This is probably fine from my perspective assuming the underlying PCI
> API implementation is OKd by relevant people.
>=20
> Thierry, can you comment on whether this will conflict with your Tegra
> PCIe driver series? If it doesn't, this patch can go through any
> relevant PCI tree. If it does, we may have to take this through the
> Tegra tree after merging the dependencies, or defer it to later.

I haven't touched those lines. tegra_pcie_relax_enable() only uses
generic PCI functions so I don't expect any conflicts. git blame
confirms that those lines haven't been changed in about 2 years.

Thierry

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGhcPAAoJEN0jrNd/PrOhusQP/08wAhZTckZwHx11iVgTk2Sy
kZ7tEljEX3D6AX7rCacbH9FC6eYkwoX0wZfgo2kHyvzPsb/7hvXiIEjC9w/vohJj
UYzn/i9RfNDWrzJuVcy4WTHJSWuk8xE836CTjJ310Rx3XqpvdHjm8GzABbLuA6rN
sCidwvhh+OgjhBOAWRJpCbMLqEhiyYAttuetHByfwACmUJjNfdXd09fMptDWkFCN
w0YJSNIBqgnyFGkZsCc7jibCkMOsy1ByxmQFrBbeSaqoHwK0zNrVjP4r9CTW8DXg
/An61mZvLWBQCzdYOuAbCMde3Itw0OEYuQ7WgmURdqLPQbt7GQobV+0J/6PV0sT1
cEbyEp2VkgdslJKjPf37OmKO/kP2Bdw6RlX+n3Sb2785TkAzFWa7vb+D1kOaM5fS
gyhgRyCAkAryM2wAmf9GFLxuYv/VPPYhwtkUb0rYjtEWL0fyYPWhoq/eV684T505
h0KV4G5AqMKe8no8B2on0ojRTk6IQ4d8UHO80lv3M1Kca/90AZrZ5qGJCVjnK843
WiQ1XOJiPmJJ6s5nmoCcP23b5/Y0Hj5pY8u/lYqS1u8EXZ4D+KCE+wWv38LF9ULw
gm+pJgRmMlMa0yvMrjN+mE9i8LDf0fYcnMV5NdNfjzYxmnNgDTVSSbKtk2ZjldRM
DRknhvw3fPO58/mR7u1f
=dPrT
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

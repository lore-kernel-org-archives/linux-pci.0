Return-Path: <SRS0=vA1w=DI=gmail.com=thierry.reding@kernel.org>
Return-Path: <SRS0=vA1w=DI=gmail.com=thierry.reding@kernel.org>
Date: Tue, 12 Dec 2017 13:22:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171212122252.GA29883@ulmo>
References: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
 <20171211105431.GI10671@ulmo>
 <20171211175452.GC16032@bhelgaas-glaptop.roam.corp.google.com>
 <20171212110158.GA30601@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <20171212110158.GA30601@e107981-ln.cambridge.arm.com>
List-ID: <linux-pci.vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 11:01:58AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 11, 2017 at 11:54:53AM -0600, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> >=20
> > On Mon, Dec 11, 2017 at 11:54:31AM +0100, Thierry Reding wrote:
> > > On Mon, Dec 04, 2017 at 11:23:48PM +0530, Vidya Sagar wrote:
> > > > PCIe host controller in Tegra SoCs has 1GB of aperture available
> > > > for mapping end points config space, IO and BARs. In that, currently
> > > > 256MB is being reserved for mapping end points configuration space
> > > > which leaves less memory space available for mapping end points BARs
> > > > on some of the platforms.
> > > > This patch series attempts to map only 4K space from 1GB aperture to
> > > > access end points configuration space.
> > > >=20
> > > > Currently, this change can benefit T20 and T186 in saving (i.e. rep=
urposed
> > > > to use for BAR mapping) physical space as well as kernel virtual ma=
pping space,
> > > > it saves only kernel virtual address space in T30, T124, T132 and T=
210.
> > > >=20
> > > > NOTE: Since T186 PCIe DT entry is not yet present in main line (it =
is currently
> > > > merged to 'for-4.15/arm64/dt' branch), nothing gets broken with thi=
s change for T186.
> > > > For older platforms (T20, T30, T124, T132, T210), this change works=
 fine without any
> > > > DT modifications
> > > >=20
> > > > Testing Done on T124, T210 & T186:
> > > >  Enumeration and basic functionality of immediate devices
> > > >  Enumeration of devices behind a PCIe switch
> > > >  Complete 4K configuration space access
> > > >=20
> > > > Vidya Sagar (2):
> > > >   PCI: tegra: refactor config space mapping code
> > > >   ARM64: tegra: limit PCIe config space mapping to 4K for T186
> > > >=20
> > > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +-
> > > >  drivers/pci/host/pci-tegra.c             | 125 ++++++++++---------=
------------
> > > >  2 files changed, 44 insertions(+), 89 deletions(-)
> > >=20
> > > Hi Bjorn,
> > >=20
> > > there's a bunch of PCI related patches for Tegra floating around on t=
he
> > > lists. I'm wondering if you'd be okay if I pick those up into the Teg=
ra
> > > tree after they've been reviewed and send you a pull request later on
> > > (say around v4.15-rc6). That would allow me to get things cooking in
> > > linux-next for a bit and get broader testing in addition to the
> > > flexibility to patch things up if they break.
> >=20
> > Lorenzo will be merging the Tegra stuff, so this is more a question
> > for him.
> >=20
> > Just to clarify, I think your questions is about putting those patches
> > in
> > git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git#for-next.
> > If you put them there they will show up in linux-next, and then when
> > Lorenzo merges them, you'll have to coordinate so they don't get
> > merged into linux-next twice (once via the usual PCI tree route and
> > again via the Tegra tree).
> >=20
> > If you wait until after they've been reviewed to put them into the
> > Tegra tree, I'm not sure what the gain is, because I assume Lorenzo
> > would merge them at about that same point.
>=20
> I think that after the review, the Tegra patches that are considered for
> upstream they should go to -next via the PCI tree as any other platform P=
CI
> patches; the relevant patches need ACKs from the respective platform
> maintainer - I am getting to them as fast as I can.

Just to clarify: I wasn't suggesting that these patches are merged for
v4.16 via the Tegra tree, only that I carry them in the Tegra tree for a
little while so that we can get broader testing and fix things up in
case they break. My proposal was to then send a pull request for
inclusion in the PCI tree. linux-next can deal with this type of
scenario just fine because it will simply see the same branch twice and
ignore the second one.

If you prefer to merge directly via the PCI tree that works for me too.

Thierry

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlovyhkACgkQ3SOs138+
s6HIoA//UOk1Pqde8iX0UEGdNSME8v7GmCtfPEE8EvLEt2URNFcZDF4KWvFONg7R
BNpn9yjOs83UTHlVIG0Vqwxl5SwvzMKXshCxNbFvkM5t1a6VUZqdyEFQ8idRtb7F
4LkY9WHd9zTpw62jVAPZfT76v2XZxKHjR61r/iDeYLefP5r9tbg8iZlYroBO9aAA
qwaKtU1d8rAeu/UIZle1jm9ThoklA+6KccnkyYg3eyoBChbYEOvf635bVupl9di+
qJcIHT6ma4tzmVxqxIYKyuTZejjYjoYYjo3DrCBsLfPAJFpGe3ojap5XfaSFYYFl
GKxf7QuavHGsx1m5sRr6NuK18ZNgRIC1DVZARrfUb6PfRC6TjV9aJEPcwnmW8itO
cRWxgVjT48sP0gDUfpOd++onDw1jkzdNyINITWv48L+VJU6giHTr7I3XS1pU2fuy
psE/I8r8S6yWT0jz7mseZu2unHAT8YkHnfIL3Lf5qzHwDXV0Dxc7x7RrexdyKLII
Q53Vn4C3k8SkvvG6R7LzEZi6he+V7wpY6/yrFsoOEmjKU1pwJi2ypzmno9TBBCHn
+Gs2n30imJ4oh11uc5YaAxub7mIcT3wdnTt8Es3J/ao2MdKtVYRxaw5J4l+H0FOP
VSWejveoRUpBoNu5JFwqTv/pIDefwBt6Vv+4vQTj+KYXNkXQDwc=
=9Mbc
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

Return-Path: <SRS0=Q4WY=DK=gmail.com=thierry.reding@kernel.org>
Return-Path: <SRS0=Q4WY=DK=gmail.com=thierry.reding@kernel.org>
Date: Thu, 14 Dec 2017 15:01:02 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171214140102.GA13733@ulmo>
References: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
 <20171211105431.GI10671@ulmo>
 <20171211175452.GC16032@bhelgaas-glaptop.roam.corp.google.com>
 <20171212110158.GA30601@e107981-ln.cambridge.arm.com>
 <20171212122252.GA29883@ulmo>
 <20171214103722.GC697@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <20171214103722.GC697@e107981-ln.cambridge.arm.com>
List-ID: <linux-pci.vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 10:37:22AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 12, 2017 at 01:22:52PM +0100, Thierry Reding wrote:
>=20
> [...]
>=20
> > > > > Hi Bjorn,
> > > > >=20
> > > > > there's a bunch of PCI related patches for Tegra floating around =
on the
> > > > > lists. I'm wondering if you'd be okay if I pick those up into the=
 Tegra
> > > > > tree after they've been reviewed and send you a pull request late=
r on
> > > > > (say around v4.15-rc6). That would allow me to get things cooking=
 in
> > > > > linux-next for a bit and get broader testing in addition to the
> > > > > flexibility to patch things up if they break.
> > > >=20
> > > > Lorenzo will be merging the Tegra stuff, so this is more a question
> > > > for him.
> > > >=20
> > > > Just to clarify, I think your questions is about putting those patc=
hes
> > > > in
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git#for-n=
ext.
> > > > If you put them there they will show up in linux-next, and then when
> > > > Lorenzo merges them, you'll have to coordinate so they don't get
> > > > merged into linux-next twice (once via the usual PCI tree route and
> > > > again via the Tegra tree).
> > > >=20
> > > > If you wait until after they've been reviewed to put them into the
> > > > Tegra tree, I'm not sure what the gain is, because I assume Lorenzo
> > > > would merge them at about that same point.
> > >=20
> > > I think that after the review, the Tegra patches that are considered =
for
> > > upstream they should go to -next via the PCI tree as any other platfo=
rm PCI
> > > patches; the relevant patches need ACKs from the respective platform
> > > maintainer - I am getting to them as fast as I can.
> >=20
> > Just to clarify: I wasn't suggesting that these patches are merged for
> > v4.16 via the Tegra tree, only that I carry them in the Tegra tree for a
> > little while so that we can get broader testing and fix things up in
> > case they break. My proposal was to then send a pull request for
> > inclusion in the PCI tree. linux-next can deal with this type of
> > scenario just fine because it will simply see the same branch twice and
> > ignore the second one.
> >=20
> > If you prefer to merge directly via the PCI tree that works for me too.
>=20
> We would end up merging the patches into -next at the same time, so there
> is not much point in queuing them via Tegra if they go via the PCI tree
> eventually; we should not add to -next patches that are not ready to
> be merged anyway.
>=20
> I need your help (ACKs) though to queue them up - I review the patches
> but I can neither test them nor get access to HW TRMs so for some of them
> there is not much I can do.

I've sent out a small series of patches that apply on top of this patch
which clean up and fix a couple of issues with this patch. Feel free to
squash those into this patch if you prefer.

Acked-by: Thierry Reding <treding@nvidia.com>

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyhBsACgkQ3SOs138+
s6F9FhAAgE5n6VHwNbYSZ78NxuKPk6e7NiGFVGFcSXcl66rSbJkNjVeGttV6KxS0
HQnFQ0RxRulJG7UYZcCjuj8JHWHg9F9XWHcxlyLUb/wB0Pt66B+/asko9XRwNb1B
M1Mv64fmZ32tXTq8/DlHkzoL7CxTx+qZI/LdAF1yCFE7pTf9+JSrmKCrRQJArTAf
BjPSFo5SWEhbLbU9BVHmQbDR6I1T0xQxw/rNcorPTKwgOeU4h2ZjfJro5J4o4Cnz
FdxC+5//IqOBHvllM3vuAAcyiTW+FEqoJmx06LXPHn4DNNdTeRrLLktj/AVAmwz9
5VaV5k8go9PAcRHs+xl+pgDnc6tCvcongRHWRzGIw7RsRf74TmYRZkHflf5oYky5
JTIuKwylllgfCYK7zNS3VyoyQBDmTQgcb6NH3id6O5yBr9qrNHxAr717yYaujWQj
FiZK412AafBIOkYICYFVTDjd+LTh8BPu4sWrfb9hP3L+HI6jty05n2M2yX/gRVpd
8UMHHkFNdOLuD/zy6rHjHyWFCFoUrQ4H7q+tkeHtyrfUU+avkhOsZEp9OOgAxEqI
C9mWUDdpiWzP9Ic1dmv5d0boXeqHKGfHSSu0pHyOQyJtCYHj8LHg4NsYag4gIRkl
o1UePXpRnexg7UZcE1KhF2jal1l/lAkuvclinh37FeE7+6Hc4m4=
=2a4C
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

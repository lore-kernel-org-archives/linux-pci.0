Return-Path: <SRS0=mgv/=AA=gmail.com=thierry.reding@kernel.org>
Return-Path: <SRS0=mgv/=AA=gmail.com=thierry.reding@kernel.org>
Date: Wed, 30 Aug 2017 16:25:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, bhelgaas@google.com,
	jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Message-ID: <20170830142547.GC1361@ulmo>
References: <1504013940-16304-1-git-send-email-himanshujha199640@gmail.com>
 <20170829135517.GA30733@ulmo>
 <20170830135931.GA18250@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <20170830135931.GA18250@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 08:59:31AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 29, 2017 at 03:55:17PM +0200, Thierry Reding wrote:
> > On Tue, Aug 29, 2017 at 07:09:00PM +0530, Himanshu Jha wrote:
> > > Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> > >=20
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > ---
> > >  drivers/pci/host/pci-tegra.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
> > > index 9c40da5..90cda5b 100644
> > > --- a/drivers/pci/host/pci-tegra.c
> > > +++ b/drivers/pci/host/pci-tegra.c
> > > @@ -1156,10 +1156,7 @@ static int tegra_pcie_resets_get(struct tegra_=
pcie *pcie)
> > >  		return PTR_ERR(pcie->afi_rst);
> > > =20
> > >  	pcie->pcie_xrst =3D devm_reset_control_get_exclusive(dev, "pcie_x");
> > > -	if (IS_ERR(pcie->pcie_xrst))
> > > -		return PTR_ERR(pcie->pcie_xrst);
> > > -
> > > -	return 0;
> > > +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
> > >  }
> >=20
> > I'm not a big fan of this construct because it's a pain to undo this if
> > ever we need to add code to this function. But since we do have scripts
> > that will flag this, I guess this would pop up every now and again. The
> > driver is unlikely to change in this part, too, so:
>=20
> Thanks for pointing this out.  Do you know what the benefit of
> PTR_ERR_OR_ZERO() is?  To me, it makes the following code harder
> to read because the error tests are no longer parallel:
>=20
>   ...
>   res->ahb_reset =3D devm_reset_control_get(dev, "ahb");
>   if (IS_ERR(res->ahb_reset))
>     return PTR_ERR(res->ahb_reset);
>=20
>   res->por_reset =3D devm_reset_control_get(dev, "por");
>   if (IS_ERR(res->por_reset))
>     return PTR_ERR(res->por_reset);
>=20
>   res->phy_reset =3D devm_reset_control_get(dev, "phy");
>   return PTR_ERR_OR_ZERO(res->phy_reset);
>=20
> So I'd be inclined to avoid it unless there's some significant benefit.

Yeah, I don't like the optics much either. Aside from the fact that it
reduces the line count, I'm not aware of any benefits that this inline
function has. It doesn't have any side-effects or anything, just wraps
the common pattern into a single line.

Looking at the history of the semantic patch that is the basis for the
conversions (scripts/coccinelle/api/ptr_ret.cocci), or the static inline
function itself, no rationale is given for why people prefer this. I've
certainly seen such patches applied in some cases, but I've also seen
other maintainers (including myself) reject them because of personal
preference.

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmmyukACgkQ3SOs138+
s6H6mQ//QN7i0CknRoKAjKehKqxks6wjWHpEaSbHMJSoexeQ+AZ4+6UV/cf9iV6i
jPuk2Z02OP6AxzHJIiDQhnwGJIHwqOpHzsU7fNQO4vIXlNxzGAwb07dddks/jmjg
Al6dGTpOuHzar/tgALHpJYU+LJ+K9iji6cR9U6MIzHTsTy5LjHSWS0spyWsBfLlD
yGWL9kui+g4trwBySDTfqNhIFDgDd+HZjRCKdwWA95GqyLtSyAu4ibrx57+Or6vE
ewpsbfj6KSmirbm+tb+fc1Y4VE+rVzl+Pn40wMYF0XAWvgcSLL25zkiDeuWH3A7I
6x06LyGKNa5IE/GRzZ+B0XsYEL2ZeO9TRYUYnZ6bAhX/ZjsE07O2F6Y36/1v1h3t
ruZXm7lLvuEyz6KhwetvPmLZiec+F1t4qT1FtwCaWpHR1aOCQgLB8SbAsjI2G6ys
VMA8fdRQ1lpDDmabHOupD7isK7bJTxO7G408Npv+y+P32ExrAFYQRSozvXiJMhtt
H4GFsV4J7eqoQrs1t3OHg46+na7Va1lNp9EcQynE0x4xE5CAXV03TiipG/3PFftQ
m+2dX1OEi36A3Ojcl7AW3I9H3PlrdrixqMip3sSnuKoDuKuVJhdCQb8NoHGQzK5E
40qt767vmvyKprRPI6Zo+hTw9n1EekZs3pTl9Z5JRJ6KdXJH32Q=
=kz+p
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

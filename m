Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Date: Fri, 10 Nov 2017 10:37:37 +0100
From: Thierry Reding <treding@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>, <swarren@nvidia.com>, <mmaddireddy@nvidia.com>, "Michal
 Simek" <michal.simek@xilinx.com>, =?utf-8?B?U8O2cmVu?= Brinkmann
	<soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20171110093737.GA25067@ulmo>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
List-ID: <linux-pci.vger.kernel.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 12:11:05AM +0530, Vidya Sagar wrote:
>=20
>=20
> On Thursday 09 November 2017 11:44 PM, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> >=20
> > On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
> > > On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
> > > > On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
> > > > > limits MSI target address to only 32-bit region to enable
> > > > > some of the PCIe end points where only 32-bit MSIs
> > > > > are supported work properly.
> > > > > One example being Marvel SATA controller
> > > > >=20
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >   drivers/pci/host/pci-tegra.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-=
tegra.c
> > > > > index 1987fec1f126..03d3dcdd06c2 100644
> > > > > --- a/drivers/pci/host/pci-tegra.c
> > > > > +++ b/drivers/pci/host/pci-tegra.c
> > > > > @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct teg=
ra_pcie *pcie)
> > > > >   	}
> > > > >   	/* setup AFI/FPCI range */
> > > > > -	msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
> > > > > +	msi->pages =3D __get_free_pages(GFP_DMA, 0);
> > > > >   	msi->phys =3D virt_to_phys((void *)msi->pages);
> > > > Should this be GFP_DMA32?  See the comment above the GFP_DMA
> > > > definition.
> > > looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP=
_DMA32
> > > is the correct one to use, but, even with that I got >32-bit addresse=
s.
> > > GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
> > > I didn't dig into it to find out why is this the case.
> > This sounds worth looking into (but maybe we don't need the
> > __get_free_pages() at all; see below).  Maybe there's some underlying
> > bug.  My laptop shows this, which looks like it might be related:
> >=20
> >    Zone ranges:
> >      DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >      DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> >      Normal   [mem 0x0000000100000000-0x00000004217fffff]
> >      Device   empty
> >=20
> > What does your machine show?
> I see following in my linux box
> =C2=A0Zone ranges:
> =C2=A0=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [mem 0x0000000000001000-0x=
0000000000ffffff]
> =C2=A0=C2=A0 DMA32=C2=A0=C2=A0=C2=A0 [mem 0x0000000001000000-0x00000000ff=
ffffff]
> =C2=A0=C2=A0 Normal=C2=A0=C2=A0 [mem 0x0000000100000000-0x000000106efffff=
f]
> =C2=A0=C2=A0 Device=C2=A0=C2=A0 empty
>=20
> and following in my T210 Tegra platform
> Zone ranges:
> =C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [mem 0x0000000080000000-0x000000=
00ffffffff]
> =C2=A0 Normal=C2=A0=C2=A0 [mem 0x0000000100000000-0x000000017fffffff]

This seems to be happening because 64-bit ARM doesn't have the
ZONE_DMA32 Kconfig option, which seems to cause the DMA32 zone
to default to the normal zone (see include/linux/gfp.h).

That's very confusing in conjunction with the kerneldoc comment
for GFP_DMA32 because it isn't actually guaranteed to give you
32-bit addresses for !ZONE_DMA32.

Cc'ing Arnd who knows about these things.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloFc10ACgkQ3SOs138+
s6EKlRAAn9yBJOqLw30D0WNuNn4I7r5mcXtnDlghqy2ph577cJtJ/1NIBmG6t3cW
lCVzL4aEt9G24O0NcE10EjDsrk6CX27RUCO/oCfhWxwtIB+j4exH37XzWxZjJEhl
9FmCDSX4PPzmHSga6wF7NFzEd1NcMaZihWTkrbEVnQpnJqy0RoOBPQ+M63yuJTPf
8IU93/woFwn2yjVafjJBextEwwjH0BwiWT34Ijiva5iEfnJ8M4IWlML0rfhH6uDX
nPYDYNEtQsMDPzTkCrXBeDqCkq4cedyNwE6YcicH4CiUCFF6qGYvC9izQme6iF2/
3uGTbmMgcvS4Cs/2E1sxHgUFakdrDsAqOh6VmOAhG06Y2FcIMsthI8skFZCkhLaf
tcaj5T9ATiElpo8yzh5/D05AutyM3ds1Sk9d/8YWC+TrmJxmFLSYkqG788BmAHlQ
++0UAqGWxkFZD+fNmmQDPbn65o0N8PtqAqDzSVvVAqwsF/GTFC0F4QmWgie6myGo
uB/dQWKqnED/pkvVFPllEVNcHd1NrGaVYXGoBbwLvHkwcxnZHOutzkDdPRM6RK5a
kJofwHMZrYN6HX13vUugq8Lnt0/1AviPaRp3/qWwPnxyfG3/lywAS70XVaPW5Xw5
ATlCDtldNak+8+I2QF6qpuKRtChSqmED/7TtrSJObjzXF8YayY4=
=Obcq
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45455 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdI1OTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2017 10:19:16 -0400
Date: Thu, 28 Sep 2017 16:19:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: vidya sagar <sagar.tv@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use different MSI target address for Tegra20
Message-ID: <20170928141912.GB28022@ulmo>
References: <20170923061740.6012-1-treding@nvidia.com>
 <CAN7O0+JyG3XT5SsWGsiZs0vrk0ha1vQ5N7rjYxs3tM_NvdONdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
In-Reply-To: <CAN7O0+JyG3XT5SsWGsiZs0vrk0ha1vQ5N7rjYxs3tM_NvdONdw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 10:44:29AM +0530, vidya sagar wrote:
> Inline...
>=20
> On Sat, Sep 23, 2017 at 11:47 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > The Tegra20 PCIe controller has a different address range for MSI, so
> > select a different target address.
> >
> > Fixes: d7bd554f27c9 ("PCI: tegra: Do not allocate MSI target memory")
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/host/pci-tegra.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index e8e1ddbaabc9..5b02ea59524b 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -1563,8 +1563,18 @@ static int tegra_pcie_enable_msi(struct tegra_pc=
ie *pcie)
> >          * none of the Tegra SoCs that contain this PCI host bridge can
> >          * address more than 16 GiB of system memory, the last 4 KiB of
> >          * these 1012 GiB is a good candidate.
> > +        *
> > +        * Unfortunately, Tegra20 is slightly different in that the phy=
sical
> > +        * address for this MSI region is limited to the lower 32 bits =
of the
> > +        * address map, so the address that we pick is going to have to=
 be
> > +        * located somewhere within the region addressable by the CPU a=
nd
> > +        * on-SoC controllers. To be on the safe side, we select an add=
ress
> > +        * from a region that is marked unused (0xf0010000 - 0xfffeffff=
).
> >          */
> > -       msi->phys =3D 0xfcfffff000;
> > +       if (soc->msi_base_shift > 0)
> > +               msi->phys =3D 0xfcfffff000;
> > +       else
> > +               msi->phys =3D 0x00f0010000;
>=20
> Can we use this for later Tegra chip versions as well?
> Reason being, if an end point's config space says that it cannot
> support >32-bit MSI addresses (Marvel SATA controller being one
> example), with the current code, we still allocate an address of
> >32-bits, resulting in end point not being able to generate MSI
> interrupt (as it discards >32-bits where generating upstream memory
> write transaction for MSI)

Looks like the universal fix for this may not be trivial, so perhaps in
the meantime this one could go in in order to restore MSI for TrimSlice
(and other Tegra20 boards)?

Bjorn: do you have any objections to taking this into v4.13 via a stable
backport? 32-bit only MSI were never guaranteed to work because prior to
this patch the address was taken from an allocated page, which may or
may not have been > 4 GiB.

We could then go and fix 32-bit MSI hopefully in time for 4.14, but it'd
be a shame if v4.13 keeps being broken just because we're trying to
settle on the right solution for 32-bit MSI.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnNBN0ACgkQ3SOs138+
s6ER9g//VAYNmyvfIpGDGM9/w6J+Tz0hrsaOuOGE/W41pyfzAAr+mCDRIXwAXTMV
LTRnWBr9xFMJOrHBy2I7HBURke7GdU4yz+L0GvYUbwI5wgyI+GGzNwdlnwN956Yi
2XsP2UWuj0qs0Sb1xqvPHkzXkehL4NKy48xmu/0lF3tP6Eh9oIKL1ZnXDHlAHVJ3
5AjUNCpqsHNriLTapc95AGjucaCuu79bx3jQUL84YwfZ/lZF5n7cuGVkOR2567KF
S7+SoCl9nLPyNQuzHepAr/ixYlXYUFXx0BBclkieY8ERS9shauyyicMg5SeZFo5S
CqSLhVfG/gidimqzcYvW5PIi+zYPTUrw23cTq4xXKQ2kTUflPRzlJsTfVV2ZVcRY
khOGaR8WsO1k7GtPCtxuEmERzh+JCYcbmXx43oDAcUojydQ1apSNy5DuikQCk+f5
SfTAljT6ZnWWTrNKyTPq6YY/mjjruvtKEQzp23SBa+QNKysFnSgrLHTwmCk1+jzU
On/hYTIIvNAR+HETq7P5n21C+s+G+rVSWoA/Qgw8urrUAnb+QcmCvYDOQ5Qky0LE
+1t2pdKJ9TyVQejMjUD74YKiW0jD+KMZ+7jGiGMpkWx29eoCEWkjlR+YleUtyI78
1TuZy+yXO5Kq6mGVy0510JjAwndTp4ZvQzVNUBU+C+tSTDy1UPY=
=C3fW
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

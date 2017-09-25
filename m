Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:47005 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbdIYIv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2017 04:51:29 -0400
Date: Mon, 25 Sep 2017 10:51:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: vidya sagar <sagar.tv@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use different MSI target address for Tegra20
Message-ID: <20170925085125.GC12494@ulmo.fritz.box>
References: <20170923061740.6012-1-treding@nvidia.com>
 <CAN7O0+JyG3XT5SsWGsiZs0vrk0ha1vQ5N7rjYxs3tM_NvdONdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
In-Reply-To: <CAN7O0+JyG3XT5SsWGsiZs0vrk0ha1vQ5N7rjYxs3tM_NvdONdw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--JWEK1jqKZ6MHAcjA
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

I hadn't considered this case. My recollection was that the PCI express
specification required every endpoint to support 64-bit MSI, but looking
again, legacy endpoints are allowed to support 32-bit MSI only, and we
could technically have one of those connected via a PCI-to-PCIe bridge.

The reason I chose 0xf0010000 for Tegra20 is because that is part of a
region that has never been used. For Tegra30 and later that address is
within the address range of system memory.

Testing has shown that the memory at the destination address isn't
actually written (the PCI host bridge seems to decode the address and
notice that it is the MSI target address and not commit the data to
memory), so technically it shouldn't matter what address we use. I'm
somewhat reluctant to use a random address, though, because having it
point to something within system memory could get confusing (if that
address shows up somewhere, how are people supposed to know this has
to do with MSI?).

Another possibility would be to use some address from within the PCIe
controller's address space that is unused. We have the following as the
current mappings:

  Tegra186:
    0x10000000-0x10000fff  port 0 configuration space
    0x10001000-0x10001fff  port 1 configuration space
    0x10003000-0x100037ff  PADS registers
    0x10003800-0x10003fff  AFI registers
    0x10004000-0x10004fff  port 2 configuration space
    0x40000000-0x4fffffff  configuration space
    0x50000000-0x5000ffff  downstream I/O
    0x50100000-0x57ffffff  non-prefetchable memory
    0x58000000-0x7fffffff  prefetchable memory

  Tegra210 and Tegra124:
    0x01000000-0x01000fff  port 0 configuration space
    0x01001000-0x01001fff  port 1 configuration space
    0x01003000-0x010037ff  PADS registers
    0x01003800-0x01003fff  AFI registers
    0x02000000-0x11ffffff  configuration space
    0x12000000-0x1200ffff  downstream I/O
    0x13000000-0x1fffffff  non-prefetchable memory
    0x20000000-0x3fffffff  prefetchable memory

  Tegra30:
    0x00000000-0x00000fff  port 0 configuration space
    0x00001000-0x00001fff  port 1 configuration space
    0x00003000-0x000037ff  PADS registers
    0x00003800-0x00003fff  AFI registers
    0x00004000-0x00004fff  port 2 configuration space
    0x02000000-0x0200ffff  downstream I/O
    0x10000000-0x1fffffff  configuration space
    0x20000000-0x27ffffff  non-prefetchable memory
    0x28000000-0x3fffffff  prefetchable memory

  Tegra20:
    0x80000000-0x80000fff  port 0 configuration space
    0x80001000-0x80001fff  port 1 configuration space
    0x80003000-0x800037ff  PADS registers
    0x80003800-0x80003fff  AFI registers
    0x82000000-0x8200ffff  downstream I/O
    0x90000000-0x9fffffff  configuration space
    0xa0000000-0xa07fffff  non-prefetchable memory
    0xa8000000-0xbfffffff  prefetchable memory

Something like the following might work as MSI target addresses, though
I haven't tested that these actually work as expected:

  Tegra186: 0x10fff000-0x10ffffff
  Tegra210: 0x01fff000-0x01ffffff
  Tegra124: 0x01fff000-0x01ffffff
  Tegra30:  0x01fff000-0x01ffffff
  Tegra20:  0x81fff000-0x81ffffff

Any thought on that?

Thierry

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnIw4sACgkQ3SOs138+
s6FckxAAlfqwjOu6M1Fh765+z6cpFfQZX7U/tSIm7sk9o2X9MxRqY9jQqcQrBrfd
ajTxS+07iW1I+MSh3T39w9DcxfnvX6iDjf1ZvRUqVXv3eg87hcPwp2uZzFfwf515
k5luDpt6jZbZmJVEaMKU3cB31hWXWD4YyXU6FIGFcqADN2k2grJFSeXxqpGdZXgk
vIgnTJdabaoT2Dy5zoLOZGm5q6cYMBB9dFPEGHYLXVRrMRgdR+rs4xRS8OIX5IpW
nDHgUg3GpBnCQxmAMpaqDOnoPfyTRt2dS3YoKDxcgP4nakSQVMTHPgwZ9/J4cpZP
7+64s99hlKllIZ8IarHQOkA8VDsy+NKJPAhixL7iVsk4GcskKg/e1aoGLmGGVmCs
yXoJ195HtMyXZEX/X2k8BxoKKE2UJ6TglKjUu+L6uwqeSkdtTPOGwgxxHaZLif27
BxYS1qA8d55AWAtfABD/zY7cfHah0MtfnAvrWis16eEsaRECYJaLqwZ0qb9b0e3b
0o4Vb1iz5iyRqDOvdwQP0lAnqVwR8h63WWermN7eLM9MACky4b3D7bACuVAzA3k/
KQvhBjTTcvGlaQIb9s57t+aclc4QWedf7oWIMlO5O/EBUWlOqm/bTKT6TuO161ZO
b4IteAaA2oi5CGs91S9WKxS0xpy2cXqWh29A+vwydaHM5ZSxTjI=
=SB53
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

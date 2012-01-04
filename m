Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:53168 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751549Ab2ADRii (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 12:38:38 -0500
Date: Wed, 4 Jan 2012 09:38:34 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: [PATCH v3 08/34] alpha/PCI: convert to pci_scan_root_bus() for
 correct root bus resources
Message-ID: <20120104093834.39614a85@jbarnes-desktop>
In-Reply-To: <CAErSpo7WHixAQL2=ptHj+JUsE8W6PTG0ZEM1T0fYQAixqjm=pQ@mail.gmail.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
	<20111028222611.30729.46284.stgit@bhelgaas.mtv.corp.google.com>
	<CAErSpo7WHixAQL2=ptHj+JUsE8W6PTG0ZEM1T0fYQAixqjm=pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/uNKaQfjkhe.5DZ+.7SP5mGx"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/uNKaQfjkhe.5DZ+.7SP5mGx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Dec 2011 14:24:01 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Fri, Oct 28, 2011 at 4:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
> > Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
> > resource fixups. =A0This fixes the problem of "early" and "header" quir=
ks
> > seeing incorrect root bus resources.
> >
> > CC: linux-alpha@vger.kernel.org
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > =A0arch/alpha/kernel/pci.c | =A0 37 ++++++++++++++++++++---------------=
--
> > =A01 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> > index c9ab94e..e9e78a2 100644
> > --- a/arch/alpha/kernel/pci.c
> > +++ b/arch/alpha/kernel/pci.c
> > @@ -286,22 +286,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
> > =A0 =A0 =A0 =A0struct pci_controller *hose =3D bus->sysdata;
> > =A0 =A0 =A0 =A0struct pci_dev *dev =3D bus->self;
> >
> > - =A0 =A0 =A0 if (!dev) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Root bus. */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 pci_mem_end;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 sg_base =3D hose->sg_pci ? hose->sg_p=
ci->dma_base : ~0;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long end;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->resource[0] =3D hose->io_space;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->resource[1] =3D hose->mem_space;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adjust hose mem_space limit to prevent=
 PCI allocations
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in the iommu windows. */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_mem_end =3D min((u32)__direct_map_bas=
e, sg_base) - 1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D hose->mem_space->start + pci_mem_=
end;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hose->mem_space->end > end)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->mem_space->end =3D =
end;
> > - =A0 =A0 =A0 } else if (pci_probe_only &&
> > + =A0 =A0 =A0 if (pci_probe_only && dev &&
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dev->class >> 8) =3D=3D PCI_CLASS_=
BRIDGE_PCI) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_read_bridge_bases(bus);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pcibios_fixup_device_resources(dev, bus);
> > @@ -414,13 +399,31 @@ void __init
> > =A0common_init_pci(void)
> > =A0{
> > =A0 =A0 =A0 =A0struct pci_controller *hose;
> > + =A0 =A0 =A0 struct list_head resources;
> > =A0 =A0 =A0 =A0struct pci_bus *bus;
> > =A0 =A0 =A0 =A0int next_busno;
> > =A0 =A0 =A0 =A0int need_domain_info =3D 0;
> > + =A0 =A0 =A0 u32 pci_mem_end;
> > + =A0 =A0 =A0 u32 sg_base;
> > + =A0 =A0 =A0 unsigned long end;
> >
> > =A0 =A0 =A0 =A0/* Scan all of the recorded PCI controllers. =A0*/
> > =A0 =A0 =A0 =A0for (next_busno =3D 0, hose =3D hose_head; hose; hose =
=3D hose->next) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_scan_bus(next_busno, alpha_mv=
.pci_ops, hose);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_base =3D hose->sg_pci ? hose->sg_pci->=
dma_base : ~0;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Adjust hose mem_space limit to prevent=
 PCI allocations
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in the iommu windows. */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_mem_end =3D min((u32)__direct_map_bas=
e, sg_base) - 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D hose->mem_space->start + pci_mem_=
end;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hose->mem_space->end > end)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->mem_space->end =3D =
end;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&resources);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resources, &hose->io_sp=
ace);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resources, &hose->mem_s=
pace);
>=20
> These two lines are errors: hose->io_space is already a struct
> resource pointer, so we shouldn't take the pointer's address.  Updated
> patch and incremental patch attached.

Squashed into the original alpha patch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/uNKaQfjkhe.5DZ+.7SP5mGx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPBI6bAAoJEIEoDkX4Qk9h8gAP/R98tLfsl/POjIu2JE0HpjnL
RTIXhiLRH2LBswS8P5lSCLptWDEbqwPz6H+suKGkzvFoKYaBw4gZ9bc58+SmNEEJ
bavF1kpNOmOwkXbrTe2QSytkOjjE30e8s52gi8hqz1V7AIDgQwZWFyq9kJeyLOIN
szPqXdKbtidb+51zc1HxNywymT8zDwC5iDW9LYBfSOYR4L8n17o2wEkRVPeaxGq/
Wa7gR5vPaMcHV096Ev4ORjQBZrueDHbPqin+34yc4H5BgTQPOec/Ro64VC+bEWyx
nHmSXO3oQviK+X4sgDEkSlOcx8I2M+lgc6JXgYrO0Z/l8ND7iPgIO8fnKxrYxHe7
514w8eh/Ue/3QjwK3gQ6svLl74CZXOWu91Cthufz/mVvYSjJqdhPcvDUgfS4P6dl
Wy0TnT9G9bcRo5vVJt9R2SmtN+USWLbYqO8O8lftNlmpr7ysuFJ99MR4WhPZfbkg
eSnGSAJqsm1nB5uWqo9z/EeE4jcYtdwNWXPETeRaLyim9zBNbVRqUD3n1+g+KFDv
58TCokw0EmbhJwu/6x1CsTisWu+MlwqT/E5Svsm+3qGOfVfXy7ZoBW7z01CPo50Z
SngwDts0CqMLNdDiXsMPu/MqVPWFMZN2phEsVXc7QmBYQoN+yEKOTEmbMVhqPypt
gIIYBBdljVj22va+5gga
=egEV
-----END PGP SIGNATURE-----

--Sig_/uNKaQfjkhe.5DZ+.7SP5mGx--

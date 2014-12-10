Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56632 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaLJMNr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Dec 2014 07:13:47 -0500
Date: Wed, 10 Dec 2014 13:13:41 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra: apply relaxed ordering fixup only on
 Tegra
Message-ID: <20141210121339.GA23558@ulmo.nvidia.com>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
 <1415907457-3147-2-git-send-email-l.stach@pengutronix.de>
 <CAAVeFu+sYnhMEmDSPvinbP-BQQnqAu6rpEVgaLx25Y3UtGVUwQ@mail.gmail.com>
 <1418120897.2741.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <1418120897.2741.1.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 11:28:17AM +0100, Lucas Stach wrote:
> Am Dienstag, den 09.12.2014, 12:23 +0900 schrieb Alexandre Courbot:
> > Hi Lucas,
> >=20
> > Apologies for taking so long to come back to this. The patch looks ok
> > to me, just a minor comment about the Tegra PCI detection:
> >=20
> > On Fri, Nov 14, 2014 at 4:37 AM, Lucas Stach <l.stach@pengutronix.de> w=
rote:
> > > The fixup to enable relaxed ordering on all PCI devices was
> > > executed unconditionally if the Tegra PCI host driver was
> > > built into the kernel. This doesn't play nice with a
> > > multiplatform kernel executed on other platforms which
> > > may not need this fixup.
> > >
> > > Make sure to only apply the fixup if the root port is
> > > a Tegra.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  drivers/pci/host/pci-tegra.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
> > > index 3d43874319be..d5a14f22ebb8 100644
> > > --- a/drivers/pci/host/pci-tegra.c
> > > +++ b/drivers/pci/host/pci-tegra.c
> > > @@ -647,10 +647,34 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0=
x0bf1, tegra_pcie_fixup_class);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fix=
up_class);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fix=
up_class);
> > >
> > > +static int tegra_pcie_root_is_tegra(struct pci_dev *dev)
> > > +{
> > > +       struct pci_bus *bus =3D dev->bus;
> > > +       struct pci_dev *root_bridge;
> > > +
> > > +       /* walk up the PCIe hierarchy to the first level below the ro=
ot bus */
> > > +       while (bus->parent && bus->parent->self)
> > > +               bus =3D bus->parent;
> > > +
> > > +       /*
> > > +        * If there is no bridge on the bus the passed device is the =
root
> > > +        * bridge itself.
> > > +        */
> > > +       root_bridge =3D bus->self ? bus->self : dev;
> > > +       if (root_bridge->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
> > > +           (root_bridge->device =3D=3D 0x0bf0 || root_bridge->device=
 =3D=3D 0x0bf1 ||
> > > +            root_bridge->device =3D=3D 0x0e1c || root_bridge->device=
 =3D=3D 0x0e1d ||
> > > +            root_bridge->device =3D=3D 0x0e12 || root_bridge->device=
 =3D=3D 0x0e13))
> > > +               return 1;
> >=20
> > I am not very familiar with PCI so sorry if these are stupid
> > questions, but where do these device IDs come from? Are they needed at
> > all, e.g. can't you just test against root_bridge->vendor =3D=3D
> > PCI_VENDOR_ID_NVIDIA to detect a NVIDIA root? Is the list susceptible
> > to increase as new chips get released? If that's the case, how can we
> > make sure we won't forget to update it?
> >=20
>=20
> The device IDs are assigned by NVIDIA HW for the different Tegra PCI
> generation/link width combinations. Note that the K1 TRM is wrong as it
> still lists the T30 device IDs, instead of the ones used on K1.
>=20
> While we technically could test only against vendor=3D=3Dnvidia I don't
> think it is entirely safe. As this is a PCI fixup it will get executed
> on every device running a kernel including this PCI host bridge driver.=
=20
>=20
> So only testing for the vendor assumes that every ARM device with a PCI
> host bridge built by NVIDIA will be a Tegra. Do you think this is a
> reasonable assertion? I'm on the fence here.
> =20
> > If you need to test against the device ID, it might be more legible
> > (and easier to update) if you use a switch case, e.g:
> >=20
> >     if (root_bridge->vendor !=3D PCI_VENDOR_ID_NVIDIA)
> >         return 0;
> >     switch (root_bridge->device) {
> >     case 0x0bf0:
> >     case 0x0bf1:
> >     case 0x0e1c:
> >     case 0x0e1d:
> >     case 0x0e12:
> >     case 0x0e12:
> >         return 1;
> >     default:
> >         return 0;
> >     }
> >=20
> Right, this looks nicer and easier to extend. I'll have to think about
> if we need the device IDs at all and respin accordingly.

I think using the device ID is fine. If nothing else it'll at least
document the various device IDs. Perhaps you could extend this patch
with comments as to which device ID maps to which SoC. Or better yet
add them to include/linux/pci_ids.h with names matching the SoC.

Also I'm wondering if perhaps it'd be better yet to add these as a table
of struct pci_device_id:s and use pci_match_id() to avoid the switch
here. Granted, the table will be bigger in size because of the unused
fields, but it'd more clearly separate the data and code.

Thierry

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUiDjzAAoJEN0jrNd/PrOhC4gP/jFdUlfX8dyg0EPR8SHwAurD
QlgWXWZPeiPOQBJi4P5T9+jgXJMQwxXSQKRBnuJigb+W2iwZPaO6O0jbj47MOZYJ
hOR9GTfLq7+WeRi+nR7tT+vjhhJqaVmXGUJaFac5AFETVuHAS0g45/Mx+asoVh5O
kbouZF9yYHBTftU8Gdv30OCHapqvFmNriegk/T6Xjp1GhYsmflfBpwtuYWotQfea
P1mmiF7W5K3/ejalsCE777VwhSIoqhjuGainRkV7C8Fqfrg/lgAeFVAbBihyX470
OEltr13HCFcVuerM1q3W9muxsmpBNooAnzkPfwoEiai4Fhfp9gTeeg9OyLtQo26f
aSZDErIWM4rJ9TJ2cYK9pMZpCn8s2gFNhICP0Okdo+8My4+CMRedkk/f9q7ODp93
TKns68EGr+vvMjCs2iJjh2RO2XUcdmJ4TydqxcL5fIWlPA0XY8N8dQhuZ8Ztggcq
+uvG1y/AKHcQ9QSPfA2eq6c4yyMYNUGqx5Ka8pY4JYzivqn1Z092pWQ7p++P+1/S
TJGIUap+JQPmUi5AS/JbUDOaoRLuUdA/wTDAg4FQc0KOTcepm0yb5irUA1bi5MoY
bLNf86uAn/KA349g/FF/VNQg74QTDh27rgFnpjrJZcre4ma1/pfU9DnNNn14oQq+
lgD65vGrmyPED2RXAwK7
=rmYv
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

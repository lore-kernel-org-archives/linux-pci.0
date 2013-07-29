Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42699 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab3G2Gyg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 02:54:36 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so1422676bkg.36
        for <linux-pci@vger.kernel.org>; Sun, 28 Jul 2013 23:54:34 -0700 (PDT)
Date: Mon, 29 Jul 2013 08:54:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130729065431.GA1115@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E41F7A.4010502@gmail.com>
 <20130728043310.6CF1D3E08FE@localhost>
 <20130728162711.32a9a21e@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <20130728162711.32a9a21e@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2013 at 04:27:11PM +0200, Thomas Petazzoni wrote:
> Dear Grant Likely,
>=20
> Thanks for your feedback! Some comments below.
>=20
> On Sat, 27 Jul 2013 22:33:10 -0600, Grant Likely wrote:
>=20
> > > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.co=
m>
> > >=20
> > > Acked-by: Rob Herring <rob.herring@calxeda.com>
> >=20
> > Actually, I'm going to disagree on this one and say NAK. I don't think
> > it is a good idea to create a completely separate registry of msi_chips
> > for binding to dt nodes. I think it would be better to include the
> > msi_chip pointer directly into the irq_domain which has to be there
> > anyway. It then becomes another feature for irq controllers if it can
> > support doing MSI.
>=20
> The problem that this patch tries to solve is how can the PCIe driver
> work get a pointer to the msi_chip structure from the DT device node
> pointed to by the 'msi-parent' property. I.e, we have:
>=20
> 	interrupt-parent =3D <&mpic>;
>=20
> 	mpic {
> 		reg =3D <...>;
> 		compatible =3D "...";
> 		interrupt-controller;
> 		msi-controller;
> 	};
>=20
> 	pcie-controller {
> 		msi-parent =3D <&mpic>;
> 	};
>=20
> The 'mpic' driver registers two irq_domains, one for the "normal"
> interrupts, and one for the MSI interrupts. Both irq_domain cannot be
> associated to the same &mpic node, or the irq_domain lookup for
> interrupt-parent and msi-parent is going to be confused.
>=20
> In the very first version of this patch set, I was using two separate
> DT device nodes to avoid this problem:
>=20
> 	interrupt-parent =3D <&mpic>;
>=20
> 	interrupt-controller {
> 		reg =3D <...>;
> 		compatible =3D "...";
>=20
> 		mpic {
> 			interrupt-controller;
> 		};
>=20
> 		msi {
> 			msi-controller;
> 		};
> 	};
>=20
> 	pcie-controller {
> 		msi-parent =3D <&msi>;
> 	};
>=20
> This way, each of the two irq_domain was associated to a distinct DT
> device node, and everything was working fine. But during the review, I
> was pointed by Arnd that it wasn't the proper way of describing the
> interrupt controller, and that there should be only one DT device node
> having both the interrupt-controller and msi-controller roles.
>=20
> So what is your suggestion to allow the PCIe controller to retrieve the
> correct irq_domain if we have only one DT node for the IRQ controller
> that registers two irq_domains ?

If I understand correctly, Grant isn't objecting to the introduction of
the lookup function, but rather its implementation. You could add a
pointer to a struct msi_chip within struct irq_domain and then iterate
over all irq_domain instances (see irq_find_host()) and find one which
has the correct device_node pointer and the msi_chip pointer set.

So I think that pretty much boils down to setting the (new) .msi_chip
field of armada_370_xp_msi_domain to the newly allocated MSI chip in
armada_370_xp_msi_init() and modify the lookup function to use the
irq_domain_list instead of the list of of_pci_msi_chip_list(). And a
whole lot of the infrastructure code can go away because it's already
there for irq_domain.

The good thing about it is that it couples the MSI chip more strongly
with its associated IRQ domain. And as a bonus we get to omit the list
and of_node fields from struct msi_chip. =3D)

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9hGnAAoJEN0jrNd/PrOhXpoP/iGIYzE3l/COXXhqGmt60FOi
AeTP3wsj/6xjmeDf011H/Bo/QmUxoXtKKS6IfYrjDsQljstPIybe05CJKww13dNu
pHi7bNr1Myh5znJaV8JzmdrdqD1ahSJPktforv7r60eYUcL2EgnRiKbZO2PCEN8B
TQd9wGH5BEb8rmzVFTITRHVPArFkcjaILvWp0kuaa5n0z2G/NMgwmdpgbIcfFKyb
wlvLqbTxnehzZd2wK/WSNT2MM0pxHg9Yi5nQa1Krl5taIK3Jl/UCsCQPRT0I50hQ
LM6nwsDqrp58YTbMienc5+6PRb3f1KcFhh8sBsklo1sx3+kpfPCCbhI10v02Iiha
FC+UmeyjU801F0ri5JSlTpFFoaDaYGxM4MQsnabKsayYrSq9VBxhAz7ZeKACUss4
YjTArYtuDu9NjSO9LU4H5XFC5UCpn3Q4UIVQfwBFyuBU5hr9wilrQDMTNuwbl5jF
uS6AZaSwxG1SuSI7dm+XO6NRR4clwtmfT2iDDw7ahwh47SGRvxj7oAmLc7fN75Sa
EbCU5o7BF/zigu+MJALdZoYH+qnon1pGsgq4IJZHKG9QGnxgriTPbbv8FlvyRegD
p1HwAvbhiJkYQNK0BeDsdBsvDHRNpqcZtk9GM+nI+R3gYqjimG+3GJk+k5YueUoy
1ea5ZF14KM4JBlKdWwNh
=L+bd
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

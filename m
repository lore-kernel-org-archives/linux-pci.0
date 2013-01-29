Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3A2OV0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 09:21:26 -0500
Date: Tue, 29 Jan 2013 15:20:15 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Andrew Murray <andrew.murray@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com>
 <20130129144522.44ed7373@skate>
 <20130129140522.GA24310@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <20130129140522.GA24310@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 02:05:22PM +0000, Andrew Murray wrote:
> On Tue, Jan 29, 2013 at 01:45:22PM +0000, Thomas Petazzoni wrote:
> > Dear Andrew Murray,
> >=20
> > On Tue, 29 Jan 2013 13:22:04 +0000, Andrew Murray wrote:
> >=20
> > > > +static int __init mvebu_pcie_map_irq(const struct pci_dev *dev, u8=
 slot, u8 pin)
> > > > +{
> > >=20
> > > [snip]
> > >=20
> > > > +
> > > > +       /*
> > > > +        * Build an laddr array that describes the PCI device in a =
DT
> > > > +        * way
> > > > +        */
> > > > +       laddr[0] =3D cpu_to_be32(port->devfn << 8);
> > > > +       laddr[1] =3D laddr[2] =3D 0;
> > > > +       intspec =3D cpu_to_be32(pin);
> > > > +
> > > > +       ret =3D of_irq_map_raw(port->dn, &intspec, 1, laddr, &oirq);
> > > > +       if (ret) {
> > > > +               dev_err(&pcie->pdev->dev,
> > > > +                       "%s: of_irq_map_raw() failed, %d\n",
> > > > +                       __func__, ret);
> > > > +               return ret;
> > > > +       }
> > >=20
> > > Are you able to replace the above code with a call to of_irq_map_pci?=
 I'm not
> > > sure which approach is better. The of_irq_map_pci function doesn't re=
quire the
> > > pin argument and instead uses the DT and/or performs its own pin swiz=
zling. I
> > > guess this means that if there are PCIe devices in the DT tree that d=
oes any
> > > thing strange with pins then it would be reflected in the IRQ you get=
=2E I've
> > > found that you will also need to provide an implementation of
> > > pcibios_get_phb_of_node for this to work correctly (see my RFC bios32=
 patch).
> >=20
> > I did try using the of_irq_map_pci() function, but unfortunately, it
> > didn't work. IIRC, it didn't work because none of the pci_dev in my PCI
> > tree had any 'struct device_node' associated to them, or at least not
> > the one that had the right pdev->bus->number and pdev->devfn.
> >=20
> > But, I guess that your patch that implements pcibios_get_phb_of_node()
> > should fix this problem. I'll try this. Thanks!
>=20
> My bios32 patch departs slightly from your v2 04/27 patch in that it upda=
tes
> hw_pci to contain a device node rather than opaque private data and my
> pcibios_get_phb_of_node implementation relies on this. If you wanted to s=
tick
> with the implementation you and Thierry share then you'd have to find ano=
ther
> way to get to the device node from the void **private_data.

If at all possible I think the right thing to do is reuse the generic
pcibios_get_phb_of_node() implementation. On Tegra this turned out to
require a minimal change to the DT bindings of the root port nodes to
make sure they provide the correct address in the reg property.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRB9qfAAoJEN0jrNd/PrOhO74QAIkX/wukzWYPcNoiMJfbhlhW
14+Mf/suwJMw+96GyW+RBAYlUSyr+blHWuAd8jVcw8OzBmdDvDIOjvpSUFP/wtTu
NJnwTB55y0EBAVYMrkG1KCDg36tyl+K5bEBoKjVWlrAfikd7og/1rEHr3j/aJkO8
75+NoFe5ZXZLGaQBL5c8tAhF/1wRXSP45yn9mlRqqZsmMFUt6iixzhb/XVAt4mAg
4/QDLCY3wUt/LLWVNBpX+r+6XeLQ8nkmMNhUrDvdtJyIK8vEZ/KZIqfB0G4APNy0
o+IM4jrBgebAqDDDfDjLf2YkmMyyQYf5fSuNRZwCreitqsMNLJ6JO1UTf9+XbNj3
eHmAbNSjnOp3kWcBg8bBj0Cf4TeKf1+O7PxN8QElMhBp5bK6xMR6+W5EKmPK/VQc
Km/kGY2f/GN0a8SRZqaf+Fal9pA++5CWGiFuwl69zOmNW/wsRzqy2MGK1WcFYNo0
DVgVqHqRy/s3l8KqIK+FG0K/ItBgrVUcxey8MLr2PCujEDkWOQ4chf/O5H+iXgWj
CrYf3vocOTjH9Egi5ELbJP1O+IbEyD8PKuET+PvvJOyDk8EsUyfvtEJVOsjK2O5P
TjMbd7Xj3D2wNEyyPdyV0ziv4bjkkwy+LwtbzKPOsLqa3D5RkWiKev+k8ok6F2K7
pqMkMznY0i96JA1jCFBY
=kfEs
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

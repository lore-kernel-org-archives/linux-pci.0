Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:56265 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3E3MPX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 08:15:23 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so101355bkc.27
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2013 05:15:22 -0700 (PDT)
Date: Thu, 30 May 2013 14:15:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 09/11] pci: mvebu: add MSI support
Message-ID: <20130530121518.GA20267@mithrandir>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo7yC_97Vg-zuype-jyfqiY+77OE97cxYoEO9ZZnXjQ95A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <CAErSpo7yC_97Vg-zuype-jyfqiY+77OE97cxYoEO9ZZnXjQ95A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 04:29:07PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni <thomas.petazzoni@free=
-electrons.com> wrote:
[...]
> > +static int mvebu_pcie_setup_msi_irq(struct msi_chip *chip,
> > +                                   struct pci_dev *pdev,
> > +                                   struct msi_desc *desc)
> > +{
> > +       struct mvebu_pcie_msi *msi =3D to_mvebu_msi(chip);
>=20
> If this took only the pci_dev (not the msi_chip), I think you could do th=
is:
>=20
>   struct mvebu_pcie_msi *msi =3D &pdev->bus->sysdata->msi;

That would mean that the arch_setup_msi_irq() and friends could still be
architecture-agnostic because they only pass around pci_dev, and the
driver specific implementations would know how to lookup sysdata and
=66rom there the MSI chip.

So I was almost convinced that putting the struct msi_chip pointer into
sysdata is a good idea. However that also means that each PCI host
bridge driver becomes architecture-specific. If we ever get a driver
that can be used on multiple architectures (however unlikely), the only
way to make it work would be to #ifdef those parts. We could make that
easier to deal with by providing an accessor (pci_sysdata_set_msi_chip()
or similar), though.

But maybe it's something we don't need to be concerned about because no
PCI host bridge driver will ever support two different architecture?

One related point is compile coverage. If the drivers are completely
architecture-agnostic it makes it a lot easier to compile-test all
drivers, which might come in useful when doing core changes and such.

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRp0LWAAoJEN0jrNd/PrOhZpkP/ii59Y2qEZJQiPHMb0kNVjZk
en5yU4Z+H47YgwtaUHhlfvkDuP/rQvR3dT/DWQv3so/1ft9nPBUhVn16+cZjzGrC
BnJ9P6Mg5rqHNBzsklnQPivRkcQDXHaYfuGz4stHUGPaOcGR+upvPQQymeAL8FB9
YbMzfX3wt8Aup1fJWViP6fBR2VijCpcfkuVW7TstdtQvAmcpUn2itShdL89c/UPi
llobYQM/nGPvA44g6r9YHYfCSSCXV7czPF8zlLnxhteF82/eD25E7vvXziZIihDc
lsslh8FjForTt2tZQcUFpt1bA6SNpFdem/FYa06es/X+shSsDXy/nRTh+yNopS/D
BjHNWAzmd3nMnBplxwmRtreVtedudGz7uXqoPv5wySIbC4L5GhE1CIIRUYmV0DTE
OmhoYRi93fFv7NuCeW4FsS2gs/kNqTH+WzFyz29nobRjgSDMSAc+ELwzuUfkWn0L
WOKqtZQmo4iD1ulDdjN7nomEtp6rna6eaXBUa14BygBgBAkxFU+aPc5DsVQEP8Cv
AeabJw+DwaD/gREfT1qOtE19kU3N8A6f9EaaVbabz96S2lEGd9rGm26meqawnxjr
sDksusEYjnCRFPOtnLl0tAO1/sYuJhA1Ei9ol8RjAT6hO8GaTo+N82876p80CrSS
vCNkYUbS6OilKxm/H7ax
=kQQb
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

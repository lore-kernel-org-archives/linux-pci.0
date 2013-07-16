Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:36127 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284Ab3GPVFT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 17:05:19 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so624548eek.15
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2013 14:05:18 -0700 (PDT)
Date: Tue, 16 Jul 2013 14:05:10 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130716210509.GA29318@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
 <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
 <20130716103351.15b0fb50@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <20130716103351.15b0fb50@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 10:33:51AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Mon, 15 Jul 2013 09:27:10 -0700, Thierry Reding wrote:
>=20
> > We need at least patches 2, 4 and 8 for Tegra.
>=20
> Are you sure you don't want patch 1 ? It allows to replace the
> allocation of MSI interrupt numbers for the MSI driver by a generic
> facility based on irq domains.

Yes, I could use it to replace some of the functionality. I was just
saying that we don't absolutely need it. If it makes things easier for
the merge, it would be trivial to convert the Tegra driver to using the
new generic facility in a follow-up patch.

> > There's still the option
> > of working around patch 8 by using the custom root bus scan function
> > that we have to use anyway, so I guess we could even trim the
> > requirement down to patches 2 and 4 if we really need.
>=20
> Bjorn said he didn't like having the msi chip assignment in the middle
> of the root bus scan function, because he was hoping someday to
> refactor this function. Quoting Bjorn:
>=20
> """
> > +	bus->msi =3D pcie->msi; =20
>=20
> Ideally, arches could use pci_scan_root_bus(), which does the
> pci_scan_child_bus() itself, so I never like to add arch-specific code
> between pci_create_root_bus() and pci_scan_child_bus().
>=20
> But you should be able to accomplish this by setting bus->msi in a
> pcibios_add_bus() hook.  There is a corresponding pcibios_remove_bus()
> hook that might be useful for deallocating the msi_chip.  I'm not too
> clear on how you manage the msi_chip lifetime -- I see the alloc in
> armada_370_xp_msi_init(), but I'm not sure whether you ever deallocate
> it or how you know when it would be safe to do so.
> """
>=20
> This is from:
>=20
> Subject: Re: [PATCH v2 6/8] pci: mvebu: add support for MSI
> Date: Tue, 18 Jun 2013 16:57:11 -0600

Yes, I'm aware of that discussion. However we currently need to have the
custom root bus scan implementation anyway because pci_scan_root_bus()
just doesn't work on ARM. So again, since we'll have to rework the
driver anyway in order to use pci_scan_root_bus() once the issues have
been resolved, it wouldn't hurt to postpone the transition to the new
ARM pcibios_add_bus() support until that point.

All I was trying to do was reduce the list of common dependencies in an
attempt to make merging it easier.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR5bWFAAoJEN0jrNd/PrOhRCwP/3Dui1G8Fiwtt1xOWfndk1wT
0eOG6jtNqn2mQO04c87Bb8WuxyQwU43n8mMdDlP+KDzGD18Uy02/ppxDWSxtbckm
8KxZSAzmBLRVsVHFLawmOTDlUL+xVuPXzuuDtA3bc2ahQeUQat+Bi3om/RQGWLn+
bKAO6kHmdaBu7fjg9CKCWa9g8cYJSGsOdYfax+Fq54dZlvMi0thnKnnIDd174aeG
iXMcfoDl8EGE4BdJhq7eICJ34Iah/nH41Hu73rxuG/1Q4PxzFHdwOFVOug7A48GF
txPIFKb8ZGeJyV/f1DmCmE7/cAts1tE6BXFtfw8gEo1lvsgfAM7Ub3zUKqZte0cn
SQQl+dAmWV50JxyIY4xFDRc44NhHlfAtx2/A/bNFDv5dYQP0ZAT50enw/4vTo8v2
ZJAu9vOS6Vw4yNjYO4Ty4eMOcJteZtfwF2ScFR5Ul5aRSYwkqxvmFHQGirU2mf2E
QpuaLxGY2sQxA/XsCWl+OQvByNwbgj7iEKpepb3xRxa4Ot8pwsflfSjxmA/z8f86
xNQsrBXCbA/ampXzaz9TvW2a1pAVhBbqxh13Ktw3HvZ08/DAgJEftwQ+eWN/7ZDP
u+T7t0wjo2gdguPkyu8s/Wlrii1lFTOXI/Af4l9DurYG7dUP3l1x8R+0ivrbOFYj
WlyiU4mKPg7vO+h6nNku
=RVJx
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53399 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3BGH2f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 02:28:35 -0500
Date: Thu, 7 Feb 2013 08:28:24 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
Message-ID: <20130207072824.GA24827@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de>
 <20130207010502.GA7435@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <20130207010502.GA7435@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2013 at 06:05:02PM -0700, Jason Gunthorpe wrote:
[...]
> Also, what should 'reg' be so that the PCI core binds the OF nodes
> properly?  The standard says reg should have the configuration space
> address of the bridge, and I noticed Thierry was using something that
> almost looked like a config space address in his driver..
>=20
> But that seems overly tricky.. When using the link stanzas, shouldn't
> this scheme be more like this:
>=20
> // The PCI-E host bridge
> pex@0 {
>    device_type =3D "pciex"; // <<-- Important!!

That might actually work but is somewhat dangerous. I originally tried
to trick the OF code into parsing the ranges properly by setting this to
"pci". However that breaks horribly because of_bus_pci_match() in
drivers/of/address.c will cause the parent bus of the pex@0 controller
to be PCI, which will cause #address-cells =3D=3D 3 and #size-cells =3D=3D =
2,
and thus messing up the address translation because you actually have
#address-cells =3D=3D 1 and #size-cells =3D=3D 1.

The code doesn't seem to match on "pciex", so you might get away with
it, but I don't see why exactly it would be necessary. For one it is
actually wrong as the device isn't a PCI device but a platform device.
What I did to solve the ranges parsing problem is to use of_find_bus()
instead of of_match_bus() in of_pci_process_ranges(), so that the cell
count is correct.

>    ranges =3D <
>       // Driver internal control registers in MMIO space
>       0x82000000 0x10000000 0xd0040000  0xd0040000  0x0 0x8000000

I'm not sure I understand what you're doing here. Where does the
0x10000000 in cell 2 come from?

I also just noticed that I used 0x00000800 in the first cell, maybe that
should be 0x02000800, though I think that didn't quite work for some
reason. I'll need to check that. The odd part about this is that the
address is in fact not within PCI MMIO space at all, so I'm not sure
this is even a correct way to represent it. However I find it quite
intuitive to do so and it is really the only way to make the translation
=66rom the PCI-PCI bridge's reg property work while at the same time
having a proper PCI address for the port.

Note that 0x82000800 would probably not be correct as it'd indicate that
the address is relocatable, which it really isn't.

>       // CPU 0xe0000000 -> e8000000 bridged to PCI MMIO
>       0x82000000 0x00000000 0xe0000000  0xe0000000  0x0 0x8000000
>       // CPU IO bus 0x0000000 -> 0xa0000 bridged to PCI IO
>       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
>       // CPU 0xe8000000 -> f0000000 bridged to PCI MMIO, prefetchable
>       0xC2000000 0x00000000 0xe8000000  0xe8000000  0x0 0x8000000
>       >;

These look good.

>    // PCI-PCI bridge to Physical link 0
>    pcie@0,0 {
>      device_type =3D "pciex";
>      // The configuration space address of the PCI-PCI bridge required by=
 OF
>      reg =3D <0x80 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0

I think the first cell should be 0x800.

>=20
>      /* The 'bar' on the PCI-PCI bridge, maps to internal control
>         registers, required by the driver. */
>      assigned-addresses =3D <0x82000000 0x10000000 0xd0040000  0 0x2000>;
>      // ..
>   }

The PCI DT binding says that each entry in the assigned-addresses
property is to correspond to one of the PCI device's base address
registers. So unless this is actually the value that ends up being
written to one of the BARs I don't think this is correct.

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRE1eYAAoJEN0jrNd/PrOhvLYQAJCXCoLhxYJMxxHZ95yb2k+X
HiQ1v5JT4ATPKO01+O2UjH2kl+PZGOqTf+CbslrpLsl+vMVWFNSyfrQgRGbd/Y01
ivglUXGwX2YFiefEaXcQb3FxlDVuEfm/ZAJK7Sx2ZbV2bwkh/JKQULsYK4GBU9nu
H6klxyB84ROOSrG0zp7ZX3LM8cQZxqZj04pQUSNISipgWf8bkr93VfgnwH0dmEpr
Cdhs27VllZU7sMT8JByOlVqbceaNYkfmUfxD0sfsognKvzb652QgboagX2MqJoD/
iLWYxAQfRXpJzVyVPRAE3Sn7QtOskEV9PBLqdK88IpE7s0iEyWcDnkzvGzQtxvs7
acnN8FbYKGDvAqJeTQgzVwh0LU1HMG2TaRII7JbI8bZ36U0zBxSpcIINriis4BEC
SGWp8kZ4gk9oZGmabV6FBlWo3mNqCt/79+HLYVUUXqYtPtjGm24v1VWQRongsenr
mjC/qN1r8J95LJoTiFIc6hwqwPzzHx1CwTscV4pmZDz4w24Igle4MOND30Uaavx8
x4jurHfwwteJiJFK85ivlHf840lH4MFXU0oVYCJReZsSRbaPedE2m4R3Krko4jXM
Go3unrwjniACWHWx8ughT1IHqJqt5+qwA2c9vcpcLISAC8bmAEcWEmP0tvHv7Vk2
NtH8eSp3Ooud2ieocbeJ
=+3Bq
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

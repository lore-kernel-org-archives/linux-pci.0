Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51063 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab3CILK1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Mar 2013 06:10:27 -0500
Date: Sat, 9 Mar 2013 12:10:03 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Rob Herring <robherring2@gmail.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130309111003.GA495@avionic-0098.mockup.avionic-design.de>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <513A7044.1020700@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <513A7044.1020700@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 05:12:04PM -0600, Rob Herring wrote:
> On 03/08/2013 01:14 AM, Thierry Reding wrote:
> > On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
> >> On 03/07/2013 02:47 PM, Thierry Reding wrote:
> > [...]
> >>> In a nutshell (since some of the context isn't quoted anymore) the
> >>> problem that we're trying to solve is that some of the embedded SoCs
> >>> require per-root-port registers for configuration. The PCI DT
> >>> specification doesn't make any provisions for this. A few alternatives
> >>> have been discussed so far:
> >>
> >> I'm not sure I follow. This is different than the host controller
> >> registers? Why would this not just be multiple entries in the reg prop=
erty?
> >=20
> > Well the register regions are per root-port. On Tegra20 there's 2 of
> > them, Tegra30 has 3 and if I understand correctly Marvell can have up to
> > 10 (!). Adding all of them to the reg property of the host controller
> > could work but it needs some way to match the reg entry to the root port
> > similar to option 1 below.
>=20
> The compatible property of the PCI host controller can imply what each
> index of the reg property entries is for.
>=20
> >=20
> > Adding a property in the root port nodes seems like a cleaner and more
> > accurate representation of the hardware to me, but if that's not
> > acceptable perhaps we need to bite the bullet and add the code to look
> > the registers up from the parent's reg property.
>=20
> What I don't like is a new property defined to describe mmio addresses.
> We already have a property for that and it is "reg".

Okay, understood.

> But I think I'm still missing something:
>=20
> >>> 			pci@0,1 {
> >>> 				...
> >>> 				reg =3D <0x00000800 0 0 0 0>;
>=20
> Is this a PCI bus address?

Yes. The example is slightly wrong. pci@0,1 should actually be pci@1,0.
That means it is device 1, function 0 on the bus (implicitly 0 in this
case). That matches the values in the reg property, whose first cell is
defined as follows, quoting the PCI OF specification:

	npt000ss bbbbbbbb dddddfff rrrrrrrr

Where:

	n         is 0 if the address is relocatable, 1 otherwise
	p         is 1 if the addressable region is "prefetchable", 0
	          otherwise
	t         is 1 if the address is aliased (for non-relocatable
	          I/O), below 1 MB (for Memory), or below 64 KB (for
	          relocatable I/O).
	ss        is the space code, denoting the address space
	bbbbbbbb  is the 8-bit Bus Number
	ddddd     is the 5-bit Device Number
	fff       is the 3-bit Function Number
	rrrrrrrr  is the 8-bit Register Number

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROxiLAAoJEN0jrNd/PrOh4uIP/ipDWHGJoD2n7pg3eYFHm2IT
pC5gYZi8U7SfknvrfKjmhOEFnAzQ/bvjDHoTrtBNk4sTYzSe45jK/mIzKBfQDvJI
IqhJooTgjjPrZtsj/Zc4Z6qJDhrqHAnLngb2eYg0yhAO7VVOv1BY4GFdgy5sbcTS
c7imWu45oPssWH7CBkJU7O++e5GP269PhVOZtHZpItmFYbUbCDrkB7Gw7h0/sGrg
7KbWzLzSRZuMLOPW3DEel+eHkpCdqywsidzdTwWuerSoTr1xvSW+MnFI9vLkUev5
fyZ439wQ8P4DF6E85a0ZGYTYQXvb9Pk1n1Eg4ZfZ2VAi5VYbRAzeBl7P6K0uE3uJ
mr45//pIiHG5zY3ragEAgq9kBKP7DTpKMFytyN6fPK8qb4CGb1ezKvgyITtjnkzZ
Eo2l4K90rTvLZJ1CMNDqMI+HAzxBv1S5zAfhgvVvlNi1pwQQ+fY5Y7H0Bar2s2sh
t5omgF0jOBSUIGjnx8uI/0Gnkdo0py4uBB9qZyiqc8V/KVL089PtiTAT/iPk95Q9
lmjPRcOeEO4wvV4lvSin+ZCMVbAIzJ5ijhLVldTEyL0slBeL9oEHdtTqVSjUGoeW
Wh26pL6SgyLGU3w5KKXhXKqQxkmlsvuEsRIoLC/Rx2QUFEaiZgbe9KmA9Ug+HNZa
yfIwRBOgnhySyBrMeUnf
=qHGK
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

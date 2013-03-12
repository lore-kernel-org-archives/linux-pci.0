Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62603 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3CLHKC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 03:10:02 -0400
Date: Tue, 12 Mar 2013 08:08:52 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
References: <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <513E6AFE.3090304@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 01:38:38PM -1000, Mitch Bradley wrote:
> On 3/11/2013 1:25 PM, Jason Gunthorpe wrote:
> > On Mon, Mar 11, 2013 at 11:50:19AM -1000, Mitch Bradley wrote:
> >=20
> >>> However - the driver runs the core in a 'root port bridge mode' where
> >>> the config header register block you are looking at is inhibited. The
> >>> Marvell IP block requires software support to run in bridge mode. So
> >>> Marvell really has only (2), while Tegra has only (1).
> >>
> >> Interesting.
> >>
> >> For Marvell, if Marvell has only (2), does that imply that standard PCI
> >> discovery and enumeration code cannot find the root port bridges, and
> >> also there is no way to auto-configure the bridges with common pci-pci
> >> bridge code?
> >=20
> > The driver is required to take care of all of this. From the common
> > code's perspective there is a bridge config header, and writing to it
> > controls the device, as the PCI spec intends. But the driver doesn't
> > copy those read/writes 1:1 to any HW register block, it distributes
> > them around the device's register space as necessary to create the
> > PCI bridge config header.
> >=20
> > The DT is still modeling the HW, there really are root port bridge(s),
> > that are completely conformant at the TLP level, but the IP designers
> > choose to leave the detail of the bridge config space up to a SW
> > implementation.
>=20
> Oh, ouch, deep spoofing.  I had to do that in system management mode
> firmware for a Geode chip.  What a pain that was.
>=20
> >=20
> >> At this point I am confused again.  There was talk of the need to
> >> use standard PCI enumeration code to deal with the bridges, thus the
> >> need for 3/2 to describe the interface between root-complex and the
> >> child root-port nodes.
> >=20
> > I think your confusion is coming from your expectation that the PCI-E
> > IP block would be an entirely self contained root port, rather than
> > 'tools to build a root port, with the right driver SW'.
> >=20
> >>> Further, review section 12 about how ranges should be treated - it
> >>> specifically says that the b,d,f bits in ranges should be 0, and the
> >>> child address should have those bits masked prior to searching the
> >>> ranges.
> >>>
> >>> Section 12 would seem to forbid this:
> >>>
> >>>       ranges =3D <0x00000800 0 0          0xd4004000 0 0x00000800   /=
* Root port config header */
> >>>                 0x00001000 0 0          0xd4008000 0 0x00000800   /* =
Root port config header */
> >>>
> >>> Are you reading that differently?
> >>
> >> I wasn't reading it at all, until you pointed it out to me :-)  I was
> >> just reasoning based on my mental model.
> >>
> >> Again, I agree with your reading of the spec, but I can't think of any
> >> reason why relaxing that restriction to permit config space mappings
> >> would be a problem.
> >=20
> > Okay, just wanted to confirm that, I think I follow you now. :)
> >=20
> > So you are basically proposing a small update to Section 12 that would
> > read something like:
> >=20
> > 'When matching a config space address, the b,d,f bits are valid in the
> >  ranges and left unmasked in the child. The r bits in the ranges
> >  should be 0, and the r bits from the child are copied in the last DW
> >  and masked off in the first DW.'
> >=20
> > Which, as you note, would not conflict with any existing usage..
> >=20
> > Though, I can already see that the above language is not good enough,
> > it doesn't elegantly represent standard ECAM, for instance.. How would
> > you even represent ECAM with ranges??
> >=20
> > Another wrinkle is that tegra not only has the per-bridge memory
> > mapped config space, bit it also has 4 'all port' ECAM-like memory
> > mapped config spaces. The rules around them are sufficiently
> > specialized that I'm not sure a ranges mapping would ever be
> > practical.. So right out of the gate we'd fail to capture memory
> > mapped config access via ranges on at least one SOC.
> >=20
> > So, to me, this seems like overkill. Only ECAM has a hope of having a
> > common implementation, everything else will be host driver specific,
> > so why go to the trouble to revise the OF PCI specification for config
> > space?
> >=20
> > Particularly since there are patches waiting on this question being
> > resolved :)
>=20
> Okay, so I'll just bow out.  Do what you have to do.

So to recapitulate, we agree that configuration space can be translated
through the "ranges" property. That means the only missing link is a new
function to translate not only "assigned-addresses" but also the "reg"
property for PCI devices. Is that it?

And for Marvell the non-configuration-space per-root-port registers need
to be mapped separately from the configuration space windows?

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRPtSDAAoJEN0jrNd/PrOhP94P/ihQJs4LBLFz+otRAT/7ge+j
7KQCUxfQSEZ9ZrC9vuhecFzU4fyxvELAc5XrY50Mk6PahhnlGFX6kli4gmRxqSQb
NFLpkTWDmnDv3TwrXbLqboqBR+ONTg2lTNXrKweY2/Y/w4Momsr77ovRmIAy6eHi
JXXA1JNFip5zw7dl7HCX6zkwbCGQGOL98F3gb4IZhs0lmBfIlQe1sMC8HHWvxOJO
hVdRwYBeS2uAhSVp4NyTYwbF/W7NnAgOwMWcwudjFm15tcyk4HM/eE+olOYZY4Yh
WWkaMMbtD1NRbeW4XdqMoO9GOUCfuYfL7fq5qRhwFyl7wh0SeHsiYGUov4lfx38F
N5aYHVABykEZ6/8fpEoLi1Y/9AWQCJ55U+0GuvWcDCYXuRm8gO4HXOJrkAKHA7wS
5Epxjaael+ohvE7axSlboMY16JTUks2NzaSDqf85h+E16W7ZnXbt05KN+QG4g4of
8Q9lDN4cP983YJFy+xFDZZKwThZVyM4khFobdxyfOXadwa9Tze/1EAMUNK93/O6z
+1VHGFbxhwHSYxaUVmLvAckzt6Y6DHjgW1MJRIPP8j4gXqZ1jlmLx1qHU1aY7qF0
LtpmjX9aVVVZEa5qOwHDD96BTyhx3Vdr7D3/wG7G4AMozr0cKS5hMdv/PrZUfBda
G0CaiPYIe6XhYR+mikob
=+paI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

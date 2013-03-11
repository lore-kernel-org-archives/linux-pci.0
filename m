Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64617 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab3CKIJT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 04:09:19 -0400
Date: Mon, 11 Mar 2013 09:08:26 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130311080826.GB6365@avionic-0098.mockup.avionic-design.de>
References: <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <20130308201339.GA26322@avionic-0098.mockup.avionic-design.de>
 <20130310160937.37df66b2@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <20130310160937.37df66b2@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 04:09:37PM +0100, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Fri, 8 Mar 2013 21:13:40 +0100, Thierry Reding wrote:
> > On Fri, Mar 08, 2013 at 01:02:46PM -0700, Jason Gunthorpe wrote:
> > > On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
> > [...]
> > > > 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg valu=
es
> > > > <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.
> > >=20
> > > @0,1,0 (bus,device,fn) could be more appropriate, but that is
> > > cosmetic?
> >=20
> > The OF PCI specification is pretty strict about this as well. It says in
> > section 2.2.1.3. that only the DD and DD,FF forms can appear in a device
> > path.
>=20
> Note that in the case of my driver, the @X,Y represent the port and
> lane of the PCIe interface. Not sure if it is correct, I can change the
> names to whatever is appropriate, those names aren't used anywhere in
> the driver.

I think they need to be changed to be @dev,fn in order to conform to the
OF PCI binding.

Thierry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRPZD6AAoJEN0jrNd/PrOhbQMP/jdWyr3snjR32LTBH69/ga2x
UneJvn8m024zP2rlMTCiTfGwVIp6MIm4VZrUjQcJC0oXWRlZaMMwToUhdPvkdMjV
Hs1bSLrc0epx5wuDYJM/IgK/tPUe27+l9y2cuVYNzBNAQdIZY+apFD+hsO81N3tG
QsPNa1Q9NFEwRUUVO+PPdGIH1+U+1mewKLGw7BUrBwguBgXcJzm+Yokm/GftFAMP
6yZhRRXSdptePipoQgacZY7xjm0JpzHt71QRSCDD23i49nQiE92hdkGcwWfxFXqe
jSlQd15L8levse6eTzGzKY1cI5oJ7DO5og/1GQ8ab0kaE5vwFWqpxYfu4FPymgAb
AXvGgSUvNGEdfQD/V5Mn36RChXmMMQaZHzC9TnvJtkA6Xnee2DYA36rBIG58Hwua
G+z9uY8O4k3ph5ECwZD0uD2IPfANEkN2lxWFhV+OIOakz+KbUkA3/e3DF0/6MW9U
7sB5OyoV871BbVFpRBQ/zCdlx5DbBVl1rXyXFBKMUK3XCRFcHCjtsH35pAtcHsAJ
xQkBWMU3mfSA41g0javit1InJqYRp/EFpvOA07bcByugtoCBs6vmAPRipPy1ZPKg
2jS49qlbbZWaXVP5pZ0mQj39QvLV0+20S41zefrNu1J9jjz4yYV5pWNicRlao4hh
Cij8KaiEzEys1Q5aUuNw
=oxkN
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

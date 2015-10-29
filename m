Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52245 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ2SsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 14:48:09 -0400
Date: Thu, 29 Oct 2015 19:48:00 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151029184800.GB8992@katana>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
 <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
In-Reply-To: <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 04:44:06PM +0000, Phil Edworthy wrote:
> Hi Wolfram,
>=20
> On 29 October 2015 16:40, Wolfram wrote:
> > > Ouch, my bad. I have been working with our out-of-tree BSP for the Sa=
lvator-X
> > board on
> > > http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  r=
car-3.0.2
> > tag along
> > > with some patches from colleagues. I hadn't noticed this patch:
> >=20
> > Thanks! Any plans for pushing this upstream? We will have the build err=
or
> > otherwise...
> After some digging, that patch won't be accepted upstream. I'm looking in=
to how the
> driver can be modified so it doesn't need to call this, but I don't expec=
t a small or
> imminent fix.

Yes, I'd think so, too. However, a fix for 4.4 would be needed to
prevent having a final release with a build error.

> > > > Any news if this is really HW related?
> > > I found out that the PCIe controller HW only supports 32-bit AXI bus =
addresses,
> > so it
> > > works fine if you limit the available memory. The driver will need so=
me work to
> > use
> > > the IPMMU at some point.
> >=20
> > Ah, okay.
> >=20
> > Can you send the dts patches, too? I checked the BSP this time, but to
> > no avail...
> I will once I sort out the arm64 IO resources problem and the MSI problem.

What MSI problem?

And can't you send the DTS patches as RFC so I can add some testing?


--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMmngAAoJEBQN5MwUoCm2fnwP/j7onLCHJbBstWgrvpnBZWLy
7ZLMcHPXQHMTW7/htkEF83jJJnlEKVdodIAQUR7PL+EA3zpSEK+VpvA/8nPZdYII
V/IwcY2uLxK2I/tm3mXyfFK2ONWhpjCAp/vRnz3lf4MJPB2z24P8eXu1Oogbrr7I
P7NkrzwJs8Hoj/5AX77JGgQw83kh3kLiEHEnFnlkc21Yn7bJ1shnvxS8t2XgExUT
8hP5w8hxZbtKxxN3sV5MJRAOmBP/ZfMkta7t/zUpIzL9OZUatzgEvXQyPR0LD4MQ
AaTtKF8F0kjnQPRiUe1Zhw4Q3CTfc3euDuggq79q2Xpw9ZQsAxZa/ojzI+0Lz47C
2iRACRlDoz2qdCaOb80uq6paIkvz7+xyGY+xx3GCIfaRAbkrQbt6z75l8r/4osMM
Cv4CNROAWGDIlqTKdXcNvqVkoSaTvYW7nH4LdtxA57hNV2w6Atdt+NigUEc6ZPO0
CFKsiy1r9i3TCBVZbHyfIyEK10fZM9jBieV40fwosdKmEElIKOHstHoGoLIYK4zA
rLIJc31zWT8VOa6gAaIJQIC4pOTbL4LULoqTwo+UKWOmCDRzLRswpKR0D3YmeNa4
9VKKpO7mrJeP1I585yTET4D4rgJMVIs+rc49f+JEWs4L64fSBc/3nAHnpQGoFlQA
38o/1MxxJtJU6Z9FESVV
=zLs4
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

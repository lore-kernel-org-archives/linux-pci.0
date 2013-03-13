Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3CMITO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 04:19:14 -0400
Date: Wed, 13 Mar 2013 09:18:15 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
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
Message-ID: <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
References: <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
In-Reply-To: <20130312220854.GA23112@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 04:08:54PM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 10:30:06PM +0100, Thierry Reding wrote:
>=20
> > > Not going down the of_pci_* code paths for address translation at the
> > > root port bridge nodes is certainly not right.
> >=20
> > I'm not so sure. Why should the pcie-controller be a PCI device?
>=20
> The spec is clear on that point as well:
>=20
>  device_type
>   A Standard Package conforming to this specification and corresponding
>   to a device that implements a PCI bus shall implement this property
>   with the string value "pci"
>=20
> The children of a pcie-controller node are PCI devices, thus the
> pcie-controller node 'implements a PCI bus'. Or, as you say 'device on
> the processor/SoC/platform bus that bridges to the PCI bus'
>=20
> Think of device_type as also meaning bus_type and it makes more
> logical sense, the name is terrible, but its usage is governed by the
> OF docs..
>=20
> > The other alternative would be to amend the specification. Besides the
> > fact that the specification says so I don't see any reason why this
> > shouldn't be allowed.
>=20
> 'the specification says so' *IS* the reason. DT isn't a free for all
> where you get to do whatever you want, or whatever 'feels' right. It
> is supposed to be a stable, OS agnostic ABI. That means bindings have
> to follow the specs (when available).
>=20
> Maybe a future revision will support PCI-E ECAM, but we don't know
> what that will look like, and I'm pretty sure you don't want to hold
> up your patches until an IEEE committee gets around to deciding
> something ;)

Mitch already answered this. The specification is now almost 15 years
old and it couldn't possibly have foreseen all of the future use-cases.
If the specification is too restrictive and Mitch gives his blessing to
remove some of the restrictions, I don't see any reason why we shouldn't
do so if it lets us represent the reality of hardware more accurately in
DT.

Furthermore we're not discussing radical changes. None of the changes
will be backwards-incompatible, but they will allow recent hardware to
be represented more correctly or conveniently.

Thierry

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQDZHAAoJEN0jrNd/PrOh9yIP/jIZgFbYAwdX9cNL/2KdfO+7
PUFNnsBeThW4p/wq6EGfjJos9h1+35FEg8x1x/6xSCpASpaI36CpxwQ6k2ryCTm0
+AeN+d9ItAa9sAFpymSRL8YLsomUKAac+B8VZMJlIg8MWaZDQeGMi/+vDRKT5MST
WGU2JqTX0gGcWZoSyQl4K1s79nJFUHrKSyLSV309dAxSjYcTLd2fLcjI8NLgPuTk
4C43glyjFLQn5wTpS8wmsN2sO8XVb10SG7t4Dcrrg78LWKTeAuUz6CRuZjt+ydnl
969b3RU3VeU8SjUNTU3UMMqUCv6aAoZNClYnjPQawJIPftqGrlFsK0v95isVtqwH
1xLmMAqvyc4mdzgBwJKANco05vvDoWplVHX2df1Ad9IvWHYB3zkTbzwSSjKIHtDO
mkX+1Ldiwl0kcZmgslOnjbH8cBWIQHKoEBx4tVfmCsrBnJIwht4CtgtEs0KxBDuM
oFvHYf/mM6mAQ3+FQ0z91jUx4UnEqb+lySbERbEfooCYGzdq4mqQ/EudlBekZlqe
Oq1utlkDgVKu0nfBMI0m9MI4kQrJnQ3MU8cOzikS0Bz7SzXZin5SvHh0UWevsaEF
81Hyuu0B54kb6lqEtX+6XYL3PmYzraljCmgJG/LZWxRWOYEzlJYGaFMs49qa+2rr
nw4iPFk4kL09m+I9lciA
=gXC7
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--

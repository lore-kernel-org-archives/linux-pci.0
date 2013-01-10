Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64974 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab3AJUU3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2013 15:20:29 -0500
Date: Thu, 10 Jan 2013 21:20:07 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 05/14] lib: Add I/O map cache implementation
Message-ID: <20130110202007.GA26139@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
 <20130110192417.GA18478@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <20130110192417.GA18478@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 12:24:17PM -0700, Jason Gunthorpe wrote:
> On Thu, Jan 10, 2013 at 08:03:27PM +0100, Thierry Reding wrote:
>=20
> > > > You'd piece a mapping together, each bus requires 16 64k mappings, a
> > > > simple 2d array of busnr*16 of pointers would do the trick. A more
> > > > clever solution would be to allocate contiguous virtual memory and
> > > > split that up..
> =20
> > > Oh, I see. I'm not very familiar with the internals of remapping, so
> > > I'll need to do some more reading. Thanks for the hints.
> >=20
> > I forgot to ask. What's the advantage of having a contiguous virtual
> > memory area and splitting it up versus remapping each chunk separately?
>=20
> Not alot, really, but it saves you from the pointer array and
> associated overhead. IIRC it is fairly easy to do in the kernel.

I've been investigating this a bit, and one problem is that it will
prevent the driver from ever building as a module because the necessary
functions aren't exported and I'm not sure exporting them would be
acceptable. Currently PCI host controller drivers with MSI support can't
be built as modules because the MSI infrastructure requires it, but I
briefly discussed this with Bjorn at some point and it should be easy to
remove that requirement.

> Arnd's version is good too, but you would be restricted to aligned
> powers of two for the bus number range in the DT, which is probably
> not that big a deal either?

Stephen suggested on IRC that we could try to keep a bit of dynamicity
in the allocation scheme if we create the bus mapping when the first
device on the bus is probed and discard the mapping if no devices are
found.

Sounds like a good plan to me. Does anybody see any potential pitfalls?

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7yJ3AAoJEN0jrNd/PrOhEg0QAJPCMtXWjZXnTSmq19nw7FHc
BsHrbTN/Sp1W0Qp2qcLSP5fz6P4YmoTOsBQkzNOsrTgaXKt1CLid50/yMTcx7Gx/
LOEaP1pQEpR/PlD4TB/nbrGGPTesQYZvqkfIec2Cl4S9TfSKB/EabXkPvguYDjf8
8xi2IZMpPpjq52RV2jGeNopoDx1KcGSkSqSugdkO3vHdW3rJktEhGtctlZl3w/ez
y8KevdheBGTeWItLoKK2bfDsFsdsacrlsVI+lfH+9H7s/GpMKeKF3lu0zW9gNn7Y
i9By+Yui6asRjMG7IQtqAHqFsTdgfuxuLzI8C4GS4BdQZfv4GFCfbTrowVkVOhnf
BCDy108ZeKMs+Ji6zgam1RdX9JDnCWmZGhLClNHfZBeHkHY4SPTQrY3Yj+xYmmHZ
FSIYMeEF+aJSlvrSsjNYWGlw20XBZ+fdZ9u0jabVQd8TAfJQImNKeDj4PWqDQgVJ
zViVDkIXR+fz7T8b0KRMmMJFOOeTghyLZiW3oMKrpJ7peSiQ+39TZK+PZXw7nk0v
BUtooEnvOLgCYJ2NGBQH8Kz7X0g3/0T/NwVM8p+S97cnlPYjYKIx6tCJJMfoqThO
qQpucmG+itb3GUqK/JDpevW93iiUyJXbmQ21VsDI2AIMaZebWhFLGI0AS0/w2utv
0/Lj3UwnORhiJ4Yx8Wuj
=iWfk
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

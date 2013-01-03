Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53663 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3ACPLv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 10:11:51 -0500
Date: Thu, 3 Jan 2013 16:11:43 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robherring2@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <20130103151140.GA28625@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4O9jCjLrdky2C-7EarJwBPSTRrhHb7pNsQNWcNNgenEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <CAErSpo4O9jCjLrdky2C-7EarJwBPSTRrhHb7pNsQNWcNNgenEw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2013 at 08:00:58AM -0700, Bjorn Helgaas wrote:
> On Thu, Jan 3, 2013 at 7:39 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > Hi everyone,
> >
> > Thomas' RFC series incited me to put in some more work on the Tegra PCIe
> > controller driver. This in turn brought up an old issue: should we move
> > PCIe controller drivers to some central location rather than keeping
> > them in machine-specific directories? Last time I brought this up there
> > was no consensus but I really think there's some value in keeping these
> > drivers in a common location, especially now that a few people are
> > starting to work on similar problems. It may also provide some more
> > momentum to get the various DT implementations factored out of various
> > architectures.
> >
> > Stephen proposed drivers/pci/host on IRC and I second that.
> >
> > Bjorn, is this something you would be on board with?
>=20
> Sounds fine to me.

Great! Thomas, does that work for you as well?

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ5Z+sAAoJEN0jrNd/PrOhFzoP/Ayi3GTX9LJGHpjbSrC7iTSa
8shSGVdDPS79m4DGgLuablGzMoJtumNpmcsZvJ+fd65Q4WSV/V/icoA4UOB2PNGL
U/ZhyLXv9Jx/pF9i17xmBgHVicAdjfs/vbc+BoHQJ1IPlzSvLmU/LKVqWEEKspwW
p/kDLuWlXMEKyE/aCPKMpbr6FJ4oUj/WDzp87sJQqoeGRYWO1ic3Um0lFMMB4lGp
MUdZCtXtQ3MCd387IAV9hXXBHI68Y6Y7p/tNTO/5ggVByA6y8YhGWZBBjPTwLVWd
CSAESEDddx64dbco4ldg0gE7IKAreZ6Cvx3C9n2cdoW7UKhHFoIqAMB92rCh7tYD
DOEDdjl3ZfMOYcbtZo1WeOgip/rwNCH8xwWmL6DCv80cj2I/tDPFyIo+FUsVa4hR
ayUAZBpkHAON49pvnmJsLISYQivd+x+3yMinpPj8dFw51gmtPslmh2d8oMYz393r
4y58b8jickCXgtV/YPc6d97WB70Wl5P7MaTkCwtyq2lH44ghLSGKqOi3hsYrlYqK
GBS233hylTivPGa5bwZT/q3eBIa2wFtPejIDx+5A5AEWaNLUAZQffoBY5pGFjd6m
qpctTz22Qq0V8xAfuVoxOl/FcRXJS6q5JCTKrHmUYOQAwLeu6XcLtYfHDXNp/8EI
zxowWPtAF1BrzAzlbjJG
=HSxy
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

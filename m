Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61485 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab3ACOjl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 09:39:41 -0500
Date: Thu, 3 Jan 2013 15:39:31 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
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
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Thomas' RFC series incited me to put in some more work on the Tegra PCIe
controller driver. This in turn brought up an old issue: should we move
PCIe controller drivers to some central location rather than keeping
them in machine-specific directories? Last time I brought this up there
was no consensus but I really think there's some value in keeping these
drivers in a common location, especially now that a few people are
starting to work on similar problems. It may also provide some more
momentum to get the various DT implementations factored out of various
architectures.

Stephen proposed drivers/pci/host on IRC and I second that.

Bjorn, is this something you would be on board with?

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ5ZgjAAoJEN0jrNd/PrOhPUsP/2Fix9RrCnrxH9HGA/k+gDMQ
FGtLM2I2/HhsKf8wz5cG3FAURCj5570PJgKRUFKBZfuFf7RVlyewiDllSIQY4KYN
wIIUCnUCGnrb5H9uwVH4CDhdGl6lgd+GVi6UauZ8jt5q92yTwatjAlr89gzMNykl
q2OG9/65i/D6tFYCX2vCr+YowpHvT5ZfgQMfEFIxqYZmUEICF20wM6E8R5pnDf3Y
n5dyuH3ectQi9dSAD5cLB1nCXkgi57oi0pwE3iXygUFJGuv8+8MOyjBXVIxFsFkH
mVbl4PWI6Xn0Shn5PcC7KlwXfcFHFH9rwEmVvs8bAH4a1vnHpzsq1y3xf6Dvejjh
g5Ten5zBDysoAoTP9Fx/vqjp9Hx4SfT0fyMYp5XB3ckRh+LskwPtMv6Ha2PH3GJs
skV3UMk4ISoxRQ8+NLqOEvXuE0JBC4jwSy4/s8CPK3c1NUf6hNP6z/4hnvr9uCOk
hEmByI1Lux7OsC+rDcI8y0cv2+Yj3DKQLJw+3bfgwCY709rnUtnG7biiUqqv6FVs
F/8Xoga3NAQJZezHlL64BuTj+oFGoUrj4zgtm5sTxaYGD6MpxAeATQXy6ADnZ6OZ
DRVeVA9cTLMycbDtA7MaPRDBTgX6v0f71uggJC/CQZ5V91daAw5h53cmirrCEseW
RR5213kj6OQAPJDARSly
=XwN8
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

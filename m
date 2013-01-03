Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56143 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab3ACQBn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 11:01:43 -0500
Date: Thu, 3 Jan 2013 17:01:06 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
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
	Rob Herring <robherring2@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <20130103160106.GA7086@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
 <201301031556.31618.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <201301031556.31618.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2013 at 03:56:31PM +0000, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Thierry Reding wrote:
> > Stephen proposed drivers/pci/host on IRC and I second that.
>=20
> Agreed, I like that, too. There is a little problem with cross-platform
> PCI hosts still because some portion of the interface is still arch
> specific, but I don't see this as a show-stopper for moving drivers
> there. The ARM specific drivers can still use the ARM interfaces
> for now, until everything is made generic. If they are going to
> be shared with other architectures, those can use the same interfaces
> that ARM has. I think Microblaze, ARC and Metag are strong candidates
> for doing this.

Great, sounds like a plan. I'll move Tegra PCIe into drivers/pci/host
then.

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ5atBAAoJEN0jrNd/PrOhPVYP/0V9lIMwKKPxjuTM/RwlLv8z
OUWaoAuEbmo8v7lHfrMSUdyvkKjW+KH9nRWIdKCMYrbFwddEuJ6DBQT4sJe0oF0Q
rBITcYlotQrLdbipkJYMAQEFEQEPQQi1nSpBepViFkv6zR/AMvgxyc5y4uT3DHyu
3Qv65s2KcDuWYKsWfclw3+EeBUcmpr1DzJUU1AxUiNrESZdxkChTJW5QR8t08qJu
TjWAImzn9ClbY1WUAg29lXkY3YslUEBvJJUd2VyVO7P0WvboNAwm1T9vu+lvYBea
zvbHALpuAdL/OzgUqiUzGP/gNMTqdgGT2+ImT9W+QjPKk58yOiuXzIYFK6JXIC2q
TKzVOU/RNQ3Oju5nuL7ukvoylfjDaIFwmzhMsfqnWNvMWx4YXa2Nok+IMkkhlh5j
OPdyQgVWWRiv9r5ZEHdts0a5HFCqmCuz1XypZKvS11ep42QNW+e0EDs00kz6Gsja
vBYqoW3mB4TYVuHRN4jDbCXEVzge+Jj6IDd0WqUIbtl51siJnR8iSQopO1K/keMr
+Nhs8Oe5/NceklD4fJXrvk/37fZNsOa0zofDYD5h/+a19ClVIkUi6U9XfZ6XZwa+
joVrVOZs00lMsDS9tzoF6eK+xT+qeTlzLP/TgyaoqOX10k+g+0tbDUU2Bir7ts9w
UpjQgOze82749mAKFnCT
=PB3T
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

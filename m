Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50442 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762193Ab2FVOCg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 10:02:36 -0400
Date: Fri, 22 Jun 2012 16:02:10 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120622140210.GA32097@avionic-0098.mockup.avionic-design.de>
References: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <20120622110403.GA15710@avionic-0098.mockup.avionic-design.de>
 <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
 <201206221348.39346.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <201206221348.39346.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2012 at 01:48:39PM +0000, Arnd Bergmann wrote:
> On Friday 22 June 2012, Thierry Reding wrote:
> > > It seems like this isn't working properly. For some reason both the r=
eg
> > > property of pci@0 and pci@1 are translated to the same parent address
> > > 0x80000000. I'll have to investigate where exactly this goes wrong.
> >=20
> > So it turns out that while of_read_number() can actually read any number
> > of cells, only the two least significant are kept because it returns a
> > u64. Since of_bus_default_map() uses of_read_number() the addresses
> > <0 0 0> and <1 0 0> are in fact the same. I'm not sure how best to solve
> > this. I'm not aware of a 128 bit integer type in the kernel, so I guess
> > the better alternative would be to fix of_bus_default_map() to cope with
> > #address-cells > 2 properly.
>=20
> of_translate_address should get it right. Which codes uses of_read_number=
()?
> Can it be converted to use of_translate_address()?

Actually this is from of_translate_address(). The calling sequence looks
like this:

	of_address_to_resource()
	  __of_address_to_resource()
	    of_translate_address()
	      __of_translate_address()
	        of_translate_one()
	          of_bus_default_map()
	            of_read_number()

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP5HrhAAoJEN0jrNd/PrOhpSoP/2dJqBOz5dAHlOYm5bO6JKCn
T8EmkjimgPc9auk4L1+x9g+eZxsRBK3RLrvAEzxREEf6H/aVmFA3mejKkPkYAzrW
bG97ZCwwc7lKtgEpRxvcKpUie0dJ+q4RxGG4jra77NJHa/kiuCMsx7NyLArHnFby
9+TiB1db1G/5D8yigkTac2tugNIyaNozHwgtQpGUTBklhz7q+cwDvCwT5LeAivuS
wdjGuleY2RMAA++gIQV1efdWmRUXxitHz1sciVLv8I7E7LHwnCSD4OWS6rMChfht
tZoKT64kZS+OKWZaxwAXiZSHHaSljA1ihhYnXBNWzD1UWXQUY0F19diphUyKqbu3
Tk1T+ebqco/teh7wm9nRy0w9/BmA2O/UPaoeihTAxYR6vxJQ7RV3dps4NQArKiCW
0xXDenjQ7Cjam+0e+jQOeZ73V3+dgoa2pWOBHYXuZ5AkLk6y2d5vSY5OKRoEHyIY
pOqujRVETTuExSyrZyzNYViykgYYaHVQvLPiodoXvJVdwC4TRS2dUw8N1ObHVRaW
Zh//IAGKjDI7CUvv8GxOHloatKT69jxyxAnBb73lonr2VUNATaWDADims6rdN/8i
8tzPOjU8Q3wSRQ3KgfVxd04BHR1xbUN65QKDvx6rc0WHL4RwJ8rP/nd5Cm3o0iIq
1N1enH8GljdveLxzRzla
=3yXM
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

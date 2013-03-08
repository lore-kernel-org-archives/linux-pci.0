Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58354 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3CHHO4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 02:14:56 -0500
Date: Fri, 8 Mar 2013 08:14:44 +0100
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
Message-ID: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
References: <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <51392B4D.9040404@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
> On 03/07/2013 02:47 PM, Thierry Reding wrote:
[...]
> > In a nutshell (since some of the context isn't quoted anymore) the
> > problem that we're trying to solve is that some of the embedded SoCs
> > require per-root-port registers for configuration. The PCI DT
> > specification doesn't make any provisions for this. A few alternatives
> > have been discussed so far:
>=20
> I'm not sure I follow. This is different than the host controller
> registers? Why would this not just be multiple entries in the reg propert=
y?

Well the register regions are per root-port. On Tegra20 there's 2 of
them, Tegra30 has 3 and if I understand correctly Marvell can have up to
10 (!). Adding all of them to the reg property of the host controller
could work but it needs some way to match the reg entry to the root port
similar to option 1 below.

Adding a property in the root port nodes seems like a cleaner and more
accurate representation of the hardware to me, but if that's not
acceptable perhaps we need to bite the bullet and add the code to look
the registers up from the parent's reg property.

Thierry

> > 	1) Use a "regs" property outside of the root port nodes with
> > 	   some mechanism to index into them from within the root port
> > 	   nodes. Conceptually somewhat like this:
> >=20
> > 		pcie-controller {
> > 			...
> > 			regs =3D <0x80000000 0x00001000
> > 			        0x80001000 0x00001000>;
> >=20
> > 			pci@0,1 {
> > 				...
> > 				port-index =3D <0>;
> > 			};
> >=20
> > 			pci@0,2 {
> > 				...
> > 				port-index =3D <1>;
> > 			};
> > 		};
> >=20
> > 	2) Use a "regs" property inside of the root part nodes, along
> > 	   the following lines:
> >=20
> > 		pcie-controller {
> > 			...
> > 			pci@0,1 {
> > 				...
> > 				reg =3D <0x00000800 0 0 0 0>;
> >=20
> > 				regs =3D <0x80000000 0x00001000>;
> > 			};
> >=20
> > 			pci@0,2 {
> > 				...
> > 				reg =3D <0x00001000 0 0 0 0>;
> >=20
> > 				regs =3D <0x80001000 0x00001000>;
> > 			};
> > 		};
> >=20
> > 	3) Repurpose the "assigned-addresses" property to achieve the
> > 	   same. This should work out-of-the-box but isn't a good fit
> > 	   because it conflicts with the OF PCI specification which
> > 	   defines this property to contain the addresses assigned to
> > 	   the base address registers.
> >=20
> > Options 1 and 2 above require changes to the OF core to allow proper
> > address translation, but the changes shouldn't be very big.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROY/jAAoJEN0jrNd/PrOh0kQP/R/jIGgDvcEeFH2TWGUfyoNY
bDANGX7SkzzdjG6ykGqF5SAbl6hyXsScF74t6zHYVJBpfTm9129p2Jx1X1KQvVRb
KseeOxwoc+tllvIkfOCQk+/rgfhQr6xUdNq53mt9nSSp2HAEjteKOLUSxFce6srN
VfcML3QTuIdTw/8zS3uo6I1mle1HjXNAvnlCfK0EtEhUKI+M/RsJdC3EueINrTMk
CE8DE/C9Vc77xMimKt3GqUM7CjxSro9Xe3PIiPSknOUIJ54trHHRVMAekOz4SWtg
ODJZN1eGPsPy39DT009C19YQX4zNhAC31GLvoFu/XmNMkDCmat9H3hBG0i78DfEe
wN6L5t1yHxYDKTttOlICBdg9tNxducu7mdLX7VHrJ0ovttNV1xOHRyQgPF+sBpxm
1sa2NRrLyN/j7qYBSxZma4WkjdNXFguXfeZQz9eSJEWx75mw48/m7/NPTWvFVwAD
OjgDgSp8LPoCpKhNX5CnFYdBCy4R8dqg5UtcQYEIAAjpCg8C42/YKmDzEPo9vueG
SKfvqFoc9S1+qXRmOMBBhF/n0+CLHk6cC1YjWPNai5729czI4pfpyNl+nc8JHfup
179J/EkvOHMKBoMUBHM4EGwS7eJjzCBh1O3FmhY/20O2AqKHBlk3gTwvoHZHDEQD
D8ODtluUQ7DPUohzAn3I
=Q/re
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

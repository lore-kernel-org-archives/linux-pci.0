Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55609 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab3CGIIw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 03:08:52 -0500
Date: Thu, 7 Mar 2013 09:08:32 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
In-Reply-To: <20130306180946.GA2433@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2013 at 11:09:46AM -0700, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2013 at 01:11:19PM +0100, Thierry Reding wrote:
>=20
> > I agree here. It seems that back at the time when the PCI DT bindings
> > were devised no hardware existed with these properties. So I think that
> > maybe it needs to be revised to take into account some of these new
> > requirements. Just adding a bunch of properties to work around
> > shortcomings in the specification doesn't seem very desirable to me.
>=20
> Well, all the PCI hosts should use the same mechanism, and it should
> make sense in the context of the rest of the spec. So I think some
> approval/comment on this specific issue by Grant/Rob/Arnd is important
> at this point.
>=20
> The way the spec is written, 'reg' in a 'device_type =3D pci' context is
> the device's config address - it is like 'reg' in a CPU block, or I2C
> bus - the value has nothing to do with CPU mappable memory.
>=20
> > space. According to the PCI DT specification this isn't allowed, but it
> > works on Linux and quite frankly I don't see why it shouldn't be
> > allowed.
>=20
> AFAIK, this only works because you are not using 'device_type =3D pci'.
>=20
> IMHO, 'device_type =3D pci' is not optional, so you need to come up with
> something that works under those conditions, and it changes how the OF
> core handles 'reg' and the like.

Actually I do use device_type =3D "pciex" for the pci@1,0 and pci@2,0
nodes which was suggested back when I first posted this series. Yet the
address translation still works properly. And it should since they are
translated to the parent bus which is used to access the configuration
space window for each root port.

Looking at the code it looks indeed like the OF core only matches on
"pci" (and "vci"), but not "pciex". Perhaps I should change both nodes
to device_type =3D "pci" and see what the results are.

> As I said before, the two best options to me seem to be:
>=20
> pcie-controller {
>  compatible =3D "marvell,armada-370-xp-pcie";
>=20
>   // Index by marvell,pcie-port/reg-names/etc
>   regs =3D <0xd0040000 0x00002000
>           0xd0080000 0x00002000>;
>=20
>   ranges =3D <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/=
O */
>             0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchabl=
e memory */
>=20
>   pcie@0,0 {
>        device_type =3D "pci";
>        reg =3D <0x0800 0 0 0>; // 00:01.0  (????)
>        marvell,pcie-port =3D <0>;
>   };
> }
>=20
> or:
>=20
> pcie-controller {
>   compatible =3D "marvell,armada-370-xp-pcie";
>=20
>   ranges =3D <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/=
O */
>             0x82000000 0 0  0xc1000000  0 0x08000000   /* non-prefetchabl=
e memory */
>             // Mapping for per-port host controller registers
>             0x82000000 0x10000000 0xd0040000  0xd0040000  0 0x2000>;
>=20
>   pcie@0,0 {
>        device_type =3D "pci";
>        reg =3D <0x0800 0 0 0>; // 00:01.0  (????)
>        marvell,pcie-port =3D <0>;
>       =20
>        assigned-addresses =3D <0 0 0  0 0 // BAR 0 of the bridge, unused
>        			     0 0 0  0 0 // BAR 1 of the bridge, unused
>                              0x82000000 0x10000000 0xd0040000  0 0x2000>;=
 // Extended
>=20
>   };
> }
>=20
> Both have various problems, but I think I prefer the first one as it
> doesn't conflate the contoller registers and host apertures in a
> single ranges..

I think a better alternative would be (and this matches what Thomas has
said elsewhere) to use something like the first alternative but move the
regs property into the pcie@0,X nodes. That would save us from having to
index a property in the parent. At least from a DT point of view I find
that to be a more consistent representation.

However that would probably not work out-of-the-box with the current OF
core because of_address_to_resource() won't know how to find the new
property. The assigned-addresses alternative seems to be the only one
that would work on the current OF core and achieve proper address
translation. But it doesn't seem like a good solution either since it
repurposes the meaning of the property and therefore isn't any better
than encoding the same information in the reg property.

Thierry

--3Pql8miugIZX0722
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROEsAAAoJEN0jrNd/PrOhUPIP+wbO88+FvbyUxMpxukEitSiI
kbT9f7K0DOFS9mnKruyahs7TIOmYcXlwmI4JbHcMuYXv5Xwl+mpu/nPp4S94uZRc
tRRdoDkPtIze4aBO2AwUSGhWworFXZWIpBz5NszKeQXCVPNE69sTKHII+977HdKM
RNlLcKffGY5LzBMI1qEFjDpB1NV8vijjerl5IjjwcXvZUmYZVCZZnwmam1rNgjUJ
D3xKGPCXDEdqDklZzGC9myMO73Oy+IVihDY51oGdl7FbgnQchUPxDb42aBS3h/6S
PbZ0LYERSQIY2f4I0+IbRc2iH0liESqfpxx/F+2+FkWIMP8/sVR+MEQG3ETlqNNI
FakJiM8IYTPSpa3CSWw/SOLTbIHpBn7H6HlGz0X3MoqT1a/mJKUSvPmurm287qaC
ILUK1nn1N5S4s0jCoYvUt1Qgf1xayld2iUlKUsdEoSIkQbtUJWvKgXg1gpyVc3SX
v7OiZpCYUVsiW+XLP5tawyT/ISuMkFPcimlM1DcnxxiBGlf9G7HxgRd0LMBdGPf3
AUvbEEy8SLCUnirdwEJXnSnn99jqMCurvTI8NV2iRkKfePAfpo2MuEVD/TYX4F/V
+UeHp6hq2VKaqnlU1Nrym3KyKTtdLMysbqBVBUJ0WpfwfluJiT0cJEdZBtjYr561
kKvH3dNvxA3Gg7cGkxwK
=fqj/
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--

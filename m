Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab3CFMLk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 07:11:40 -0500
Date: Wed, 6 Mar 2013 13:11:19 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
Message-ID: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <20130306105441.4d24033e@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2013 at 10:54:41AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
>=20
> On Tue, 12 Feb 2013 15:35:11 -0700, Jason Gunthorpe wrote:
>=20
> > > +	pcie@0,0 {
> > > +		device_type =3D "pciex";
> > > +		reg =3D <0x0800 0 0xd0040000 0 0x2000>;
> >=20
> > It would be great to get this sorted as per my prior comments.. Maybe
> > like this is easy?
> >=20
> > pcie-controller {
> >  compatible =3D "marvell,armada-370-xp-pcie";
> >=20
> >  // Index by marvell,pcie-port ?
> >  regs =3D <0xd0040000 0x00002000
> >          0xd0080000 0x00002000>;
> >=20
> >  ranges =3D <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I=
/O */
> >            0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchab=
le memory */
> >=20
> >  pcie@0,0 {
> >       device_type =3D "pci";
> >       reg =3D <0x0800 0 0 0>; // 00:01.0  (????)
> >       marvell,pcie-port =3D <0>;
> >  };
> > }
> >=20
> > It is abusive to map the device internal per-port registers through
> > '0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
> > the OF spec.
>=20
> The Device Tree would really look odd. We have one register range for
> each PCIe interface, but instead of nicely putting them inside the
> pcie@X,Y subnodes, we have a global regs =3D <..> property at the
> pcie-controller level? I can do that if you want, but it really sounds
> like the standard PCI DT bindings are horrible. Those register ranges
> are *per* PCIe interface, so any logical person would expect them
> inside the pcie@X,Y node...

I agree here. It seems that back at the time when the PCI DT bindings
were devised no hardware existed with these properties. So I think that
maybe it needs to be revised to take into account some of these new
requirements. Just adding a bunch of properties to work around
shortcomings in the specification doesn't seem very desirable to me.

That said, on Tegra there's an additional argument in favour of this
because the addresses mapped through the ranges/reg properties are
actually used to access the device's configuration space, which the
'ss' field in the first cell specifies. Quoting the DTS:

	pcie-controller {
		...
		ranges =3D <0x00000800 0 0x80000000 0x80000000 0 0x00001000   /* port 0 r=
egisters */
			  0x00001000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers =
*/
			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0          0xa0000000 0 0x10000000   /* non-prefetchable =
memory */
			  0xc2000000 0 0          0xb0000000 0 0x10000000>; /* prefetchable memo=
ry */
		...
		pci@1,0 {
			...
			reg =3D <0x000800 0 0x80000000 0 0x1000>;
			...
		};

		pci@2,0 {
			...
			reg =3D <0x001000 0 0x80001000 0 0x1000>;
			...
		};
	};

So we're actually mapping the configuration space of pci@1,0 and pci@2,0
to the 0x80000000 and 0x80001000 addresses of the CPU physical address
space. According to the PCI DT specification this isn't allowed, but it
works on Linux and quite frankly I don't see why it shouldn't be
allowed.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNzJmAAoJEN0jrNd/PrOhJ3wQAKEB9DkiTpZRgjoZVDVzO7nr
EYMIyESIudQgKV5rGGpA50GodpzM/aOBP5obQL5tAmUD2zCyMc/tv7c1MP3pgQUK
NtNTZ7mIGILQFTtR2uftLzsxD5BmPxUqz+HKRWPL6TgL81Hujbes7unW+vt+1Suz
uH8/Y8KYGdsoLvYkJ5xrND6d5bXr/bmo4LlRfR+fNU8vv/+1m2dY3cIhRjZv7GqQ
bKqlnPe7Ka7ytBL3TneQXT33uXCZGAWFIvCpQvrTZg6h+ylf8/LnvqDI887W4zDW
tQHUe02AFz2/CE6c2zJfDl/Dnr7gPdsRySYVaRSDqsElf/IcRKtRxhMH9Qxndpzb
bov1LWM3AG+9VDECKnnQC1RKLtWA5LiGTA0TCNX69/mQuKemSVZLFt9F8v3x1Lm4
VLWWYLnwj0PQ4gS8HMMXiMAWzBW4dMJISugDUzZannyzes52i5XvIXt4nCjPbl8J
bay53R8aNjzyMO0ek9bX/rTa+q9HOtuwL14g8bmqVlpkNVKwFvcjnT2NPcX98vLN
aiD4YnJel3Md6UQtcjr2+9ltEop350Tgc1bkQHtjXCYhmxTs+X/5uEE/evLDf03M
S6bqxvCG5CpeS/7nZ5cfATzE4mpDq7IJyVcacU2HIkltEzPBJqmHFkunQoFTNPfx
kAcjYDl/dd7QqgYjZN5L
=HUYc
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

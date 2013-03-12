Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab3CLUjG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 16:39:06 -0400
Date: Tue, 12 Mar 2013 21:38:19 +0100
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
Message-ID: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
References: <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <20130312155749.GA1820@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 09:57:49AM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 08:08:52AM +0100, Thierry Reding wrote:
>=20
> > So to recapitulate, we agree that configuration space can be translated
> > through the "ranges" property. That means the only missing link is a new
> > function to translate not only "assigned-addresses" but also the "reg"
> > property for PCI devices. Is that it?
>=20
> No, the first conclusion is that placing a config space in ranges is
> against the language in the current spec (see section 12).
>=20
> The second conclusion is that there is probably a way forward to
> update the spec in a backwards compatible way to model ECAM, but would
> require more analysis.
>=20
> Finally, there was no objections to the approach in Thomas's patch,
> other than the note to fix the '@1,0' and the extra device_type=3D"pci"

That's not what I deduced from Mitch's comments. He said explicitly that
he liked the idea to represent mapped configuration space using the
ranges property. Mitch, correct me if I misinterpret what you said.

I've also verified that things actually do work with the binding that I
proposed for Tegra, even if I add device_type =3D "pci" to the root port
nodes. The reason is that the OF core looks up the type of the *parent*
node to find a matching bus. This happens to be the pcie-controller node
which is not a PCI device and therefore the address translation works
properly.

So let me quote the latest binding that I'm using:

	pcie-controller {
		compatible =3D "nvidia,tegra20-pcie";
		reg =3D <0x80003000 0x00000800   /* PADS registers */
		       0x80003800 0x00000200   /* AFI registers */
		       0x90000000 0x10000000>; /* configuration space */
		reg-names =3D "pads", "afi", "cs";
		interrupts =3D <0 98 0x04   /* controller interrupt */
		              0 99 0x04>; /* MSI interrupt */
		interrupt-names =3D "intr", "msi";

		bus-range =3D <0x00 0xff>;
		#address-cells =3D <3>;
		#size-cells =3D <2>;

		ranges =3D <0x00000800 0 0 0x80000000 0 0x00001000   /* port 0 configurat=
ion space */
			  0x00001000 0 0 0x80001000 0 0x00001000   /* port 1 configuration space=
 */
			  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
			  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */

		clocks =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
			 <&tegra_car 118>;
		clock-names =3D "pex", "afi", "pcie_xclk", "pll_e";
		status =3D "disabled";

		pci@1,0 {
			device_type =3D "pci";
			reg =3D <0x000800 0 0 0 0x1000>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			nvidia,num-lanes =3D <2>;
		};

		pci@2,0 {
			device_type =3D "pci";
			reg =3D <0x001000 0 0 0 0x1000>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			nvidia,num-lanes =3D <2>;
		};
	};

I can't find anything wrong in the above. As far as I can tell, there's
nothing in it that's in conflict with the specification.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRP5I7AAoJEN0jrNd/PrOhYYMP/RIOQmaVFNfq67fYKqk19b67
zXW4BD/xdnI9YJols/3O+XTotD+1coEtjMgja3Om9YA2url2yZYJYkobDfhJ5gTl
P2BcZ9S7m52kDhfY//snnuPJQo2kb33Fog4PBlqk2OpBSaIQlbcvl75tZRi+hOxr
tX1XyYsUlI0Ig7HOAV+K5TNP7kaznW5tNEFzIWTcso2Owa32rotHkU68+BJfEjPu
9rsUHKP6WQiIDe9o+Lu7LlJhvBls4i6unPSatgZh9k4Dxq5cSf9D7pcmd7RhZ6xZ
Qz56JXniTnBy3N2xSS/dPP8Zw+TtR54GUzwNK5bxXSAFakqrB/BpEg+aG/4gltYz
RZwv33dh+7iiyfUfKNRIHzQg7O9zscNJfgy5GT5OPl36/SM8s3fbTGJMEtKw73c2
EH1zDMqWPv6gZ1rvyee5vAJR1/zdMYJlimKsjrPk1ndqXhgWtTuaWzwQiHJItMba
DbrW9QPZRpEoOgTcb/naYjdYOeBWMqg5joQBsF2UotgWcsrDZr42/Ne8NrnLZ671
3O6VyH25fyhq1TOGYK68+habWRDEfhk7ZLcplikW+O2jE1rRS742PuhBQmx8fD4H
ai/WmUlRleiHPQRVLr3h5K/7UTBIS6afnyFdFvuKdAJKUye9myPvjZ8JxNINhnCD
Lc3N0hYx9Vcy+5gawcNT
=WPEm
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

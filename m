Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63510 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab3CZUR6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 16:17:58 -0400
Date: Tue, 26 Mar 2013 21:16:54 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <20130326163421.GA30255@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 10:34:21AM -0600, Jason Gunthorpe wrote:
[...]
> This basically looks fine to me, however, I think it is valuable if
> you and Thierry could use the same method to pass per-port registers. I
> expect others are going to reference these bindings for future work,
> and one standard method is more clear than two.
>=20
> Thierry: Did you settle on using assigned-addresses? Can you share the
> final binding for your driver?

Yes, I have the final bindings ready and I was waiting for Andrew's new
version of the ranges parsing patch before sending the next (and
hopefully final) version of the series. He posted that patch now so I
should have something ready soon. For now here's what I currently use
for DT:

	pcie-controller {
		compatible =3D "nvidia,tegra20-pcie";
		device_type =3D "pci";
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

		ranges =3D <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 r=
egisters */
			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers =
*/
			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable =
memory */
			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memo=
ry */

		clocks =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
			 <&tegra_car 118>;
		clock-names =3D "pex", "afi", "pcie_xclk", "pll_e";
		status =3D "disabled";

		pci@1,0 {
			device_type =3D "pci";
			assigned-addresses =3D <0x82000800 0 0x80000000 0 0x1000>;
			reg =3D <0x000800 0 0 0 0>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			nvidia,num-lanes =3D <2>;
		};

		pci@2,0 {
			device_type =3D "pci";
			assigned-addresses =3D <0x82001000 0 0x80001000 0 0x1000>;
			reg =3D <0x001000 0 0 0 0>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			nvidia,num-lanes =3D <2>;
		};
	};

I think that has everything that we discussed previously.

Thierry

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRUgI2AAoJEN0jrNd/PrOhaFkQAKkYjrCAD9YdSO7gM34Q01Z6
w8J4wHXeBwCvbzAiJInQVVSzvusrD8kJVYpj4zvmD/fcCLcPNLHy6AFyZ7W4fcjy
Z8byM5z8FW+bvV1+tvw9hiCa7f4bYfrZiG9iN8201OnfFoKcbm0PT95d0CZGf7OW
l69d9GWLYRRV/Xgeqbp7uAbq0/aOsG0I8x3McUsbM52onsICPDQJFNvX7JYh+Vsz
waNG314tBJdDgheqik4+zyZLZLy+SNNT11x6M+OW6jBqfkBa68udxSZDXeaveFoZ
8oBCmWpuFDPtr9GI5eP62PtBCJ8dXgQp/shzytAUzd6Lcxi8fJmfpnqaGu4x3yKQ
+ePG+DJ+NEUddfMb1SF2Bm3u0AZl0FYX/VWRi8yTstXnNc2OZWcXj8uxiRDunt+F
mOo/FJWtpwbM15OYrLdF333/cV331ihG+hhEiN9E92NcYKTz/79duJd9cAKWhIh4
AVx8aWBtFv5gChJiIcwjP1SzGA/poskEd9nAq6lmq2QfW9l2SbDrY3pVo9jyep56
FUlMJWdVkt8n/Iv0DbEWhAoxDI08dFnWWnY/CeZd9+HYp3nBpVc+KX+BLYAGkPCm
GUe0szLDxE92L45y9aA87SjAGy/fHbbtAVH9upGcBONoGW0ivM7MdpoEtS4v1NVe
wQFXaQ4RIMGo21he8U5F
=amPE
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

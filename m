Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56628 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab2HNUMf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 16:12:35 -0400
Date: Tue, 14 Aug 2012 22:12:15 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 09:55:12PM +0200, Thierry Reding wrote:
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.d=
tsi
> index a094c97..c886dff 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -199,6 +199,68 @@
>  		#size-cells =3D <0>;
>  	};
> =20
> +	pcie-controller {
> +		compatible =3D "nvidia,tegra20-pcie";
> +		reg =3D <0x80003000 0x00000800   /* PADS registers */
> +		       0x80003800 0x00000200   /* AFI registers */
> +		       0x81000000 0x01000000   /* configuration space */
> +		       0x90000000 0x10000000>; /* extended configuration space */
> +		interrupts =3D <0 98 0x04   /* controller interrupt */
> +		              0 99 0x04>; /* MSI interrupt */
> +		status =3D "disabled";
> +
> +		ranges =3D <0 0 0  0x80000000 0x00001000   /* root port 0 */
> +			  0 1 0  0x81000000 0x00800000   /* port 0 config space */
> +			  0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
> +			  0 3 0  0x82000000 0x00010000   /* port 0 downstream I/O */
> +			  0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
> +			  0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
> +
> +			  1 0 0  0x80001000 0x00001000   /* root port 1 */
> +			  1 1 0  0x81800000 0x00800000   /* port 1 config space */
> +			  1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
> +			  1 3 0  0x82010000 0x00010000   /* port 1 downstream I/O */
> +			  1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
> +			  1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */

I've been thinking about this some more. The translations for both the
regular and extended configuration spaces are configured in the top-
level PCIe controller. It is therefore wrong how they are passed to the
PCI host bridges via the ranges property.

I remember Mitch saying that it should be passed down to the children
because it is partitioned among them, but since the layout is compatible
with ECAM, the partitioning isn't as simple as what's in the tree. In
fact the partitions will be dependent on the number of devices attached
to the host bridges.

> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <1>;
> +
> +		pci@0 {
> +			device_type =3D "pciex";
> +			reg =3D <0 0 0 0x1000>;
> +			status =3D "disabled";
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +
> +			ranges =3D <0x80000000 0 0  0 1 0  0 0x00800000   /* config space */
> +				  0x90000000 0 0  0 2 0  0 0x08000000   /* ext config space */
> +				  0x81000000 0 0  0 3 0  0 0x00010000   /* I/O */
> +				  0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
> +				  0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
> +
> +			nvidia,num-lanes =3D <2>;
> +		};
> +
> +		pci@1 {
> +			device_type =3D "pciex";
> +			reg =3D <1 0 0 0x1000>;
> +			status =3D "disabled";
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +
> +			ranges =3D <0x80000000 0 0  1 1 0  0 0x00800000   /* config space */
> +				  0x90000000 0 0  1 2 0  0 0x08000000   /* ext config space */
> +				  0x81000000 0 0  1 3 0  0 0x00010000   /* I/O */
> +				  0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
> +				  0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
> +
> +			nvidia,num-lanes =3D <2>;
> +		};
> +	};

The same is true for the ranges properties of the PCI host bridge nodes.
Which part of the configuration spaces maps to the children of the
respective host bridge depends on the actual device hierarchy.

Would it be possible to alternatively pass the complete range to the
children without further partitioning?

The driver doesn't actually care about the ranges property and only uses
the values specified in the reg property of the pcie-controller node.

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKrEfAAoJEN0jrNd/PrOhPmMQALt4izwmLsNjMlYFcqX1w521
J0JpuuT4ogI9TvnLLE7g5enTcMyNT0jH58dWF6LzlKCMAfPj8X5sFsFMn6UBo1Fi
DSBOvROYBNFw7aBMQvniI+noIMHQLO1UaAJnhjghAY4/4aS52mkxVcHmNv/f88wq
8C3nATkeEgzgysXyvIC6uLPsG53EaaFShloYDakTDl1iUfsEdK7zelzRHlIrVpzo
m8GFd20QBNjqwN62wkZcFvAxYHu1K+7wGN0U/5LOgnKZe1RjxwxXWdLKXkiSSLJY
4qqbkY5soUkg/3uFXfqH7ruuTyDa2rqsc6PbDnE9Ljeaydq50q+7r/gTILY1k1Xa
GIIhvzphd/g457TzQKp9EXHxRKqTvSlXTMsu/e0VQ+w4dc86gcDYv3IRnF1gIhMT
SMNEEr7kBrcYCUsrwDRXKGQyqrAZdweIAbGUSUiob6Ogji8FsghqyI/h/TY/Z2W5
fkLddNakaoyVs8vr5VDpInr5ASPQSIbArx4CiLi0ALPMwLY8Ai/M2+eQSE+zD7h1
+4swgf/o15GBkZqtAMePELx11yCN9E7olWWI9xkDIVwkjNCjD4CQJ4UVCtup5F24
nq6l0VsxcX+ydMRQA9NZmf1XXdSMwoO2NrpmQBOvCRoy0j2QXhgxuiZut0aXF71u
RNK269viHeqbMBRiDLc8
=XyB7
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

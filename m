Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52695 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdJMQhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2017 12:37:16 -0400
Date: Fri, 13 Oct 2017 18:37:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mperttunen@nvidia.com
Subject: Re: [PATCH V2 1/4] dt-bindings: pci: tegra: Document Tegra186 PCIe DT
Message-ID: <20171013163712.GA8761@ulmo>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
 <1506513517-25870-2-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <1506513517-25870-2-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 05:28:34PM +0530, Manikanta Maddireddy wrote:
> Tegra186 PCIe controller DT properties has couple of differences
> wrt Tegra210 PCIe, rest of the DT properties are same.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> V2: No change in this patch
>  .../bindings/pci/nvidia,tegra20-pcie.txt           | 134 +++++++++++++++=
+++++-
>  1 file changed, 130 insertions(+), 4 deletions(-)

Hi Rob,

Manikanta forgot to add you on Cc on this one. Can you take a look or
should Manikanta resend the series to include you and the device tree
mailing list?

FWIW, this looks good to me, so:

Acked-by: Thierry Reding <treding@nvidia.com>

Bjorn,

I take it that you'd pull this into the PCI tree along with the host
controller driver changes? I can take patches 3 and 4 through the Tegra
tree.

Thierry

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 982a74ea6df9..753b67327373 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -1,10 +1,15 @@
>  NVIDIA Tegra PCIe controller
> =20
>  Required properties:
> -- compatible: For Tegra20, must contain "nvidia,tegra20-pcie".  For Tegr=
a30,
> -  "nvidia,tegra30-pcie".  For Tegra124, must contain "nvidia,tegra124-pc=
ie".
> -  Otherwise, must contain "nvidia,<chip>-pcie", plus one of the above, w=
here
> -  <chip> is tegra132 or tegra210.
> +- compatible: Must be:
> +  - "nvidia,tegra20-pcie": for Tegra20
> +  - "nvidia,tegra30-pcie": for Tegra30
> +  - "nvidia,tegra124-pcie": for Tegra124 and Tegra132
> +  - "nvidia,tegra210-pcie": for Tegra210
> +  - "nvidia,tegra186-pcie": for Tegra186
> +- power-domains: To ungate power partition by BPMP powergate driver. Must
> +contain BPMP phandle and PCIe power partition ID. This is required only
> +for Tegra186.
>  - device_type: Must be "pci"
>  - reg: A list of physical base address and length for each set of contro=
ller
>    registers. Must contain an entry for each entry in the reg-names prope=
rty.
> @@ -124,6 +129,16 @@ Power supplies for Tegra210:
>    - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
>      supply 1.8 V.
> =20
> +Power supplies for Tegra186:
> +- Required:
> +  - dvdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> +  - hvdd-pex-pll-supply: High-voltage supply for PLLE (shared with USB3)=
=2E Must
> +    supply 1.8 V.
> +  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output cl=
ocks.
> +    Must supply 1.8 V.
> +  - vddio-pexctl-aud-supply: Power supply for PCIe side band signals. Mu=
st
> +    supply 1.8 V.
> +
>  Root ports are defined as subnodes of the PCIe controller node.
> =20
>  Required properties:
> @@ -546,3 +561,114 @@ Board DTS:
>  			status =3D "okay";
>  		};
>  	};
> +
> +Tegra186:
> +---------
> +
> +SoC DTSI:
> +
> +	pcie@10003000 {
> +		compatible =3D "nvidia,tegra186-pcie";
> +		power-domains =3D <&bpmp TEGRA186_POWER_DOMAIN_PCX>;
> +		device_type =3D "pci";
> +		reg =3D <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
> +		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
> +		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
> +		reg-names =3D "pads", "afi", "cs";
> +
> +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interru=
pt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		bus-range =3D <0x00 0xff>;
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +
> +		ranges =3D <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* p=
ort 0 configuration space */
> +			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 con=
figuration space */
> +			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 con=
figuration space */
> +			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream=
 I/O (64 KiB) */
> +			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefet=
chable memory (127 MiB) */
> +			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchab=
le memory (640 MiB) */
> +
> +		clocks =3D <&bpmp TEGRA186_CLK_AFI>,
> +			 <&bpmp TEGRA186_CLK_PCIE>,
> +			 <&bpmp TEGRA186_CLK_PLLE>;
> +		clock-names =3D "afi", "pex", "pll_e";
> +
> +		resets =3D <&bpmp TEGRA186_RESET_AFI>,
> +			 <&bpmp TEGRA186_RESET_PCIE>,
> +			 <&bpmp TEGRA186_RESET_PCIEXCLK>;
> +		reset-names =3D "afi", "pex", "pcie_x";
> +
> +		status =3D "disabled";
> +
> +		pci@1,0 {
> +			device_type =3D "pci";
> +			assigned-addresses =3D <0x82000800 0 0x10000000 0 0x1000>;
> +			reg =3D <0x000800 0 0 0 0>;
> +			status =3D "disabled";
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			ranges;
> +
> +			nvidia,num-lanes =3D <2>;
> +		};
> +
> +		pci@2,0 {
> +			device_type =3D "pci";
> +			assigned-addresses =3D <0x82001000 0 0x10001000 0 0x1000>;
> +			reg =3D <0x001000 0 0 0 0>;
> +			status =3D "disabled";
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			ranges;
> +
> +			nvidia,num-lanes =3D <1>;
> +		};
> +
> +		pci@3,0 {
> +			device_type =3D "pci";
> +			assigned-addresses =3D <0x82001800 0 0x10004000 0 0x1000>;
> +			reg =3D <0x001800 0 0 0 0>;
> +			status =3D "disabled";
> +
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			ranges;
> +
> +			nvidia,num-lanes =3D <1>;
> +		};
> +	};
> +
> +Board DTS:
> +
> +	pcie@10003000 {
> +		status =3D "okay";
> +
> +		dvdd-pex-supply =3D <&vdd_pex>;
> +		hvdd-pex-pll-supply =3D <&vdd_1v8>;
> +		hvdd-pex-supply =3D <&vdd_1v8>;
> +		vddio-pexctl-aud-supply =3D <&vdd_1v8>;
> +
> +		pci@1,0 {
> +			nvidia,num-lanes =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		pci@2,0 {
> +			nvidia,num-lanes =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		pci@3,0 {
> +			nvidia,num-lanes =3D <1>;
> +			status =3D "disabled";
> +		};
> +	};
> --=20
> 2.1.4
>=20

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlng67QACgkQ3SOs138+
s6Em+A//aBq9fFyL/g/sWzR6PHzISGJ1s8F+gEgwcF5YqhQY11WOO9RV7azk7sDL
gDW4xBdnRZO+vtL3rH89n+Gdjbi4psdF5ZdePewU7yly3HEbG66sgzjSH3OaXT1y
47rKUxVR928TAFrJV6fg0HkiqUHVTSzj4Ig2QYLr9rdT5kkS2i4FuUSXeWWqNn4f
uh8r8ILm74/daDleLqg+yBuC7fMh3gKloTpcYeGP+Z5etVXJM8L1HL6ESxIw3i1v
Z2KbZ8rMxDPxayEtk2kNJ01b7LOix2uGhX4BhRNRHpvD1tk9qYoJW0fvciB8zOLE
+HhkjngdKdNR7qdfzv2CsSaJoBiIkPTliEShgz4XbzDPmZubp1p8bUjlwcpZ5G8v
ewPT5DZK+J177PpLCM3dAckl90/OFO6yy5q9EVLjZdSREqX51Eu/kT/Cd2Oob+TU
r5m154haql525qPsYBqmUUBy3R36fGoj0O8ATWkhNmljdToWSIc6xRAu9Vw9uhTi
krBre0Efe6D6NkhGF/jpsbsGo5Xfrb0qjddEtq3aXabCDtWXCq9Jok65WjNuyTgv
bC+DlrIK6ECGEJ3P55MUDVdte+YxLWUzyoLfIdKLukP928+oHnjkConExj3OeMWT
AsEuERdOkH3Icg12wPgj3A9GDUtJSC/FYwNxbAzCnIN8WR4bAng=
=MFpZ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

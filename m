Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053973E40F2;
	Thu, 10 Sep 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037935; cv=none; b=K9PzkPNxf/PHLbuRilL5mGRzI0pfj7Vr/CAE4tXT5t6PjJQMapuFGpjv2E2Ws8M5s9Fj47U+qr0VJ2sAEiSvMsUUq0JG0Fhay4QdVNhzLiA8vGbFKOQHGUtk/ChXDvcsligiORLGqdCpE9yyDeW1EkQ4T/jcC92c1R9ZU1bUcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037935; c=relaxed/simple;
	bh=+Ti9tM54BA3D+9JGhMXDHnTQtsuqF7P87r9bvedzbRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V26X2NdSyA46iC/3qNHQi0olsVnIvueg8ZPYOFyV0SUxtUR2Gy6KXLoi4o19G1E3lod2RFc+z9VrHLg7OPPpMdLDJ0Y5mJJIXpCN+37uCXckg9Fgxr902qyJPxohzJ/9Iz8x0xu+gJvT2ZuPpRjvsXZTsGPG9//p1ozL+47a4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu1+GRwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu1+GRwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0251F000FF;
	Thu, 10 Sep 2026 10:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037932;
	bh=i74zahWHzedu9uRKSqTrB/4t1R/+byoR14FR1mmkepw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lu1+GRwOiP8mAU+XT1ocpw8oxcnaGMySIOc5XP7NoCWAJQt9f5DuXRV1jbjIVnlWO
	 OVRa8G/bmEftUP17hnGdRQsdESHYX0npbqwoR7lZ/Ke9Pfv+V/Jr+8p89S4OABoqxw
	 EMMpgF1zsED60J/Qpiouj5XkpImLElp2ANWLjWG5Qy8oyBvptJHLe045BqpnATei4U
	 Vk3bIvFSi/xvEnoEdqQdjX5eacvwB8t9OBRAuCYzJtTHbu+u1dLAhRvmcYpP9zXQmy
	 jiUlPj6UMpa/jurF5BwYION08LtArLb/09cfLmQAfx45OHM/CHj1+JHGobkrFW9rMs
	 kJx3e0IFCYxcA==
Date: Thu, 10 Sep 2026 12:58:49 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
Message-ID: <aqKMNYMqyzzy0F-w@orome>
References: <20260902142449.735168-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4viqd2cvuabw52p"
Content-Disposition: inline
In-Reply-To: <20260902142449.735168-1-thierry.reding@kernel.org>


--m4viqd2cvuabw52p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
MIME-Version: 1.0

On Wed, Sep 02, 2026 at 04:24:49PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Convert the Tegra PCIe controller bindings from the free-form text
> format to json-schema.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v6:
> - add additional constraints for num-lanes and phys properties
> - reference pci-host-bridge.yaml and drop duplicate properties
> - reference pci-pci-bridge.yaml and drop duplicate properties
> - drop Tegra30, Tegra124 and Tegra186 examples
> - remove unneeded properties from examples
> - reduce number of ifs
>=20
> Changes in v5:
> - drop unneeded quotes
>=20
> Changes in v4:
> - remove path references
> - use dual licensing
>=20
> Changes in v3:
> - fixup reference in MAINTAINERS
>=20
> Changes in v2:
> - drop description properties where they don't add information
> - drop redundant $ref properties
>=20
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  .../bindings/pci/nvidia,tegra20-pcie.yaml     | 532 ++++++++++++++
>  2 files changed, 532 insertions(+), 670 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-=
pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-=
pcie.yaml

Hi Rob,

you had reviewed various versions of this in the past. I've adopted most
of the differences from Anand's patch which had stalled:

    https://lore.kernel.org/linux-tegra/20260224121948.25218-2-linux.amoon@=
gmail.com/

and I've addressed the remaining comments that you had on both versions
of the patches. The only thing I kept unaddressed was the set of ifs for
the supplies just because none of the alternatives were accurate enough,
in my opinion. And yes, maybe I am overly pedantic, but it also doesn't
strike me as too much now that any other conditionals are now gone.

Thierry

>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> deleted file mode 100644
> index d099f3476ccc..000000000000
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ /dev/null
> @@ -1,670 +0,0 @@
> -NVIDIA Tegra PCIe controller
> -
> -Required properties:
> -- compatible: Must be:
> -  - "nvidia,tegra20-pcie": for Tegra20
> -  - "nvidia,tegra30-pcie": for Tegra30
> -  - "nvidia,tegra124-pcie": for Tegra124 and Tegra132
> -  - "nvidia,tegra210-pcie": for Tegra210
> -  - "nvidia,tegra186-pcie": for Tegra186
> -- power-domains: To ungate power partition by BPMP powergate driver. Must
> -  contain BPMP phandle and PCIe power partition ID. This is required only
> -  for Tegra186.
> -- device_type: Must be "pci"
> -- reg: A list of physical base address and length for each set of contro=
ller
> -  registers. Must contain an entry for each entry in the reg-names prope=
rty.
> -- reg-names: Must include the following entries:
> -  "pads": PADS registers
> -  "afi": AFI registers
> -  "cs": configuration space region
> -- interrupts: A list of interrupt outputs of the controller. Must contai=
n an
> -  entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The Tegra interrupt that is asserted for controller interrupts
> -  "msi": The Tegra interrupt that is asserted when an MSI is received
> -- bus-range: Range of bus numbers associated with this controller
> -- #address-cells: Address representation for root ports (must be 3)
> -  - cell 0 specifies the bus and device numbers of the root port:
> -    [23:16]: bus number
> -    [15:11]: device number
> -  - cell 1 denotes the upper 32 address bits and should be 0
> -  - cell 2 contains the lower 32 address bits and is used to translate t=
o the
> -    CPU address space
> -- #size-cells: Size representation for root ports (must be 2)
> -- ranges: Describes the translation of addresses for root ports and stan=
dard
> -  PCI regions. The entries must be 6 cells each, where the first three c=
ells
> -  correspond to the address as described for the #address-cells property
> -  above, the fourth cell is the physical CPU address to translate to and=
 the
> -  fifth and six cells are as described for the #size-cells property abov=
e.
> -  - The first two entries are expected to translate the addresses for th=
e root
> -    port registers, which are referenced by the assigned-addresses prope=
rty of
> -    the root port nodes (see below).
> -  - The remaining entries setup the mapping for the standard I/O, memory=
 and
> -    prefetchable PCI regions. The first cell determines the type of regi=
on
> -    that is setup:
> -    - 0x81000000: I/O memory region
> -    - 0x82000000: non-prefetchable memory region
> -    - 0xc2000000: prefetchable memory region
> -  Please refer to the standard PCI bus binding document for a more detai=
led
> -  explanation.
> -- #interrupt-cells: Size representation for interrupts (must be 1)
> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping propert=
ies
> -  Please refer to the standard PCI bus binding document for a more detai=
led
> -  explanation.
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - pex
> -  - afi
> -  - pll_e
> -  - cml (not required for Tegra20)
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - pex
> -  - afi
> -  - pcie_x
> -
> -Optional properties:
> -- pinctrl-names: A list of pinctrl state names. Must contain the followi=
ng
> -  entries:
> -  - "default": active state, puts PCIe I/O out of deep power down state
> -  - "idle": puts PCIe I/O into deep power down state
> -- pinctrl-0: phandle for the default/active state of pin configurations.
> -- pinctrl-1: phandle for the idle state of pin configurations.
> -
> -Required properties on Tegra124 and later (deprecated):
> -- phys: Must contain an entry for each entry in phy-names.
> -- phy-names: Must include the following entries:
> -  - pcie
> -
> -These properties are deprecated in favour of per-lane PHYs define in eac=
h of
> -the root ports (see below).
> -
> -Power supplies for Tegra20:
> -- avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 =
V.
> -- vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> -- avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. M=
ust
> -  supply 1.05 V.
> -- avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Mu=
st
> -  supply 1.05 V.
> -- vddio-pex-clk-supply: Power supply for PCIe clock. Must supply 3.3 V.
> -
> -Power supplies for Tegra30:
> -- Required:
> -  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL.=
 Must
> -    supply 1.05 V.
> -  - avdd-plle-supply: Power supply for PLLE, which is shared with SATA. =
Must
> -    supply 1.05 V.
> -  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
> -    supply 1.8 V.
> -  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output cl=
ocks.
> -    Must supply 3.3 V.
> -- Optional:
> -  - If lanes 0 to 3 are used:
> -    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply =
1.05 V.
> -    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -  - If lanes 4 or 5 are used:
> -    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply =
1.05 V.
> -    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -
> -Power supplies for Tegra124:
> -- Required:
> -  - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
> -  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output cl=
ocks.
> -    Must supply 3.3 V.
> -  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
> -    supply 2.8-3.3 V.
> -
> -Power supplies for Tegra210:
> -- Required:
> -  - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
> -    clocks. Must supply 1.8 V.
> -  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
> -    supply 1.8 V.
> -
> -Power supplies for Tegra186:
> -- Required:
> -  - dvdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> -  - hvdd-pex-pll-supply: High-voltage supply for PLLE (shared with USB3)=
=2E Must
> -    supply 1.8 V.
> -  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output cl=
ocks.
> -    Must supply 1.8 V.
> -  - vddio-pexctl-aud-supply: Power supply for PCIe side band signals. Mu=
st
> -    supply 1.8 V.
> -
> -Root ports are defined as subnodes of the PCIe controller node.
> -
> -Required properties:
> -- device_type: Must be "pci"
> -- assigned-addresses: Address and size of the port configuration registe=
rs
> -- reg: PCI bus address of the root port
> -- #address-cells: Must be 3
> -- #size-cells: Must be 2
> -- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> -  property is sufficient.
> -- nvidia,num-lanes: Number of lanes to use for this port. Valid combinat=
ions
> -  are:
> -  - Root port 0 uses 4 lanes, root port 1 is unused.
> -  - Both root ports use 2 lanes.
> -
> -Required properties for Tegra124 and later:
> -- phys: Must contain an phandle to a PHY for each entry in phy-names.
> -- phy-names: Must include an entry for each active lane. Note that the n=
umber
> -  of entries does not have to (though usually will) be equal to the spec=
ified
> -  number of lanes in the nvidia,num-lanes property. Entries are of the f=
orm
> -  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-l=
anes.
> -
> -Examples:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Tegra20:
> ---------
> -
> -SoC DTSI:
> -
> -	pcie-controller@80003000 {
> -		compatible =3D "nvidia,tegra20-pcie";
> -		device_type =3D "pci";
> -		reg =3D <0x80003000 0x00000800   /* PADS registers */
> -		       0x80003800 0x00000200   /* AFI registers */
> -		       0x90000000 0x10000000>; /* configuration space */
> -		reg-names =3D "pads", "afi", "cs";
> -		interrupts =3D <0 98 0x04   /* controller interrupt */
> -		              0 99 0x04>; /* MSI interrupt */
> -		interrupt-names =3D "intr", "msi";
> -
> -		#interrupt-cells =3D <1>;
> -		interrupt-map-mask =3D <0 0 0 0>;
> -		interrupt-map =3D <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		bus-range =3D <0x00 0xff>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -
> -		ranges =3D <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port =
0 registers */
> -			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registe=
rs */
> -			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O=
 */
> -			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchab=
le memory */
> -			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable m=
emory */
> -
> -		clocks =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 118>;
> -		clock-names =3D "pex", "afi", "pll_e";
> -		resets =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>;
> -		reset-names =3D "pex", "afi", "pcie_x";
> -		status =3D "disabled";
> -
> -		pci@1,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82000800 0 0x80000000 0 0x1000>;
> -			reg =3D <0x000800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -
> -		pci@2,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001000 0 0x80001000 0 0x1000>;
> -			reg =3D <0x001000 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -	};
> -
> -Board DTS:
> -
> -	pcie-controller@80003000 {
> -		status =3D "okay";
> -
> -		vdd-supply =3D <&pci_vdd_reg>;
> -		pex-clk-supply =3D <&pci_clk_reg>;
> -
> -		/* root port 00:01.0 */
> -		pci@1,0 {
> -			status =3D "okay";
> -
> -			/* bridge 01:00.0 (optional) */
> -			pci@0,0 {
> -				reg =3D <0x010000 0 0 0 0>;
> -
> -				#address-cells =3D <3>;
> -				#size-cells =3D <2>;
> -
> -				device_type =3D "pci";
> -
> -				/* endpoint 02:00.0 */
> -				pci@0,0 {
> -					reg =3D <0x020000 0 0 0 0>;
> -				};
> -			};
> -		};
> -	};
> -
> -Note that devices on the PCI bus are dynamically discovered using PCI's =
bus
> -enumeration and therefore don't need corresponding device nodes in DT. H=
owever
> -if a device on the PCI bus provides a non-probeable bus such as I2C or S=
PI,
> -device nodes need to be added in order to allow the bus' children to be
> -instantiated at the proper location in the operating system's device tre=
e (as
> -illustrated by the optional nodes in the example above).
> -
> -Tegra30:
> ---------
> -
> -SoC DTSI:
> -
> -	pcie-controller@3000 {
> -		compatible =3D "nvidia,tegra30-pcie";
> -		device_type =3D "pci";
> -		reg =3D <0x00003000 0x00000800   /* PADS registers */
> -		       0x00003800 0x00000200   /* AFI registers */
> -		       0x10000000 0x10000000>; /* configuration space */
> -		reg-names =3D "pads", "afi", "cs";
> -		interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH   /* controller interru=
pt */
> -			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> -		interrupt-names =3D "intr", "msi";
> -
> -		#interrupt-cells =3D <1>;
> -		interrupt-map-mask =3D <0 0 0 0>;
> -		interrupt-map =3D <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		bus-range =3D <0x00 0xff>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -
> -		ranges =3D <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port =
0 configuration space */
> -			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configu=
ration space */
> -			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configu=
ration space */
> -			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O=
 */
> -			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchab=
le memory */
> -			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable m=
emory */
> -
> -		clocks =3D <&tegra_car TEGRA30_CLK_PCIE>,
> -			 <&tegra_car TEGRA30_CLK_AFI>,
> -			 <&tegra_car TEGRA30_CLK_PLL_E>,
> -			 <&tegra_car TEGRA30_CLK_CML0>;
> -		clock-names =3D "pex", "afi", "pll_e", "cml";
> -		resets =3D <&tegra_car 70>,
> -			 <&tegra_car 72>,
> -			 <&tegra_car 74>;
> -		reset-names =3D "pex", "afi", "pcie_x";
> -		status =3D "disabled";
> -
> -		pci@1,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82000800 0 0x00000000 0 0x1000>;
> -			reg =3D <0x000800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -
> -		pci@2,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001000 0 0x00001000 0 0x1000>;
> -			reg =3D <0x001000 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -
> -		pci@3,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001800 0 0x00004000 0 0x1000>;
> -			reg =3D <0x001800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -	};
> -
> -Board DTS:
> -
> -	pcie-controller@3000 {
> -		status =3D "okay";
> -
> -		avdd-pexa-supply =3D <&ldo1_reg>;
> -		vdd-pexa-supply =3D <&ldo1_reg>;
> -		avdd-pexb-supply =3D <&ldo1_reg>;
> -		vdd-pexb-supply =3D <&ldo1_reg>;
> -		avdd-pex-pll-supply =3D <&ldo1_reg>;
> -		avdd-plle-supply =3D <&ldo1_reg>;
> -		vddio-pex-ctl-supply =3D <&sys_3v3_reg>;
> -		hvdd-pex-supply =3D <&sys_3v3_pexs_reg>;
> -
> -		pci@1,0 {
> -			status =3D "okay";
> -		};
> -
> -		pci@3,0 {
> -			status =3D "okay";
> -		};
> -	};
> -
> -Tegra124:
> ----------
> -
> -SoC DTSI:
> -
> -	pcie-controller@1003000 {
> -		compatible =3D "nvidia,tegra124-pcie";
> -		device_type =3D "pci";
> -		reg =3D <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
> -		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
> -		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
> -		reg-names =3D "pads", "afi", "cs";
> -		interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interru=
pt */
> -			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> -		interrupt-names =3D "intr", "msi";
> -
> -		#interrupt-cells =3D <1>;
> -		interrupt-map-mask =3D <0 0 0 0>;
> -		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		bus-range =3D <0x00 0xff>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -
> -		ranges =3D <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* p=
ort 0 configuration space */
> -			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 con=
figuration space */
> -			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream=
 I/O (64 KiB) */
> -			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefet=
chable memory (208 MiB) */
> -			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchab=
le memory (512 MiB) */
> -
> -		clocks =3D <&tegra_car TEGRA124_CLK_PCIE>,
> -			 <&tegra_car TEGRA124_CLK_AFI>,
> -			 <&tegra_car TEGRA124_CLK_PLL_E>,
> -			 <&tegra_car TEGRA124_CLK_CML0>;
> -		clock-names =3D "pex", "afi", "pll_e", "cml";
> -		resets =3D <&tegra_car 70>,
> -			 <&tegra_car 72>,
> -			 <&tegra_car 74>;
> -		reset-names =3D "pex", "afi", "pcie_x";
> -		status =3D "disabled";
> -
> -		pci@1,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82000800 0 0x01000000 0 0x1000>;
> -			reg =3D <0x000800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -
> -		pci@2,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001000 0 0x01001000 0 0x1000>;
> -			reg =3D <0x001000 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <1>;
> -		};
> -	};
> -
> -Board DTS:
> -
> -	pcie-controller@1003000 {
> -		status =3D "okay";
> -
> -		avddio-pex-supply =3D <&vdd_1v05_run>;
> -		dvddio-pex-supply =3D <&vdd_1v05_run>;
> -		avdd-pex-pll-supply =3D <&vdd_1v05_run>;
> -		hvdd-pex-supply =3D <&vdd_3v3_lp0>;
> -		hvdd-pex-pll-e-supply =3D <&vdd_3v3_lp0>;
> -		vddio-pex-ctl-supply =3D <&vdd_3v3_lp0>;
> -		avdd-pll-erefe-supply =3D <&avdd_1v05_run>;
> -
> -		/* Mini PCIe */
> -		pci@1,0 {
> -			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> -			phy-names =3D "pcie-0";
> -			status =3D "okay";
> -		};
> -
> -		/* Gigabit Ethernet */
> -		pci@2,0 {
> -			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
> -			phy-names =3D "pcie-0";
> -			status =3D "okay";
> -		};
> -	};
> -
> -Tegra210:
> ----------
> -
> -SoC DTSI:
> -
> -	pcie-controller@1003000 {
> -		compatible =3D "nvidia,tegra210-pcie";
> -		device_type =3D "pci";
> -		reg =3D <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
> -		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
> -		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
> -		reg-names =3D "pads", "afi", "cs";
> -		interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interru=
pt */
> -			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> -		interrupt-names =3D "intr", "msi";
> -
> -		#interrupt-cells =3D <1>;
> -		interrupt-map-mask =3D <0 0 0 0>;
> -		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		bus-range =3D <0x00 0xff>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -
> -		ranges =3D <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* p=
ort 0 configuration space */
> -			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 con=
figuration space */
> -			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream=
 I/O (64 KiB) */
> -			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefet=
chable memory (208 MiB) */
> -			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchab=
le memory (512 MiB) */
> -
> -		clocks =3D <&tegra_car TEGRA210_CLK_PCIE>,
> -			 <&tegra_car TEGRA210_CLK_AFI>,
> -			 <&tegra_car TEGRA210_CLK_PLL_E>,
> -			 <&tegra_car TEGRA210_CLK_CML0>;
> -		clock-names =3D "pex", "afi", "pll_e", "cml";
> -		resets =3D <&tegra_car 70>,
> -			 <&tegra_car 72>,
> -			 <&tegra_car 74>;
> -		reset-names =3D "pex", "afi", "pcie_x";
> -		status =3D "disabled";
> -
> -		pci@1,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82000800 0 0x01000000 0 0x1000>;
> -			reg =3D <0x000800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <4>;
> -		};
> -
> -		pci@2,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001000 0 0x01001000 0 0x1000>;
> -			reg =3D <0x001000 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <1>;
> -		};
> -	};
> -
> -Board DTS:
> -
> -	pcie-controller@1003000 {
> -		status =3D "okay";
> -
> -		avdd-pll-uerefe-supply =3D <&avdd_1v05_pll>;
> -		hvddio-pex-supply =3D <&vdd_1v8>;
> -		dvddio-pex-supply =3D <&vdd_pex_1v05>;
> -		dvdd-pex-pll-supply =3D <&vdd_pex_1v05>;
> -		hvdd-pex-pll-e-supply =3D <&vdd_1v8>;
> -		vddio-pex-ctl-supply =3D <&vdd_1v8>;
> -
> -		pci@1,0 {
> -			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
> -			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
> -			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
> -			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
> -			phy-names =3D "pcie-0", "pcie-1", "pcie-2", "pcie-3";
> -			status =3D "okay";
> -		};
> -
> -		pci@2,0 {
> -			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> -			phy-names =3D "pcie-0";
> -			status =3D "okay";
> -		};
> -	};
> -
> -Tegra186:
> ----------
> -
> -SoC DTSI:
> -
> -	pcie@10003000 {
> -		compatible =3D "nvidia,tegra186-pcie";
> -		power-domains =3D <&bpmp TEGRA186_POWER_DOMAIN_PCX>;
> -		device_type =3D "pci";
> -		reg =3D <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
> -		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
> -		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
> -		reg-names =3D "pads", "afi", "cs";
> -
> -		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interru=
pt */
> -			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> -		interrupt-names =3D "intr", "msi";
> -
> -		#interrupt-cells =3D <1>;
> -		interrupt-map-mask =3D <0 0 0 0>;
> -		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		bus-range =3D <0x00 0xff>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -
> -		ranges =3D <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* p=
ort 0 configuration space */
> -			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 con=
figuration space */
> -			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 con=
figuration space */
> -			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream=
 I/O (64 KiB) */
> -			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefet=
chable memory (127 MiB) */
> -			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchab=
le memory (640 MiB) */
> -
> -		clocks =3D <&bpmp TEGRA186_CLK_AFI>,
> -			 <&bpmp TEGRA186_CLK_PCIE>,
> -			 <&bpmp TEGRA186_CLK_PLLE>;
> -		clock-names =3D "afi", "pex", "pll_e";
> -
> -		resets =3D <&bpmp TEGRA186_RESET_AFI>,
> -			 <&bpmp TEGRA186_RESET_PCIE>,
> -			 <&bpmp TEGRA186_RESET_PCIEXCLK>;
> -		reset-names =3D "afi", "pex", "pcie_x";
> -
> -		status =3D "disabled";
> -
> -		pci@1,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82000800 0 0x10000000 0 0x1000>;
> -			reg =3D <0x000800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <2>;
> -		};
> -
> -		pci@2,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001000 0 0x10001000 0 0x1000>;
> -			reg =3D <0x001000 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <1>;
> -		};
> -
> -		pci@3,0 {
> -			device_type =3D "pci";
> -			assigned-addresses =3D <0x82001800 0 0x10004000 0 0x1000>;
> -			reg =3D <0x001800 0 0 0 0>;
> -			status =3D "disabled";
> -
> -			#address-cells =3D <3>;
> -			#size-cells =3D <2>;
> -			ranges;
> -
> -			nvidia,num-lanes =3D <1>;
> -		};
> -	};
> -
> -Board DTS:
> -
> -	pcie@10003000 {
> -		status =3D "okay";
> -
> -		dvdd-pex-supply =3D <&vdd_pex>;
> -		hvdd-pex-pll-supply =3D <&vdd_1v8>;
> -		hvdd-pex-supply =3D <&vdd_1v8>;
> -		vddio-pexctl-aud-supply =3D <&vdd_1v8>;
> -
> -		pci@1,0 {
> -			nvidia,num-lanes =3D <4>;
> -			status =3D "okay";
> -		};
> -
> -		pci@2,0 {
> -			nvidia,num-lanes =3D <0>;
> -			status =3D "disabled";
> -		};
> -
> -		pci@3,0 {
> -			nvidia,num-lanes =3D <1>;
> -			status =3D "disabled";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml
> new file mode 100644
> index 000000000000..fcc7875e6853
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml
> @@ -0,0 +1,532 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra20-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PCIe controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra20-pcie
> +          - nvidia,tegra30-pcie
> +          - nvidia,tegra124-pcie
> +          - nvidia,tegra210-pcie
> +          - nvidia,tegra186-pcie
> +
> +      - items:
> +          - const: nvidia,tegra132-pcie
> +          - const: nvidia,tegra124-pcie
> +
> +  reg:
> +    items:
> +      - description: PADS registers
> +      - description: AFI registers
> +      - description: configuration space region
> +
> +  reg-names:
> +    items:
> +      - const: pads
> +      - const: afi
> +      - const: cs
> +
> +  interrupts:
> +    items:
> +      - description: PCIe controller interrupt
> +      - description: MSI controller interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: msi
> +
> +  clocks:
> +    items:
> +      - description: PCI controller clock
> +      - description: AFI interface clock
> +      - description: reference PLL clock
> +      - description: CML clock
> +    minItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pll_e
> +      - const: cml
> +    minItems: 3
> +
> +  resets:
> +    items:
> +      - description: AFI interface reset
> +      - description: PCI controller reset
> +      - description: PCI bus reset
> +
> +  reset-names:
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pcie_x
> +
> +  interconnects:
> +    items:
> +      - description: AFI memory read client
> +      - description: AFI memory write client
> +
> +  interconnect-names:
> +    items:
> +      - const: dma-mem # read
> +      - const: write
> +
> +  iommus:
> +    maxItems: 1
> +
> +  operating-points-v2:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  power-domains:
> +    items:
> +      - description: phandle to the core power domain
> +
> +  pinctrl-names:
> +    items:
> +        # active state, puts PCIe I/O out of deep power down state
> +      - const: default
> +        # puts PCIe I/O into deep power down state
> +      - const: idle
> +
> +patternProperties:
> +  "^pci@1?[0-9a-f](,[0-7])?$":
> +    description: Root ports are defined as subnodes of the PCIe controll=
er
> +      node.
> +
> +      Note that devices on the PCI bus are dynamically discovered using =
PCI's
> +      bus enumeration and therefore don't need corresponding device node=
s in
> +      DT. However if a device on the PCI bus provides a non-probeable bu=
s such
> +      as I2C or SPI, device nodes need to be added in order to allow the=
 bus'
> +      children to be instantiated at the proper location in the operating
> +      system's device tree (as illustrated by the optional nodes in the
> +      examples below).
> +
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      nvidia,num-lanes:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Number of lanes to use for this port. Valid combinations
> +          are:
> +
> +          - Root port 0 uses 4 lanes, root port 1 is unused.
> +          - Both root ports use 2 lanes.
> +        enum: [ 0, 1, 2, 4 ]
> +
> +      phys:
> +        description: Must contain an phandle to a PHY for each entry in
> +          phy-names.
> +        minItems: 1
> +        maxItems: 4
> +
> +      phy-names:
> +        description: Must include an entry for each active lane. Note th=
at the
> +          number of entries does not have to (though usually will) be eq=
ual to
> +          the specified number of lanes in the nvidia,num-lanes property.
> +          Entries are of the form "pcie-N", where N ranges from 0 to the=
 value
> +          specified in nvidia,num-lanes.
> +        items:
> +          enum:
> +            - pcie-0
> +            - pcie-1
> +            - pcie-2
> +            - pcie-3
> +        minItems: 1
> +        maxItems: 4
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/pinctrl-consumer.yaml#
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: pci-iommu.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra20-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +
> +        clock-names:
> +          maxItems: 3
> +
> +        avdd-pex-supply:
> +          description: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
> +
> +        vdd-pex-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +
> +        avdd-pex-pll-supply:
> +          description: Power supply for dedicated (internal) PCIe PLL. M=
ust
> +            supply 1.05 V.
> +
> +        avdd-plle-supply:
> +          description: Power supply for PLLE, which is shared with SATA.=
 Must
> +            supply 1.05 V.
> +
> +        vddio-pex-clk-supply:
> +          description: Power supply for PCIe clock. Must supply 3.3 V.
> +
> +      required:
> +        - avdd-pex-supply
> +        - vdd-pex-supply
> +        - avdd-pex-pll-supply
> +        - avdd-plle-supply
> +        - vddio-pex-clk-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra30-pcie
> +    then:
> +      properties:
> +        avdd-pex-pll-supply:
> +          description: Power supply for dedicated (internal) PCIe PLL. M=
ust
> +            supply 1.05 V.
> +
> +        avdd-plle-supply:
> +          description: Power supply for PLLE, which is shared with SATA.=
 Must
> +            supply 1.05 V.
> +
> +        vddio-pex-ctl-supply:
> +          description: Power supply for PCIe control I/O partition. Must
> +            supply 1.8 V.
> +
> +        hvdd-pex-supply:
> +          description: High-voltage supply for PCIe I/O and PCIe output
> +            clocks. Must supply 3.3 V.
> +
> +        avdd-pexa-supply:
> +          description: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
> +            Required if lanes 0 through 3 are used.
> +
> +        vdd-pexa-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +            Required if lanes 0 through 3 are used.
> +
> +        avdd-pexb-supply:
> +          description: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
> +            Required if lanes 4 and 5 are used.
> +
> +        vdd-pexb-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +            Required if lanes 4 and 5 are used.
> +
> +      required:
> +        - avdd-pex-pll-supply
> +        - avdd-plle-supply
> +        - vddio-pex-ctl-supply
> +        - hvdd-pex-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra124-pcie
> +    then:
> +      properties:
> +        phys:
> +          minItems: 1
> +          maxItems: 1
> +          deprecated: true
> +
> +        phy-names:
> +          items:
> +            - const: pcie
> +          deprecated: true
> +
> +        avddio-pex-supply:
> +          description: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
> +
> +        dvddio-pex-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +
> +        hvdd-pex-supply:
> +          description: High-voltage supply for PCIe I/O and PCIe output
> +            clocks. Must supply 3.3 V.
> +
> +        vddio-pex-ctl-supply:
> +          description: Power supply for PCIe control I/O partition. Must
> +            supply 2.8-3.3 V.
> +
> +        avdd-pex-pll-supply:
> +          deprecated: true
> +
> +        hvdd-pex-pll-e-supply:
> +          deprecated: true
> +
> +        avdd-pll-erefe-supply:
> +          deprecated: true
> +
> +      required:
> +        - avddio-pex-supply
> +        - dvddio-pex-supply
> +        - hvdd-pex-supply
> +        - vddio-pex-ctl-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra210-pcie
> +    then:
> +      properties:
> +        hvddio-pex-supply:
> +          description: High-voltage supply for PCIe I/O and PCIe output
> +            clocks. Must supply 1.8 V.
> +
> +        dvddio-pex-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +
> +        vddio-pex-ctl-supply:
> +          description: Power supply for PCIe control I/O partition. Must
> +            supply 1.8 V.
> +
> +        avdd-pll-uerefe-supply:
> +          deprecated: true
> +
> +        dvdd-pex-pll-supply:
> +          deprecated: true
> +
> +        hvdd-pex-pll-e-supply:
> +          deprecated: true
> +
> +      required:
> +        - hvddio-pex-supply
> +        - dvddio-pex-supply
> +        - vddio-pex-ctl-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +
> +        clock-names:
> +          maxItems: 3
> +
> +        power-domains:
> +          description: To ungate power partition by BPMP powergate drive=
r.
> +            Must contain BPMP phandle and PCIe power partition ID.
> +
> +        dvdd-pex-supply:
> +          description: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> +
> +        hvdd-pex-pll-supply:
> +          description: High-voltage supply for PLLE (shared with USB3). =
Must
> +            supply 1.8 V.
> +
> +        hvdd-pex-supply:
> +          description: High-voltage supply for PCIe I/O and PCIe output
> +            clocks. Must supply 1.8 V.
> +
> +        vddio-pexctl-aud-supply:
> +          description: Power supply for PCIe side band signals. Must sup=
ply
> +            1.8 V.
> +
> +      required:
> +        - dvdd-pex-supply
> +        - hvdd-pex-pll-supply
> +        - hvdd-pex-supply
> +        - vddio-pexctl-aud-supply
> +
> +examples:
> +  # Tegra20
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pcie@80003000 {
> +        compatible =3D "nvidia,tegra20-pcie";
> +        device_type =3D "pci";
> +        reg =3D <0x80003000 0x00000800>, /* PADS registers */
> +              <0x80003800 0x00000200>, /* AFI registers */
> +              <0x90000000 0x10000000>; /* configuration space */
> +        reg-names =3D "pads", "afi", "cs";
> +        interrupts =3D <0 98 0x04>, /* controller interrupt */
> +                     <0 99 0x04>; /* MSI interrupt */
> +        interrupt-names =3D "intr", "msi";
> +
> +        #interrupt-cells =3D <1>;
> +        interrupt-map-mask =3D <0 0 0 0>;
> +        interrupt-map =3D <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        bus-range =3D <0x00 0xff>;
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +
> +        ranges =3D <0x02000000 0 0x80000000 0x80000000 0 0x00001000>, /*=
 port 0 registers */
> +                 <0x02000000 0 0x80001000 0x80001000 0 0x00001000>, /* p=
ort 1 registers */
> +                 <0x01000000 0 0          0x82000000 0 0x00010000>, /* d=
ownstream I/O */
> +                 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>, /* n=
on-prefetchable memory */
> +                 <0x42000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* p=
refetchable memory */
> +
> +        clocks =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 118>;
> +        clock-names =3D "pex", "afi", "pll_e";
> +        resets =3D <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>;
> +        reset-names =3D "pex", "afi", "pcie_x";
> +
> +        avdd-pex-supply =3D <&pci_vdd_reg>;
> +        vdd-pex-supply =3D <&pci_vdd_reg>;
> +        avdd-pex-pll-supply =3D <&pci_vdd_reg>;
> +        avdd-plle-supply =3D <&pci_vdd_reg>;
> +        vddio-pex-clk-supply =3D <&pci_clk_reg>;
> +
> +        /* root port 00:01.0 */
> +        pci@1,0 {
> +            device_type =3D "pci";
> +            assigned-addresses =3D <0x82000800 0 0x80000000 0 0x1000>;
> +            reg =3D <0x000800 0 0 0 0>;
> +            bus-range =3D <0x00 0xff>;
> +
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +
> +            ranges;
> +
> +            nvidia,num-lanes =3D <2>;
> +
> +            /* bridge 01:00.0 (optional) */
> +            pci@0,0 {
> +                reg =3D <0x010000 0 0 0 0>;
> +                bus-range =3D <0x00 0xff>;
> +
> +                #address-cells =3D <3>;
> +                #size-cells =3D <2>;
> +                ranges;
> +
> +                device_type =3D "pci";
> +
> +                /* endpoint 02:00.0 */
> +                ethernet@0,0 {
> +                    reg =3D <0x020000 0 0 0 0>;
> +                };
> +            };
> +        };
> +
> +        pci@2,0 {
> +            device_type =3D "pci";
> +            assigned-addresses =3D <0x82001000 0 0x80001000 0 0x1000>;
> +            reg =3D <0x001000 0 0 0 0>;
> +            bus-range =3D <0x00 0xff>;
> +
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +
> +            ranges;
> +
> +            nvidia,num-lanes =3D <2>;
> +        };
> +    };
> +
> +  # Tegra210
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pcie@1003000 {
> +        compatible =3D "nvidia,tegra210-pcie";
> +        device_type =3D "pci";
> +        reg =3D <0x01003000 0x00000800>, /* PADS registers */
> +              <0x01003800 0x00000800>, /* AFI registers */
> +              <0x02000000 0x10000000>; /* configuration space */
> +        reg-names =3D "pads", "afi", "cs";
> +        interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller i=
nterrupt */
> +                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt =
*/
> +        interrupt-names =3D "intr", "msi";
> +
> +        #interrupt-cells =3D <1>;
> +        interrupt-map-mask =3D <0 0 0 0>;
> +        interrupt-map =3D <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        bus-range =3D <0x00 0xff>;
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +
> +        ranges =3D <0x02000000 0 0x01000000 0x01000000 0 0x00001000>, /*=
 port 0 configuration space */
> +                 <0x02000000 0 0x01001000 0x01001000 0 0x00001000>, /* p=
ort 1 configuration space */
> +                 <0x01000000 0 0x0        0x12000000 0 0x00010000>, /* d=
ownstream I/O (64 KiB) */
> +                 <0x02000000 0 0x13000000 0x13000000 0 0x0d000000>, /* n=
on-prefetchable memory (208 MiB) */
> +                 <0x42000000 0 0x20000000 0x20000000 0 0x20000000>; /* p=
refetchable memory (512 MiB) */
> +
> +        clocks =3D <&tegra_car TEGRA210_CLK_PCIE>,
> +                 <&tegra_car TEGRA210_CLK_AFI>,
> +                 <&tegra_car TEGRA210_CLK_PLL_E>,
> +                 <&tegra_car TEGRA210_CLK_CML0>;
> +        clock-names =3D "pex", "afi", "pll_e", "cml";
> +        resets =3D <&tegra_car 70>,
> +                 <&tegra_car 72>,
> +                 <&tegra_car 74>;
> +        reset-names =3D "pex", "afi", "pcie_x";
> +
> +        avdd-pll-uerefe-supply =3D <&avdd_1v05_pll>;
> +        hvddio-pex-supply =3D <&vdd_1v8>;
> +        dvddio-pex-supply =3D <&vdd_pex_1v05>;
> +        dvdd-pex-pll-supply =3D <&vdd_pex_1v05>;
> +        hvdd-pex-pll-e-supply =3D <&vdd_1v8>;
> +        vddio-pex-ctl-supply =3D <&vdd_1v8>;
> +
> +        pci@1,0 {
> +            device_type =3D "pci";
> +            assigned-addresses =3D <0x82000800 0 0x01000000 0 0x1000>;
> +            reg =3D <0x000800 0 0 0 0>;
> +            bus-range =3D <0x00 0xff>;
> +
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            ranges;
> +
> +            nvidia,num-lanes =3D <4>;
> +
> +            phys =3D <&phy_pcie0>, <&phy_pcie1>, <&phy_pcie2>, <&phy_pci=
e3>;
> +            phy-names =3D "pcie-0", "pcie-1", "pcie-2", "pcie-3";
> +        };
> +
> +        pci@2,0 {
> +            device_type =3D "pci";
> +            assigned-addresses =3D <0x82001000 0 0x01001000 0 0x1000>;
> +            reg =3D <0x001000 0 0 0 0>;
> +            bus-range =3D <0x00 0xff>;
> +
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            ranges;
> +
> +            nvidia,num-lanes =3D <1>;
> +
> +            phys =3D <&phy_pcie4>;
> +            phy-names =3D "pcie-0";
> +        };
> +    };
> --=20
> 2.55.0
>=20

--m4viqd2cvuabw52p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqijWkACgkQ3SOs138+
s6EkOhAAg8WwQYSoDIOUwRaHzh0aYr1V+S3UZnzNQjYJ2XAV3UIFtLxhtr0rbtVd
wl00Pwm//9ZDW3b1VHySGkD7pNbLZvbZLa2q1azBwZeyMhTxHCFiKzy6rBAtdgwn
UcPzWLZxbhn+cYHqQSFOlYsAv3aLw1iCQ8t2NFxu6H6AszaAa3do8iL1lrvbjwqj
HuJ+WE7t21/QDSczhKCMEviMWJ6RaMBNCUL4Ef7zKnseML8DCp6WTpzWlPSTxE7Y
2zeE8vyyOlfdv2jlipLZ0mKwIvArcJ4kirJJNcNjUftPIsI92QzZPcjA/H/amXUM
/brG0prt33p2PsjUbxcXYm2vVfzxE9u0ozWw+g6fhr384GeW1EG+/O/9rs4knVKF
4NyNKE2n80DTnp0d/tW8YvVibqrzQB9fOVQCEWa/YHPd4qm05CzE4fKEeeTy0Trt
sCa98GgKpi0QvOCNi+isqZ8paQPZFr5gCXS93J72cH8Kt4XZ+SsQP8JCv5qTgGIi
SHP/SCsZjHJZs95XupqlVF5fdiQxlzOFhhrVHjtUknQitIGHqQZMm96VtZBsIYqK
slzI+jgVarQ2SeKxnUAYRnu24IYskk4li5fXQmg91xIhCXhzgYk7PcnhM957M9DL
zB8VbIYTzIgGklxuipcPFw5E+hxK3mt2+jeJPy3J9TlxpVs1a3c=
=De39
-----END PGP SIGNATURE-----

--m4viqd2cvuabw52p--

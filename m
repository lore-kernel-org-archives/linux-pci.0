Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2442CAEE;
	Tue, 21 Jul 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627222; cv=none; b=raK9p+pbzsyi5XnKPBpsTqMs1rdjpICN2sC1YbGkG8ENeXXeQJaXir298Ko9w+B9Pn4yFjclDjfLBh9BQ58aZEBH4+WAwUzml5Tm12v8TWw1RqvbrhDfUAOwGnw06js/gzz6787P4oESmLZKEMKj+lrfYlSBLyv2BnOxLxdY1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627222; c=relaxed/simple;
	bh=b6KeCr6JYxT3cA/0/gA0HXJmrhjVpLJmkgIOS3eAbg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tBBfBHaUmEfCbvyaj75uskdEkdV9Z0X7kE4qqOJFGlVKD69cZx9CrtrdPWDxLJbmPynnEzIAd0RNu3B1xDyRjHroy6bcMrw/u5oAmh3/cFlWFU0PkR8pLHrSVAxDtwlaJA+PKuFzSEWJIIZM/Kw2JN23N3QSoUzBUaNAi2qH3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CShO6xjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CShO6xjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FB11F000E9;
	Tue, 21 Jul 2026 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627219;
	bh=pfYEtN4DM3I5IFoTw7wMjioKegbcSGpo4cgs+bKRgho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CShO6xjxpPtKYHBzmEbCGO9WctAA5XnEFxnZDpH4QGDEwuh5ym0Vc3NnIlLZOHHAT
	 OLCEQcqbHyCNQsnmDeTaA6K25IPbSTsJ3QCVxWJ42sb4D92uisKF90FjscG8S7fp01
	 sd4ghIEWzD0EOgey1VPsahhj5Hx39I8cjX/UTSDe6OEJjWkWZ9x12YNPIFkdc/t/Xi
	 11GAp3H2acQxHG4YKURKJr1E338VWOHifiN4MtPy5n0vwLMcAEqHywaO+W12mErs23
	 ozZ2F37jZymoWEhxA1NKABGNXahVJm7ctoN78hrOWGQx9uABmj34KIYtNCx9gj30Z6
	 HbmzWn3wM3HSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721-eliza_evk-v3-3-92b10038f13d@oss.qualcomm.com>
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-3-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:46:58 +0000
Message-Id: <20260721094659.50FB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The downstream PCI-to-PCI bridge nodes specify overlapping and i=
nvalid bus-range properties.
- [Low] Missing `compatible =3D "pciclass,0604"` in the downstream PCI brid=
ge nodes.

Pre-existing issues:
- [High] The addition of two child nodes (`pci@0,0` and `pci@0,1`) under th=
e DSP3 port (`pcie@3,0`) triggers a deterministic out-of-bounds array acces=
s in the existing `pci-pwrctrl-tc9563` driver, leading to memory corruption=
 and a kernel panic during probe.
--

--- Patch [3]: [PATCH v3 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with T=
C9563 PCIe switch ---
commit 3a7dcae4b740553fda1daf6d1b08f87c99ab83eb
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

This patch adds the TC9563 PCIe switch to the Eliza EVK device tree on PCIe=
1.
It sets up the I2C management interface, overrides the base iommu-map, and
configures the reset GPIO.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index 6d76715ccffbe..fb44e7a349a5d 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi

[ ... ]

> @@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
>  	};
>  };
> =20

[ ... ]

> +&pcie1port0 {
> +	wake-gpios =3D <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	/* Same GPIO is used for both PERST# and resx-gpio */
> +
> +	tc9563: pcie@0,0 {
> +		compatible =3D "pci1179,0623";
> +		reg =3D <0x10000 0x0 0x0 0x0 0x0>;

[ ... ]

> +		resx-gpios =3D <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
> +		pcie@1,0 {
> +			reg =3D <0x20800 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +

[Severity: Low]
Should these downstream PCI bridge nodes include the
compatible =3D "pciclass,0604" string? The same patch adds it to the upstre=
am
port pcie1port0 to satisfy schema validation checks.

> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x3 0xff>;

[Severity: Medium]
Do these sibling PCI-to-PCI bridge nodes specify overlapping bus-range
properties? Since they are sibling bridges, they cannot route overlapping
downstream bus ranges, but they all specify 0xff as the subordinate bus.

> +		};
> +
> +		pcie@2,0 {
> +			reg =3D <0x21000 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +
> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x4 0xff>;
> +		};
> +
> +		pcie@3,0 {
> +			reg =3D <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x5 0xff>;
> +
> +			pci@0,0 {
> +				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};
> +
> +			pci@0,1 {

[Severity: High]
This is a pre-existing issue, but does adding these two child nodes under t=
he
DSP3 port trigger an out-of-bounds access in the pci-pwrctrl-tc9563 driver?

Looking at drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c in tc9563_pwrctrl_probe=
(),
the driver iterates over the child nodes:

	for_each_child_of_node_scoped(child, child1) {
		port++;
		ret =3D tc9563_pwrctrl_parse_device_dt(tc9563,
						child1, port);

Without checking bounds against the array size TC9563_MAX (5), will this
increment port to 5 and access tc9563->cfg[5] out of bounds, overwriting
adjacent structure members and causing a kernel panic during probe?

> +				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};
> +		};
> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-eliza_evk-=
v3-0-92b10038f13d@oss.qualcomm.com?part=3D3

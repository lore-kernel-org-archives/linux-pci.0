Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C323B0582;
	Wed, 29 Jul 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337752; cv=none; b=TgFLMJhY8SSfu+jEszYCZhZfyKGL2x33mjrnUlwIkFRXQ9DT4VOUnBxsNX1bbMxFHZCZpQauwvt3lj0G4UStZjNAQ1vsEWt5L37NsrwNRo+KDifPNevjBI8XlUPg5InxrRplkMC7phvBdJP0PBRUjvsYST36tnkOL7zLdGLHYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337752; c=relaxed/simple;
	bh=1D4Jjwzilh5V99PhHoqJ/aMxcNXg26tplMkn+i1tK/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOYKlOao41ldFql6o+4vXlIVJN29afoIcUr7tg3g2RYLdtFLoTyq99uW0os1fcduLsGefwTI5kY2vadYheDvb22uwV3qmtyZQ/UGTuBZ038EZuOMffDe7VwY7LWAa4zsqUP4jFnGkVMKZW9skpc5/F2/0moaAGFsoj12T7EecHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhn6zbCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhn6zbCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2171F000E9;
	Wed, 29 Jul 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337750;
	bh=dTV5j0f6lQZI4ig+KovwA7HlOqNWPGLNsS5nLPWGBaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fhn6zbCHamLB6dMYYehnhByZzt4ebB/xojjajgafkAMGbwfA2w4RN11Wyx1YtvaUO
	 /AeutSt7M620GT832LjJehNtdapPxIfLko8ln+0a9RQVa4/B9ko9nUYVxLLGU2yQ1b
	 12u+PUV3v4qwT/qDpD64Wy6XSOO7957RSpaE4HX3sjqzyH1zcZv0YiXBxJCJrun2Bw
	 Ph3sj7o9LU2/+dCgUNOc6xg1VXrJQ4qLAYCYtYXHoJuJTPtguEdjjvl4IONQ7EGRAb
	 uFYyPpessp/WLnzrBnGNnE0jhpOt51RRz/90OxTJ+SIVl4Is289eDT41hbg3slxirV
	 2dO7hmJ8ubnzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:09:09 +0000
Message-Id: <20260729150910.2B2171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Buffer overflow in the `pwrctrl-tc9563` driver triggered by th=
e addition of the `pcie@0,1` node.
- [Medium] The Ethernet endpoint nodes `pcie@0,0` and `pcie@0,1` under down=
stream port `pcie@3,0` incorrectly specify PCI bridge properties.
- [Low] Misleading comment regarding shared GPIO pins.
--

--- Patch [3]: [PATCH v5 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with T=
C9563 PCIe switch ---
commit afe372355fdb42a2ae6e1af16238819812ac2af7
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
PCIe switch. Enable PCIe1 and its QMP PHY nodes.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index b35fffb509765..419e737c54e6f 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
[ ... ]
> @@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
>  	};
>  };
> =20
[ ... ]
> +&pcie1_port0 {
> +	wake-gpios =3D <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	/* Same GPIO is used for both PERST# and resx-gpio */

[Severity: Low]
This isn't a bug, but this comment states that the same GPIO is used for bo=
th
PERST# and resx-gpio, however resx-gpios is assigned to GPIO 54 below.

Should this comment be updated or moved?

> +
> +	tc9563: pcie@0,0 {
> +		compatible =3D "pci1179,0623";
[ ... ]
> +		resx-gpios =3D <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
[ ... ]
> +		pcie@3,0 {
> +			reg =3D <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x5 0xff>;
> +
> +			pcie@0,0 {
> +				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};

[Severity: Medium]
Do these integrated Ethernet MAC endpoints incorrectly specify PCI bridge
properties?

The OF framework may parse device_type =3D "pci", ranges, #address-cells, a=
nd
#size-cells on endpoint nodes during boot, which can cause the PCI core to
misidentify them as PCI-to-PCI bridges.

> +
> +			pcie@0,1 {
> +				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};

[Severity: Critical]
Does the addition of this second child node trigger a buffer overflow
regression in the pwrctrl-tc9563 driver?

The tc9563_pwrctrl_probe() function loops over all children of the pcie@3,0
node and increments a shared port index for each child. Since the driver's
tc9563->cfg array is sized to 5, the addition of this node causes the port
index to reach 5.

This results in an out-of-bounds write when of_property_read_bool() writes =
to
cfg[5].disable_dfe, which can corrupt the tc9563->adapter pointer on 64-bit
platforms and cause a panic.

> +		};
> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-eliza_evk-=
v5-0-41790a5a24de@oss.qualcomm.com?part=3D3

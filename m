Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355FE34027B;
	Tue, 15 Sep 2026 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442425; cv=none; b=Kq01j9SB3Q3bXmm1TYowA0SnZrrpWJ0rZtEiFGNcZY274BzmbuVJTBUMr8wr0J4ALYDUDJYyy9TeIDZ/dTJOxoknImlOOyKByUr/7lVvbEgy11UeFoSVXWweUEkXI+gmWslnPykxk6uaof3rn6xKLMz5GW+rRs2qvjXjP25qwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442425; c=relaxed/simple;
	bh=yh2nglcypZupBoWej1e5Y4pB2OGN3eCeGqhowbotP9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GNjZjTucW3BZISfp+i+RKYj4QHShlmVNe4J4I96VL0cdUc50ohfrkXj5+3pHY0IZwgUMCNBXuFR1qwmjvcRwIECSkjichn2fDQWu+Ql6m0zpQwGUmvebdFrFtXEWEZbSl19/8leICB4SE9zGPLKLPOaH5iamX82hQxTOu5Z9yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC8gG4vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC8gG4vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7C81F000FF;
	Tue, 15 Sep 2026 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442423;
	bh=0S74jqrKaQ3ZOdVlHnCPfXj0GV2ckAKp2yUP/SADbYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cC8gG4vIKoHokm/eHLoJklDJLF+FYS0iKbQ8IIyBCKBYP/p+wCpLmJEL53FdBlJyj
	 ZN9Eknji3Z3dCf8n89uz+myo4cjqXDHCKLku/71QdSt10Xr7vlIShh3XTHain1rzQi
	 6MzOZhvAFVNWCVMKFwaYHNc5t9NBHCfkUEXZMIvEwK0GbJ1nSFEKYxlIdsMoMRsGx3
	 3JKiSZcD/DLmsqNOMkYE6gUrtL6lQad4yyM3VU6HbW3CPrXUxCyrjzPdk23LyU6Rmx
	 MzH1hEcGDN895asISIEetD5GmpjkpYo/NPhCQa6jPmV3EHRjXFH+u7VT4nQq48rlQG
	 MCD/W/6Xy6hIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260915031038.1087264-4-elder@riscstar.com>
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:20:22 +0000
Message-Id: <20260915032023.6D7C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dts: pci: static ranges will not be updated dynamically due to exi=
sting DT node
- [Low] dts: pci-ep-bus node has unit address but no reg property
--

commit 1c7c7d7922bcd554a385a9dab10bfbe2a5cf71bb
Author: Alex Elder <elder@riscstar.com>

arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses

This commit adds endpoint buses for a PCIe switch connected via the second
PCI segment (0001) on the RB3gen2 platform. It defines devicetree nodes
representing these buses, including the mapping of each BAR's address
range to its local address space.

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index 3bb5fca8e2b13..59fbb0444d9b7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
[ ... ]
> @@ -955,11 +955,41 @@ pcie@3,0 {
>  			bus-range =3D <0x5 0xff>;
> =20
>  			dev@0,0 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050000 0x0 0x0 0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050000 0x0 0x0 0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050000 0x0 0x0 0x0 0x200000>;

[Severity: High]
Will these placeholder ranges actually be updated dynamically at runtime?=20
Because the dev@0,0 node is statically defined in the devicetree, it appears
the PCI core's of_pci_make_dev_node() will find it during quirk processing
(via pci_device_to_OF_node()) and return early.=20

If that happens, of_pci_add_properties() won't be called, leaving these
overlapping dummy physical addresses in place and potentially breaking MMIO
translation for child devices.

> +
> +				pci-ep-bus@4 {

[Severity: Low]
Does this node name trigger a dtc compiler warning? Defining a unit address
(@4) without a corresponding reg property violates the Devicetree
specification and will cause a unit_address_vs_reg warning.

> +					compatible =3D "simple-bus";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges =3D <0x0  0x4 0x0 0x0  0x200000>;
> +				};
>  			};
> =20
>  			dev@0,1 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050100 0x0 0x0 0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050100 0x0 0x0 0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050100 0x0 0x0 0x0 0x200000>;

[Severity: High]
Similarly for dev@0,1, will this static definition prevent dynamic ranges
updates? If of_pci_add_properties() is skipped due to the node already
existing, the dummy physical addresses will remain and could cause register
corruption or crashes if child drivers probe here.

> +
> +				pci-ep-bus@4 {

[Severity: Low]
This node is also named with @4 but does not define a reg property, which
can trigger a dtc unit_address_vs_reg warning.

> +					compatible =3D "simple-bus";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges =3D <0x0  0x4 0x0 0x0  0x200000>;
> +				};
>  			};
>  		};
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915031038.1087=
264-1-elder@riscstar.com?part=3D3

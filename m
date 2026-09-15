Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE23D411D;
	Tue, 15 Sep 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496722; cv=none; b=hemyV3CPlZb4/BSZbRB2vDUyTOA8yATRIUS+2u8gb6l3zG2XEyY/UCEcNGAeieFpJ3h6OrwRmSuKw1w4iKVIIPYV4W299HRzgC9abnNoT7pw5zvQ/V5NThMc/IYg3SfayejA4w0I6tv6x6GC1ZIPukNQnBcgeJpyX02D8pWHgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496722; c=relaxed/simple;
	bh=4KygqcfVrs2hdSsGjknH09RUdw6BIAr10wrgaE+eipY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHT7ImG8Mm/yUvBKNDLsbdnCMdptXpQWfLbIk8VrV3NJIft/sib5MQX+TacA9KSayW/RfRr6vLbbnGDaV5scUZjFEbGc2CVnL7cq7bmAcW7hlZnBtgq72BPp9L6+lgVSe3KfJGZ7AO7TvPfDbeyZcs/mJrmClM08wRPreQf7pP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es5cTpx+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es5cTpx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977DF1F000FF;
	Tue, 15 Sep 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789496719;
	bh=25t3ulDEvIYf7ztVGIG1zbQ3ckY6FOYVO9s2I06Fqbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=es5cTpx+f/VG4/QxCoK4L1GxL6M9qANcHAOdE3h9BJvUhPuIox/6JmvT9+WoxnGRv
	 VMz//UE7uS7NOMA/YzfWW4G43z9Aa6xv0WeRi/yUAc94T+AAHiD/TuXJxeCT8s4tjm
	 ZXu/yf83c4yDO7o4S738IJwUamNpdqvWSfz+doVNpGsFLPObJ4Xk+yE+nYdvzuR3px
	 iEkkIZeuNFf1HN8mGXYxeWSTDhYp6DX50YbT5bnjRq1SKEeosAm5/OswkBh9QdjtUv
	 V+Y4RfHlVbDQfTwAxUv/ZsE6/PdPeMHM2KARRlIhLp5L7hSmC4cx1kKCbIB9FTgZ/l
	 SoPyPBXotymkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260915181003.1633543-4-elder@riscstar.com>
References: <20260915181003.1633543-1-elder@riscstar.com>
 <20260915181003.1633543-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:25:18 +0000
Message-Id: <20260915182519.977DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI endpoint dynamic ranges update fails due to static node defini=
tion
- [Low] dtc warning: pci-ep-bus@4 unit-address lacks reg property
--

commit 8f41aa3c7aef831e8b83dd47d6e93a9ac9228f4f
Author: Alex Elder <elder@riscstar.com>

arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses

The TC9564 SoC incorporates a PCIe switch, which is connected via the second
PCI segment (0001) on the RB3gen2 platform. The downstream port has an
embedded PCIe endpoint that implements two PCIe functions, and this patch
adds the devicetree nodes representing these buses.

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index 3bb5fca8e2b13..5b7f5292a8864 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -955,11 +955,41 @@ pcie@3,0 {
>  			bus-range =3D <0x5 0xff>;
> =20
>  			dev@0,0 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;

[Severity: High]
Will these ranges actually be updated dynamically during boot?

The commit message states the ranges property will be updated dynamically.
However, the PCI quirk calls of_pci_make_dev_node() which has an early retu=
rn
if the device node is already statically defined in the device tree:

    if (pci_device_to_OF_node(pdev))
        return;

Since dev@0,0 is defined here in the devicetree, it seems they are linked
during initial PCI enumeration, causing the update to be skipped entirely.
Furthermore, even if the early return was bypassed, the update uses
__of_add_property(), which rejects existing properties with -EEXIST.

Could this leave devices on the pci-ep-bus with invalid MMIO addresses mapp=
ed
to unassigned PCI regions?

> +
> +				pci-ep-bus@4 {
> +					compatible =3D "simple-bus";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges =3D <0x0  0x4 0x0 0x0  0x200000>;
> +				};

[Severity: Low]
Does this unit address trigger a devicetree compiler warning?

The pci-ep-bus@4 node is assigned a unit address of @4, but it lacks a
matching reg property. According to the Devicetree specification, if a node
uses a unit address, it must have a matching reg property.

For simple buses without a reg property, the unit address must match the
first child address in the ranges property, which is 0x0 here, rather than =
4.

>  			};
> =20
>  			dev@0,1 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,
> +					 <0x2 0x0 0x0  0x83050100 0x0 0x4000  0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050100 0x0 0x84000  0x0 0x200000>;

[Severity: High]
As with dev@0,0 above, it appears this node might also be skipped by
of_pci_make_dev_node() because it is statically defined. Will this prevent
the ranges property from being dynamically updated for this second endpoint?

> +
> +				pci-ep-bus@4 {
> +					compatible =3D "simple-bus";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges =3D <0x0  0x4 0x0 0x0  0x200000>;
> +				};

[Severity: Low]
Does this second pci-ep-bus@4 node also trigger a compiler warning for
missing a reg property while having a unit address?

>  			};
>  		};
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915181003.1633=
543-1-elder@riscstar.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3F37AA81;
	Tue, 30 Jun 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800371; cv=none; b=mkI1zfCm7oA6rsC5JpLCm+k7FxSNZl+tzLO6uE2fbG9zBIXmUHnPLp70YSQYG7kqyyuIwEl3MZns4ABCbM8avK9ySVMMRYxuspH1h+/6Mp14oLbpyhmf/uWgblQl/hlkaziODSFKzq9sNvt255ukX7prZ9VAZCyijrihR6mbWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800371; c=relaxed/simple;
	bh=gPz3LPTDFPtL/9HEKFqIS2fNxTOPVxP6rRBmP5Pj1m0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sH1VUyFdoJKzqrHsSqcDhpNTu7ZZI5jLnbZuFrgxgTR/XEtT8Z0hBRUZjXI+njETClJ9yvVS6FMlZBkduYoFwW2v6dFISv/ghRWxD6VIYQ3sxDTrkm//yC8zKXIgYXMrUjzaolTyjo25ZifSa2epwMHHFZ9pNWAt+3tfIy1R8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae3Q544W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae3Q544W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B141F000E9;
	Tue, 30 Jun 2026 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782800370;
	bh=HP8rMXvxZe/c0Vo6jvcBj8GaeSNo9tX0Dwe6iy1+SJ0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ae3Q544Wn56I2TttcsPDBu3KXsq8O70NzzckxTB/YEodR4Ex9RcxSE0oqXnnanA97
	 +Ay2s5MNT7LpslR4uT4disjHoleIytW2Zb65nz35kpOWmPHmqqn31HqtV0O+Lc7G+r
	 S2ygA4SMqwryyKagy9fFX7SsX8BLlIGwL14/XkeYFaYtqA5r2gICUCjP0+KiB2tpqy
	 Bqtig4TD/Z1DibzpKEPwDQZ/vWKbE8BtNoxKg+pLc4UT8SjTO+Ywq3TXy/DTIY2hO2
	 r1AAQiMg1155ip+D0OKfVbVJd4U/zB+GsEc+L0ys9hV8k6pLc8xmNFhTIMeZ1fnMwM
	 e/PLQW3z9aUtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/7] arm64: dts: imx8mp-evk: Move power supply
 properties to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260630060710.3294811-5-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-5-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:19:29 +0000
Message-Id: <20260630061930.07B141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removing power supply properties from the PCIe host controller=
 node breaks backward compatibility with older kernels.
--

commit d2930da890ce2314f11817b05c9728d18176f34c
Author: Sherry Sun <sherry.sun@nxp.com>

arm64: dts: imx8mp-evk: Move power supply properties to Root Port node

This commit moves the power supply properties from the PCIe controller
node to the Root Port child node to support the new PCI pwrctrl framework.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -772,8 +772,6 @@ &pcie0 {
>  	pinctrl-0 =3D <&pinctrl_pcie0>;
>  	/* This property is deprecated, use reset-gpios from the Root Port node=
. */
>  	reset-gpio =3D <&gpio2 7 GPIO_ACTIVE_LOW>;
> -	vpcie-supply =3D <&reg_pcie0>;
> -	vpcie3v3aux-supply =3D <&reg_pcie0>;

[Severity: Critical]
Does removing these power supply properties from the host controller node
break backward compatibility with older kernels?

Older kernels (prior to the introduction of the new PCI pwrctrl framework)
rely on the pci-imx6.c host controller driver to parse the vpcie and
vpcie3v3aux regulators directly from the host controller node (&pcie0).

If these are removed, older kernels booting with this new device tree
will silently fail to enable these regulators because
devm_regulator_get_optional() safely ignores -ENODEV. As a result, the
PCIe slot will remain unpowered and endpoint enumeration will fail.

To maintain ABI stability, should these properties remain in the host
controller node as deprecated properties, just as the reset-gpio property
was retained above?

>  	supports-clkreq;
>  	status =3D "disabled";
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060710.3294=
811-1-sherry.sun@oss.nxp.com?part=3D4

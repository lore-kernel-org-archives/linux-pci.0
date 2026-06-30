Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB286334;
	Tue, 30 Jun 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800629; cv=none; b=J890CAL2O6ehq4bV+obIRjlMRc4FNaOm18Lh/YHO6InQs85IoyA8682COKrhzNCt+kwvMx+6qzJinArE4xqI/zoM8kCitXJQZuWPqnFPOg6+eoV0xXVl9AYyy9KxV707e583ob0VoMriX2s1tno6M7pWNVapuK2D+cvh6hpKRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800629; c=relaxed/simple;
	bh=SsozXfCOFbqCgfG1zY5IYCgIywPJ4JdDGYmzSp1tM8Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OGgYUCMcTVjaG+AAH6i/nfK21CxLWgFu8w76/K4ZbXBo2y9MohE5sQidAHW7ud7J2fY0ODIjr8kHJsCdR0Beww3Jc0o1g8JM4qbX7Rr7LXN6X7HdQN2wGuIyK1umJaSLL8u2VtaR1juCckyklQMRh0bfvRNqlPhhiyk8ZzWsJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd2+qzhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd2+qzhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE471F000E9;
	Tue, 30 Jun 2026 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782800627;
	bh=gTFMTWjPkmujjW7rKUdfMY/lDYHhCJzeWzdb/3WeK3M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hd2+qzhM9NusnQDoJHlGdyh8l3K8LHpwqUbVGRZvxm04SkxiQfAQA00KekFXBozvU
	 DlXw6i7SCyiEfb0fnLJu/WEcuyWK3rSPGTVrxVkH5cK8Tid9hlzs8wFW7gQ4thvmZX
	 bPKzczEQr29Yo7+XRwcba4qU/WkizkPkfOvXdL+++O+y6ATSpd208rqlin0wbNBMIm
	 A3PHbGavPUstUkqTuMu8Q82jKQfLcgJ6NlL4YRzqhwcq+xGGoWJNpO/oWfsF4suk+t
	 G6gni0kP6Uawm2Z1Z5QwN6rsBFwuy3gzGZlrCu2LY0opD+l50rJ6pTlSdGV4vFpG4B
	 +sMPR6vKRG6CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 7/7] arm64: dts: imx95: Move power supply properties
 to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260630060710.3294811-8-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-8-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:23:47 +0000
Message-Id: <20260630062347.7FE471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing legacy power supply properties from the PCIe controller n=
odes breaks backwards compatibility for older kernels booting with the upda=
ted Device Tree.
--

commit 332f451afbc5374b9f81acdbad51ee15f1b90088
Author: Sherry Sun <sherry.sun@nxp.com>

arm64: dts: imx95: Move power supply properties to Root Port node

This commit moves power supply properties from the PCIe controller nodes to
the Root Port child nodes. This change is made to support the new PCI
pwrctrl framework.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm=
64/boot/dts/freescale/imx95-15x15-evk.dts
> index 7d820a0f80b22..6aedcbbe915a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -555,8 +555,6 @@ &pcie0 {
>  	pinctrl-names =3D "default";
>  	/* This property is deprecated, use reset-gpios from the Root Port node=
. */
>  	reset-gpio =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> -	vpcie-supply =3D <&reg_m2_pwr>;
> -	vpcie3v3aux-supply =3D <&reg_m2_pwr>;

[Severity: High]
Does removing these legacy power supply properties break backwards
compatibility for older kernels booting with this updated Device Tree?

Since older kernels lack the pwrctrl framework to handle the new Root Port
properties, they rely on finding vpcie-supply and vpcie3v3aux-supply in the
PCIe host node. Without them, the legacy pci-imx6 driver silently skips
enabling the power regulators, and PCIe initialization will fail because the
slot remains unpowered.

The reset-gpio property was intentionally left to preserve backward
compatibility, but removing the power supplies appears to defeat that
effort. Keeping the legacy regulator properties (even if marked as
deprecated) should be safe, as the kernel regulator framework uses reference
counting and allows both the legacy driver and the new pwrctrl framework to
concurrently enable the same regulator without conflict.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060710.3294=
811-1-sherry.sun@oss.nxp.com?part=3D7

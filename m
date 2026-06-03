Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BB3905F8;
	Wed,  3 Jun 2026 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469419; cv=none; b=oJiVvDXIKYKPnMHV/xKbqFYvAcjEiuLdS9V3Un9Q3wN45ASoGoaIqfHCrR0aXud8AxSLHAwj8tP0VXNZVtUCcdNhl5rgHVX+xd4aOfCrlnHY9uI4jqQ6/w7JRcbaq1ZcTKfl9dEo8yrQZI/shGP0rTKQULaB+G24/aUt2zFT9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469419; c=relaxed/simple;
	bh=pU1kWWFlfpIrNiyi/QGRQB4RPeP7pUM59uT803OtXSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhmelwTUy+SYwprDr5K6GKbgqPKjJ9j/yY0aBK1l1Klk+flcWulJVUYcBCsJ310FgVlLYB9AJd4wgUzYFAAbcEw8339w5voQ2/1U3QwgStAqokoWUSeVdKrYBS71s8gDfdb3sUo081w0CWtbo32IdyKygpUIpFzWR+WZ7PDI6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKNFJQFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKNFJQFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD41F00893;
	Wed,  3 Jun 2026 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469418;
	bh=pPHESEW29LuV/32hvd+7KGwYuLMkojV6U/198TMCRNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKNFJQFiqP5Q/AAmxKKY1rdehxYtQaL381RDW2g5WZWeDlspmbCGVGcy1C1DX6dH/
	 t6gkDH+ZLU4G1Ttezaa4Qg3K+gqQCkOOF6W2x7mNRGkBSWKK0Eiuos7JXo0d1SAHCC
	 sKMDp/OwlglPQv+tGni3Ioh4Q8Okq7LueHiAzVxbmnV3GD15T1ZH46uHM6PNAC6cuH
	 I8eWCRjYQd/gPeq2NWyQNDBDQ1muDcBCpn4SGtRtaL6CQLzFgtBdesJC9KzlavG45v
	 HMQv3ZlyEHQvgStTV3AUMR0BPydkBVrVMIC7pXTl/HMAWjgBGhUcWo8YJeKrBPU6KS
	 Jjhjv9jZlm/tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
 interrupts for PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260603062510.3767610-3-hongxing.zhu@oss.nxp.com>
References: <20260603062510.3767610-3-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 06:50:16 +0000
Message-Id: <20260603065017.65FD41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unrealized feature claim regarding PCIe 'intr', 'aer', and 'pme'=
 interrupts.
--

commit 29e808a747deaa069b3eea1b8af9a71ce6b4b8c9
Author: Richard Zhu <hongxing.zhu@nxp.com>

arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe

This commit adds dma, intr, aer, and pme interrupts to the pcie0 and pcie1
device tree nodes for the i.MX95. The commit message states this enables
enhanced PCIe features that were previously unavailable.

> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> index 3e35c956a4d7a..1a9803f967901 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi

[ ... ]

> @@ -1945,8 +1945,12 @@ pcie0: pcie@4c300000 {
>  			bus-range =3D <0x00 0xff>;
>  			num-lanes =3D <1>;
>  			num-viewport =3D <8>;
> -			interrupts =3D <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "msi";
> +			interrupts =3D <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "msi", "dma", "intr", "aer", "pme";

[Severity: Medium]
The commit message mentions that adding these interrupts enables enhanced P=
CIe
features and capabilities that were previously unavailable. Are these new
interrupts actually consumed by the kernel?

Looking at the Linux PCIe DesignWare core and the i.MX PCIe driver, it does
not appear that the intr, aer, or pme interrupts are requested or handled v=
ia
these names. Features like AER and PME are typically handled generically by
the PCIe Port Bus driver using standard in-band PCIe capabilities.

Could the commit message be updated to clarify if these are being added
primarily for hardware description completeness, rather than directly enabl=
ing
new features in the Linux drivers?

[ ... ]

> @@ -2020,8 +2024,12 @@ pcie1: pcie@4c380000 {
>  			bus-range =3D <0x00 0xff>;
>  			num-lanes =3D <1>;
>  			num-viewport =3D <8>;
> -			interrupts =3D <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "msi";
> +			interrupts =3D <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "msi", "dma", "intr", "aer", "pme";

[Severity: Medium]
Similar to pcie0, these interrupts are defined here for pcie1 but do not
appear to be consumed by the kernel. Is the functionality claim in the comm=
it
message accurate for these definitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603062510.3767=
610-1-hongxing.zhu@oss.nxp.com?part=3D2

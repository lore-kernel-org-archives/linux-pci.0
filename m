Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43E348C47;
	Thu, 21 May 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357247; cv=none; b=CApAPYSvRrnsjpzI1AjdXgSxMnbgo5dSEdp0Pkxk4g3v6WT6adoaDiBWDXGFH1FhnAQhRp8h+kwKiyZ4pDqEyZi4I2fYOQIkGa1TKn9Updy0nh25SSaeSEOLzF2CUgILISGzCVbBXDXxT8iexrZpAhWxRe+3/WEqS4k8OAijEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357247; c=relaxed/simple;
	bh=25s6pRsGSt3bUupVG4S1trH6DP9oIrYLLr31iJXVg5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzfIW7//9kNC9Qs1uelIh4q57W5dwDaSG46st7rvVpoH+mpJDBU+FFCMaoibv6JY5B3nUIRoE+n6NFvAWN7Z8zz93Bfm5wSG6GtRgha5o7EKPN2PJZQNo9DJOXjksvwVyaec7Mg/xO1RT3IrNMFdrIFwXg/BPYo9FoSRuwdpr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt1GoCUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt1GoCUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EFD1F000E9;
	Thu, 21 May 2026 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779357246;
	bh=aEBWcPXs9aHG6NpITd6et56UobUUpHoNGH6cSlbLzII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xt1GoCUB88OHejbBAthwMBqYUkZ+Nek/iTNAIaG67D/CWL2LLobCFUTeGzeGThmX0
	 Hcm2KeXKtLC/tEjYftktbRf5WxDiiEEeqGSrB1/UdCbPha40usEVahny80udqNrDxo
	 RdJt/eSy53gJPHPEYBd3LzXw02d6eQ0jnp4etVxF/2K+HpaLl9ruSfKrO8NnWO8hF8
	 bOt1G02kLWINGv/Hzqu9GusDZk+PkvVH3niX69XlxvhR3QlfMCoD8xEj6jXKP+2qDI
	 rHbruDA2X0+Yc1MwAgObwp0ur16alCwqpXoR4rftGOiaSdFuzxTClsYjvtkTG3bpmG
	 6LhZ3WQjsG+yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt
 entries for intr, aer and pme
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Zhu" <hongxing.zhu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260521093255.61585-2-hongxing.zhu@nxp.com>
References: <20260521093255.61585-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 09:54:05 +0000
Message-Id: <20260521095405.A5EFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Expanding the global `interrupts` and `interrupt-names` properti=
es without adding conditional blocks allows legacy compatibles to incorrect=
ly pass validation with unsupported interrupts.
- [Medium] Using an ordered list for `items` fails validation if a device o=
mits the optional intermediate `dma` interrupt but includes subsequent inte=
rrupts.
--

commit be2769e2cb772d7043d8c01877a0a7fecb468b12
Author: Richard Zhu <hongxing.zhu@nxp.com>

dt-bindings: imx6q-pcie: Add optional interrupt entries for intr, aer and p=
me

This commit adds three new dedicated hardware interrupt lines (intr, aer, p=
me)
introduced in the i.MX95 PCIe controller. These interrupts are added to the
global interrupts property as optional entries to maintain compatibility wi=
th
older SoC variants.

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..cf709132ff1e2 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupt line.
> +      - description: builtin PME SPI standalone interrupt line.

[Severity: Medium]
Will this expansion allow legacy compatibles to incorrectly pass validation
with unsupported interrupts?

The commit message notes that earlier i.MX PCIe variants lack these
dedicated hardware interrupt lines. Without adding an if-then conditional
block to restrict interrupts and interrupt-names to maxItems: 2 for older
variants, invalid device trees specifying these unsupported interrupts will
now silently pass validation.

> =20
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme

[Severity: Medium]
Does using an ordered list for items cause validation to fail if a device
omits the optional dma interrupt?

In YAML schema validation, an items list enforces strict positional matchin=
g.
If a device tree defines msi, intr, aer, and pme but omits the optional dma
interrupt, the intr string will appear at index 1 and fail the strict
evaluation against "- const: dma".

Could the schema use an unordered list (such as oneOf or items: enum: [...])
to allow independently optional interrupts without strict sequencing errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521093255.6158=
5-1-hongxing.zhu@nxp.com?part=3D1

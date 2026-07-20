Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C730B51A;
	Mon, 20 Jul 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561314; cv=none; b=Sxk24EUm1SjEkzivf3U3Sv5uCZ7t13yGMjCzKx5kMvaQXERSniF5td873YWlicc7d597YfBG2lJQbWfHLeAt/fD6xFWqTcr7+zPCbT+rx142rWf/KzbhHdkLbHu3fItv25vXehjFG/nR8qzH/lTpTyugAhtX2N2vEw9PL8+oJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561314; c=relaxed/simple;
	bh=xjl9auaPDoiiPOTDY2VMBVC1FdcKxXSErJOkyNR+Tfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9PSYl9KQR/KdLzQyy7ugQmeSTTYqFU5xjgQNc9Fc3f+8fTe8ks3X1q/fEQ7FFbvl+Sb/VFaKYnndrJW2XVZZKrAx34VTR+rrbmEMckvwTdaESuGg0xa5eizG/wnJVLtRQS4Y/k+R+k0omac9u5IaFxXZIbUJfyuMODmzrggDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9uId99Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9uId99Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA951F000E9;
	Mon, 20 Jul 2026 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561313;
	bh=BABJFnYN3Mt7fhT/xNkof710NDy+wmhVX0gnBjBP8K0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9uId99ZI+8OOUjbLR97IZGmcrkAwPmwah1uPoFYD1D5DTbq7Gx9VKd2MpKHffP/W
	 AU1hdDN6PjSqM3JstdvpM0WXL/4jnC0teRuq3Hc1Gu9DNCEWdI+LlJA55QGJPEZK6b
	 TcJb3qpzbGihsGXVDrgarWn1s4oVsAWpGPOjGeGTep/dBy63SaNh/4cdzpb+uI9ZbQ
	 4V4U1Wow0yR4tfBT2pZRo2gHJBPUmK2OjuV9T+HnsbYej55mqc/13kd9qLZdHHpgKx
	 7tQzNFUE7Sjh2vLlJ63c5L9PkOrr+DCfgvvT0xkeQBpBUt8m4zMvJl6mbSz8kEOqtD
	 Elo72hboNkzxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] PCI: dwc: imx6: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org, Frank.Li@kernel.org
In-Reply-To: <20260720150619.24733-4-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:28:32 +0000
Message-Id: <20260720152833.1CA951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In Endpoint (EP) mode, the cached `pci->pcie_cap` offset is uninit=
ialized and defaults to 0, causing `imx_pcie_start_link` and `imx_pcie_ltss=
m_enable` to read and corrupt the standard PCI configuration space header i=
nstead of the PCIe Link Capabilities register.
--

--- Patch [3]: [PATCH v3 03/16] PCI: dwc: imx6: Use cached PCIe capability =
offset ---
commit e88cd77b027a125e9713fc310c612c5158a23be1
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: imx6: Use cached PCIe capability offset

This commit updates the i.MX6 PCIe driver to use the cached pcie_cap
offset instead of dynamically finding the PCI_CAP_ID_EXP capability
during link start and LTSSM enablement.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..74b28b4df4846 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -966,10 +966,10 @@ static void imx_pcie_ltssm_enable(struct device *de=
v)
>  {
>  	struct imx_pcie *imx_pcie =3D dev_get_drvdata(dev);
>  	const struct imx_pcie_drvdata *drvdata =3D imx_pcie->drvdata;
> -	u8 offset =3D dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
> +	struct dw_pcie *pci =3D imx_pcie->pci;
>  	u32 tmp;
> =20
> -	tmp =3D dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
> +	tmp =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);

[Severity: High]
Is pci->pcie_cap guaranteed to be initialized here in Endpoint (EP) mode?

It looks like imx_add_pcie_ep() does not call dw_pcie_get_pcie_cap() after
the hardware is enabled. If pci->pcie_cap evaluates to 0 in EP mode, wouldn=
't
this read from offset 0x0C (Cache Line Size, Latency Timer, etc.) in the
standard PCI configuration space instead of the PCIe Link Capabilities regi=
ster?

>  	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
>  	if (drvdata->ltssm_mask)

[ ... ]

> @@ -995,7 +995,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
>  	struct device *dev =3D pci->dev;
> -	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;
>  	u32 tmp;
>  	int ret;

[ ... ]

>  	dw_pcie_dbi_ro_wr_en(pci);
>  	tmp =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  	tmp &=3D ~PCI_EXP_LNKCAP_SLS;
>  	tmp |=3D PCI_EXP_LNKCAP_SLS_2_5GB;
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);

[Severity: High]
Can this corrupt the standard PCI configuration space header in EP mode?

Since offset is derived from pci->pcie_cap, if it remains uninitialized
(0) for endpoints, this write would target offset 0x0C in the standard PCI
header. This could corrupt the Cache Line Size, Latency Timer, Header Type,
and BIST registers.

Does the endpoint initialization path need a call to dw_pcie_get_pcie_cap()
before the link is started via dw_pcie_ep_start()?

>  	dw_pcie_dbi_ro_wr_dis(pci);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D3

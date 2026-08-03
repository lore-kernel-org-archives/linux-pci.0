Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6D388866;
	Mon,  3 Aug 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729140; cv=none; b=acw9jjZta+s79ZsAIgAD4/ePxX6bULdS/IH0j8PwFCiXxHiThkf85a+GWmnxGcQPw5Guw75jZuQYzJC7IvUZgnc2JYUfBGbGTWOCzq7Qvdsz1ugM+LR9OEvXlwsukrtIsFGT5wngp3Gej/uPGRnm4uFj5+bnNci/TGtYBz/fjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729140; c=relaxed/simple;
	bh=O9VMCUlZQAJmnjW5VfNldZUQSCdNo6ORYcq6wELXxxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IXrXDKUg3eCLn8Ms8vcX6UAgzYVKgKq2e8Fkovlcy9pXswp1JU4C+TPBiCJxORKvz09tPaQ6YmSjsg6lvSs2XGeRzpWiJv1h0oiyClsUHBoYyaBP2O0rf9Oxr81nEYsGiHt75Dr46j9f7y2JUhMXC+zveUvUTL9TJZ0OTwDuT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ2FMznU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ2FMznU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A531F000E9;
	Mon,  3 Aug 2026 03:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729134;
	bh=XK4/7kfow+3L+NujK5Zde0mgJ1DkimBWNgocUBjAjd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iZ2FMznUWKF/cuQbetyx+71ngnepsVXATdwu8P1PKALM6QkjcOuYk5sAWppp0rBA/
	 wE4U7oquapC+p97nJ7GbR6E/5rPgX4FP4St2eJYgv/O/rW37DPTZwvZVzryLv+njVk
	 rAksYk+qkUGguTGpb5ot/dahRLIXlBUlJOF0kdk7pOUPlA8lmFCRhs/xBIuPqLvoGY
	 JbRM86EN0FjSZXw4wTiIX4mrdqpBLN7U/EwN2D8BLhrOsNlS+W+2VgY58PQq1jjmbT
	 M2fqUSjRzN32wy62poxJu120wxi/aN+8znb+HaX8yXPHPY7zwmU8LTGDXXTn4Ya6+2
	 eCkKphdhCalyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
References: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:52:14 +0000
Message-Id: <20260803035214.97A531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Two consecutive `regmap_update_bits()` calls on the same registe=
r `IMX95_PCIE_PHY_REG_ADDR` create a transient invalid hardware state.
--

--- Patch [1]: [PATCH v5] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95 Gen3 PCIe stability ---
commit 4d9e90f9649b735da05c82cf73f9ef235bcf11f8
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability

This commit updates the MPLLB bandwidth override values to improve PCIe sta=
bility
on i.MX95 across voltage and temperature variations. It implements a PHY re=
gister
write helper and configures the bandwidth parameters during initialization.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..ad7efae23cc50 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -269,6 +280,15 @@ static int imx95_pcie_select_ref_clk_src(struct imx_=
pcie *imx_pcie)
>  	return 0;
>  }
> =20
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u1=
6 data)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);

[Severity: Medium]
Could these two consecutive updates on IMX95_PCIE_PHY_REG_ADDR create a
transient invalid hardware state?

Setting IMX95_PCIE_PHY_REG_EN first and IMX95_PCIE_PHY_REG_ADDR_MASK second
might expose an intermediate state where the PHY evaluates the address whil=
e EN
is asserted, but the address bits contain a previous value. This could
result in a spurious access to the old address.

Can these operations be combined into a single regmap_update_bits() call to
avoid this?

> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803034319.9923=
23-1-hongxing.zhu@oss.nxp.com?part=3D1

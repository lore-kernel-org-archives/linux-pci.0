Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30B3C1F;
	Sun,  2 Aug 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671370; cv=none; b=G6R2rFBd+MleStg+u4NL9iA7J6Gh+/ti9wj/rbWlBu6HUuLDOg7uEICKG5Xro94SOKrDYt6pGvLtPS+0VmsBKftzOTrx+/Fg34cKPZRK/B2yoDWXNG6cAWiaaLPiPDsbmWDMzpnDXjEQKa8MLUf2cpkpY5oDuHGDER/Je2e+vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671370; c=relaxed/simple;
	bh=DQfsUDP2U4yHdKpMJg9iTQskUa8QCu28JbhYGPIfVU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/cLTyyzoTXuzxRKkzRWPoVCTlHjg7nzhgEuTovw6MnBuRI/rU20gZxYIQoD7fzuVMlNDg3F69glz4fF3ACJk/nLNg+iCFxfVOtUz7gYsHwJ7wgLjaA6bBaQ7KNKllAWRgRoYxstBpSL1mlVbbxABoNzChnKVNcGgPa/ss+1CQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwtD1D6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwtD1D6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEB1F000E9;
	Sun,  2 Aug 2026 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785671368;
	bh=YPNN9QBNUKP7cXRF3Exi1YmS7O7oivKgxtzYWloey9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwtD1D6OwAoXBVP3QThgy9SgjlqBWvXInrnvKdYGhSEmUE5J22I0X7qo1fsgEcohb
	 t8J5VZ1fu7OCoSA7JJVuEsgeLjI72+mtZYZPowcw2cHVf9di7BREL4w8luh6AaZZNx
	 3bu21qVMfocFhyxkNZT9ZpK4NfVHV9sJdTel2DEPbnfjTsE6YDurQPLe/FiBl1VzmO
	 DIN+RkC7LUYySsw7CFeUBz2/DxOT9BOzJuX4r10U5EY+HxTlKYf6oAxMj3WMoiP/0t
	 k17EEVb6k7+2pJgVmxXtKOQg8YJxY45asdAZMYc41fxGUzfglv9deEJ9AmAtwfs9Zn
	 3UZ1l46UTT99w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 11:49:27 +0000
Message-Id: <20260802114928.4CEEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks backward compatibility with existing i.MX8MQ devi=
ce trees by changing the default reference clock source, causing PCIe initi=
alization to fail.
--

--- Patch [2]: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK whe=
n needed for i.MX8MQ ---
commit 6f37370c304d3692e11e97087dc50e68e2389b9e
Author: Rudi Heitbaum <rudi@heitbaum.com>

PCI: imx6: Use the external clock as REF_CLK when needed for i.MX8MQ

This commit updates the i.MX8MQ PCIe PHY initialization to conditionally
select the external oscillator as the reference clock based on the
enable_ext_refclk flag. It falls back to the internal PLL if an "extref"
clock is not supplied.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..9e3b64fecb451 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -445,11 +445,16 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie=
, int addr, u16 data)
> =20
>  static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> -	/* TODO: This code assumes external oscillator is being used */
> +	bool ext =3D imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Select the off-chip oscillator as REF_CLK when an "extref" clock is
> +	 * supplied, otherwise fall back to the internal PLL.
> +	 */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			   imx_pcie_grp_offset(imx_pcie),
>  			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> -			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> +			   ext ? IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);

[Severity: High]
Will this change break backward compatibility with existing i.MX8MQ device
trees?

Looking at imx8mq_pcie_init_phy() in drivers/pci/controller/dwc/pci-imx6.c,
if a legacy device tree does not provide a clock named "extref",
imx_pcie->enable_ext_refclk evaluates to false.

This causes the driver to clear IMX8MQ_GPR_PCIE_REF_USE_PAD and fall back to
the internal PLL. On boards that previously relied on the unconditional
external oscillator selection, this regression will cause PCIe initializati=
on
to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785669457.gi=
t.rudi@heitbaum.com?part=3D2

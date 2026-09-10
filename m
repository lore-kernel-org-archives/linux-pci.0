Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D145C71A;
	Thu, 10 Sep 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037221; cv=none; b=ZgGjfCGjW2ybDZRCx5+N2JzGmq8nsUFbYd2ftET1W6psxTZeII/8iU9e4KkzG7lJNhBys61PS7OpnGOoO2fnnRnjU59/gugLCXQfkr/J1LepK4+cq0eI3hlyU8bFYGmENbGlx1d410dN5lakn1zbeBrJv0hBbw7SZ97VElyMPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037221; c=relaxed/simple;
	bh=ApSiA/9iZwJxt0HLNCdE+LFR0xQ/rueRz6+0I92/OdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB100U/5Pu7knsJZwNdcBYPfGgnCBSTbd4AboDFW10oAqscZ4D/Oyf/4qakuVUH5rHd+3y//aLS2O1jUd5Q2gFQR2K2fJUnz7fIRPx+ifZwuPfow4xpMikl0WSIq35d1FOosPl00dGv0L1HbxZ4VwLIzAub4PMwbWjqE4rFLZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN6QZt6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN6QZt6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C90B1F000FF;
	Thu, 10 Sep 2026 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037212;
	bh=sMB5qXqvNx3BJbaxkPq4j1Gnoku1AFqOK8/l2xk+F7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZN6QZt6O3MLzgqmYkmBgsf49pieDTorluX+jRjhxCCt7V6tC7qBO+3FTp3lNzmTC6
	 w9WTpiww7Mu2cT5YLzO2Q7hef9jzAyKF2VFnBFMbk9ixADkSx7YkR8OYW0mQnwRLiU
	 EqiV2dooB9fP7mYprCwfg6frserLGIT65/W/KgpTPitae3BM9wOBWQAPm5DzFonZw/
	 WDObgQurIJdASxm+V94GbRgX9TeMnEqMv6OZ9qjjp3J/sn6TNiAThAZwinjA8/CPTW
	 sJqAghhqpOQGpbHRcoBl6Uxh7mLqNZ8w4Q1fonJlPGTazsnqJf6A828JQv90CcE+3Z
	 GNwjD0HtFeR3g==
Date: Thu, 10 Sep 2026 12:46:43 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <ojbp5v6txcdvrs2hcrknai7kkb4bu6cnp6fometzkrf2mdzvv4@cepxzg4r7jvd>
References: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>

On Mon, Aug 03, 2026 at 11:43:19AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> We observed poor bandwidth margins during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value (120). The margins worsened across
> voltage and temperature (VT) variations and different test matrices,
> potentially causing link stability issues.
> 
> Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
> 
> Implement PHY register write helper function and configure:
> - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> - MPLLB_BW_OVRD_EN to enable the override
> 
> This ensures robust PCIe Gen3 performance across all operating
> conditions.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v5:
> Update the commit log refer to Bjorn's suggestions.
> 
> Changes in v4:
> Move the delay to imx95_pcie_init_phy() with a comment added.
> 
> Changes in v3:
> Regarding Frank's comments, refine naming consistency and clarity.
> 
> Changes in v2:
> Update the register name and bit definitions.
> Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 39790e66b98dc..3bc52c4781903 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -80,6 +80,17 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>  
> +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		BIT(10)
> +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> +
>  #define IMX95_PCIE_RST_CTRL			0x3010
>  #define IMX95_PCIE_COLD_RST			BIT(0)
>  
> @@ -270,6 +281,15 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	/*
> @@ -290,6 +310,18 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>  

I've added regmap_read() to flush the IMX95_PCIE_PHY_CR_PARA_SEL update before
below delay, while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

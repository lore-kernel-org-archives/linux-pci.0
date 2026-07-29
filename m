Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F49469831;
	Wed, 29 Jul 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344202; cv=none; b=e1f2FtyCbjIWK9xCa5VlP5idkFEwI4mz2hzlS4VIxYmprsqZpsBPzX36MKQrgKS7WV3dyjQe4ltAxCRNMJwAxSsEEQdqeGufC+aheMgxCGMg9hCk0Gcc6uZ6tlqkRLuZIDvnng5qBtvuFiO7WAJgkgUkyCw64qBpTcpvIOyLZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344202; c=relaxed/simple;
	bh=5z1KEIgaOrhPGXwYfMIWgzhF9UXsjWiT8/l/4mfvSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AByqofa5rCPzTCCZkbVViB/wxlbnu3Ar83yPMz0YGT2MKfwFZyY/dotoenuw3zZfRyRdbG6SxMJlZDReySIh6In//QWEX77fqq1o0dIpFfmHxeazQk6iZ4OqlMn8Zpe8HE8yL/PQqCFNcHX+302x2r16C6MLseSg/ZNi4c4j7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL5SNrAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL5SNrAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD11F000E9;
	Wed, 29 Jul 2026 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344197;
	bh=Lg59M+bKmHrruSQn5i7qPKBmAeGYaoVMrN0VKxKzTrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aL5SNrAfl/7FBVwi4dqKjk5eVIxYFhTTVMqTdhNukNPwCC1CE6NCUyVWOdmSPr1h4
	 mxgohzFil3hWRkr2d2y6PgHFl4imjHcwRV51eU6FGtKWWzpwn9I9/USNgr4/81s78i
	 +msucwkWhkMJkVXerWWp2YCmxv8DkWwsaJTH4i5DAsmgFCxYVZFCe7QxixwEDpqKEU
	 JId7ehyT/0W6maR37M05/Si74IFdIo0eBP7VugM3SgQD2DJgqDHfkWy1BH25PCH9m1
	 MwLla81C94JbMiCqP0JR5bb95GJg3C+vEsQDNPWqkgCmWp3ALr1tl/TLgxjNbJx/ix
	 xA8vLXZ6hw/Wg==
Date: Wed, 29 Jul 2026 11:56:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <20260729165635.GA1450437@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>

On Tue, Jul 14, 2026 at 10:41:07AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value. This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.

What does "bandwidth marginality" mean?  And what does it mean to
observe it?  I guess it must mean some measurable thing is close to
being out of spec?

> Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
> 
> Implement PHY register write helper function and configure:
> - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> - MPLLB_BW_OVRD_EN to enable the override

AFAICT we don't know what MPLLB_BW_OVRD_IN was before, so we don't
know whether this increases or decreases the value.  And we don't
really even know what MPLLB_BW_OVRD_IN specifies.

> This ensures robust PCIe Gen3 performance across all operating
> conditions.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> Changes in v3:
> Regarding Frank's comments, refine naming consistency and clarity.
> 
> Changes in v2:
> Update the register name and bit definitions.
> Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 53f3da6ab30d5..fadf14de10f7c 100644
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
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
> +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> +
>  #define IMX95_PCIE_RST_CTRL			0x3010
>  #define IMX95_PCIE_COLD_RST			BIT(0)
>  
> @@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> +{
> +	udelay(200);
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
> @@ -289,6 +310,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>  
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

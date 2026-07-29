Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DC4963C8;
	Wed, 29 Jul 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333479; cv=none; b=RQdpwyYJEmlLfhM1qqEKFxyxgR2a9tnDKQapU2C6FEf5O4QuvTXP/I1XX7uxZYRq2hBV5DXO/NX36+38jMZk/J2NFfNlVFX9pllEbUA91VbwVGDGE/5mZ2y30ag/OivQR3MO76SaB022zUU14k8cUZnefTsnVjAYO2nbsynqx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333479; c=relaxed/simple;
	bh=kuDyRjhrPNyMKYVKvqeOj0baUYY06hEeS6lvk3MALCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiOFWxkJS4rSUn/pqkVuk/ClwJqLQM+vc3km5exIIicuZD+X/UL7rdErTw2dabnayKPFCeaLiNnC0zZAk8rLaa46OThc3HdTxGyS0xBHn5pBPTY680ceUJjmzMuoUAdv78K1huxhgNFlMmlcXoM4WHeskqJeaIN+FlOufsrplt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt+hF+Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt+hF+Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1D61F00A3E;
	Wed, 29 Jul 2026 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333468;
	bh=fYVkarbGTlgISBurccqc2jqkuYXw9q5Rk/awuWQnUDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bt+hF+KdOEUbsvd8Ebt+v3bsvf2lC1rPuBjvhOQtryDvrj0/6QwfoxSSMvEqoKL3N
	 PLhUiSUCTzLYwsrs5wzQZe+Fp4I+JPksLt/KM71OyVdOt6kL3zqUrNjXOBLYcjwyOu
	 E5ose4lx0hl6Twtbz2iBZ5zsigpeTclK3o3bP6JeRh0QREiWtqkEUu6WudW84QKbgm
	 BzWPOT4VPfk0vfk72NQY7hJm43EjKGFJt2MMmGSJZ4nERu2gp4lN0GDRTREePNiz0y
	 2Dg0cFqiZTkD1QoU3llLDLVyOLb6lhpyH7cjuC+Yi2NLXrjUxVey0el3O4GlbKG8Mt
	 P2fIsGMuBvrUg==
Date: Wed, 29 Jul 2026 15:57:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <jtpctss4hz3djqd4ukq634ujfk5jdud6c6r6apgo2syrsubqz2@jivsombtim3v>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>

On Tue, Jul 14, 2026 at 10:41:07AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value. This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.
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

Use BIT(10) please.

> +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c

Is it possible to define individual bits?

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

Why is this delay at the start of this function?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45837EFEB;
	Thu, 16 Jul 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219753; cv=none; b=giE7bwgHSoVg9ElAQ/Mgz0ajmHbMLy5lQu1B4iSV5qtYKkBUmlkmc2o9X1If0BpQ4yq8asIdvocmm02HtttXsnfHVzXg+HlLlZ39ISYcKgauUGk3511dm8kZwzicEHY4I4zQ2Jo9AzdV1nyWSAn627Gs/ewwTajUgWCOjIrqFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219753; c=relaxed/simple;
	bh=VBgYNWr+xhl30hX7sT6gu6rlxKkHg46uvohcoyhzXB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDlxRBKDM7fdSYEHNU/I8itmie3yUsigh6P00afeM6RLavpyPJs+PJVnS2/CAm5Ep/0RL1rAqRu4CR8oVyiR/brnQHjeSzzOhE6gSgycetgYBPx0elbWOSefB30laA98vwnlHX3m6WDKtwVsiC80ydbc0abrO7vSdqXMFhr3tn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/pHE01+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/pHE01+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAF61F000E9;
	Thu, 16 Jul 2026 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219745;
	bh=tCDBpM2pxxYPqmtXE+cmuwq5digT5TckD0bD8zDphms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/pHE01+zdOY3q1W2i+xz50QzXIAaRgLB3kol79iC9rBehwWm+hJObG89HvR2XCug
	 8PyHl6tfTaZPeL/KRpY/RuKOZeX2UK4n4CiynVWymrR4Kpq3xzbdUuUNZ4hga1p/8N
	 ObR/s+2mdqZbZ3b15eoKwGMGFQSfapfC3Ypc0nM4k94dwazLogQDx8ulA5FhpJ3wdB
	 hzTF+96NshnBfdI7cY0sr3m698hmIAmAzh+AJFojNv2yqS99W9WeNAe851245oI/Ud
	 dIx3kzT/DbJejo+s4rKRraNZ8jaiAiNSzNEmTEydApwdjNdSl90a7V1GMizA0VOc1C
	 FJvzepiVes6Nw==
Date: Thu, 16 Jul 2026 18:35:27 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <afwyhy7npuvtecdbuzaytazbifu2ytb6admq4xbzbmxwx47vpq@wrc5dp62mtng>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>

On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> sequence.
> 
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
> 

What is the timing requirement here?

> Fix this by separating the two concerns:
> 
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>   logically belongs with reset operations. This ensures PHY power state
>   is managed as part of the core reset sequence.
> 
> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>   shared PHY power management, avoiding code duplication.
> 
> - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
>   (REF_CLK_EN) control, simplifying its purpose.
> 
> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>   proper sequencing is now handled by the core_reset functions.
> 
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
> 

This patch does too many things at once. Can't you split it and keep the minimal
fix in one patch?

- Mani

> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> Changes in v2:
> Regarding sashiko's reivew, invoke imx_pcie_assert_core_reset() explicitly
> in error path of imx_pcie_host_init() and imx_pcie_host_exit().
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 45 ++++++++++++---------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9406bba36953f..53f3da6ab30d5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -680,21 +680,12 @@ static int imx_pcie_attach_pd(struct device *dev)
>  
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -		/*
> -		 * The async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * Add a ~10us delay here.
> -		 */
> -		usleep_range(10, 100);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -	} else {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	}
> +	if (enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
>  
>  	return 0;
>  }
> @@ -823,23 +814,25 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>  
> -static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> -			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> -	if (!assert)
> -		usleep_range(200, 500);
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
>  
>  	return 0;
>  }
>  
> -static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> +	imx6q_pcie_core_reset(imx_pcie, assert);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> +			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
>  	if (!assert)
> -		return 0;
> -
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +		usleep_range(200, 500);
>  
>  	return 0;
>  }
> @@ -1445,6 +1438,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  
>  err_phy_off:
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	phy_power_off(imx_pcie->phy);
>  err_phy_exit:
>  	phy_exit(imx_pcie->phy);
> @@ -1471,6 +1465,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  			dev_err(pci->dev, "unable to power off PHY\n");
>  		phy_exit(imx_pcie->phy);
>  	}
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	imx_pcie_clk_disable(imx_pcie);
>  
>  	pci_pwrctrl_power_off_devices(pci->dev);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

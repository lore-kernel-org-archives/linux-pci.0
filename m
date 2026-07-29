Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B3218845;
	Wed, 29 Jul 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332905; cv=none; b=I/JwgZtOGROwvUmG1rRJSYE1zNbrz2cZU2O0qedTdrFycol1vUvAG5W1Wm6yicbomhQR3ro0OFPfit7R9AGHyUG3W270LVn6RCTyYHFDtoh3Uji6I1UdaIkH+I/A5onVh/Nas7fbgkvWn0wiAjAfCRh5S7Nnzho/ZVt7/yEexCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332905; c=relaxed/simple;
	bh=xXWeXmydDOnCGA6/U3Nv8VUH3B+h687MgGFA5GwTQNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kzue22qNmg3bsMpSEbC2y077vC6cdWDkPuLZnsPun7E9LafFJPn+xxRYETJbaEsuf+M9jvTpBfbjQZtIAWD9Nm1cUdlaYYHBYEq6ZeShVD6rLJQ4GLCBzQpT56ZZcCfm01dJoyqoReLBmOjOOUCkIbL4TKvutKRhvGGaYwn2tKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L61Hi7dD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L61Hi7dD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C631F00A3A;
	Wed, 29 Jul 2026 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785332899;
	bh=kyojuna+gSuZEOI/cfi95FUi4M08Pmq9uCdIlfbSH0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L61Hi7dDeF7F4483NpWDJma4aHnpb8RSTNjzzFjLSI4CR93eBDA4IucrFSB5Z80z3
	 /p9kDQpKZtgxLu+1IPWl2aVN8txvV/wZ/opEaEHzBB58LXYXXJvmG4NT1AmWg0agd7
	 NvGHSr4JUVjOUkGYOkbcDnS8la7A4Y3HPwoPnfzCqlBMZ+XUh831+K5/1IkjYNuQ+S
	 Xo7QL0k/MvhCb1S6Cl5v4hffSB0Evw1ZXD8z2ihb2/8Gb6pJ+mBey3XJKCGgJRDo0o
	 v70KfI9sF8yLkWLEhvI+z5ZEMMxWPSs98pUKXg17MrBkCOemOoA+fdk9VfE9AvGP3D
	 eU8DaIDgsimKw==
Date: Wed, 29 Jul 2026 15:48:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: wangjia@ultrarisc.com
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Message-ID: <2n44tfzw26mfis3nvnre2fph4u2whns5xgxvdmcczyfebt6gt2@ln53o5bi773e>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>

On Tue, Jul 14, 2026 at 09:11:03AM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
> 
> Add the required core, dbi, and aux clocks for the DP1000 PCIe
> controller and enable them before initializing the DesignWare host.
> 
> Also manage the clocks across system suspend and resume.
> 
> Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/pci/controller/dwc/pcie-ultrarisc.c | 102 ++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> index 6ee661ceff67..72ba5840b62d 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -23,6 +24,12 @@
>  
>  #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
>  
> +struct ultrarisc_pcie {
> +	struct dw_pcie pci;
> +	struct clk_bulk_data clks[3];
> +	bool clks_enabled;
> +};
> +
>  static struct pci_ops ultrarisc_pci_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read32,
> @@ -98,17 +105,66 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = ultrarisc_pcie_start_link,
>  };
>  
> +static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
> +{
> +	int ret;
> +
> +	if (ultra->clks_enabled)
> +		return 0;
> +

This check looks redundant and I don't see a need for the 'clks_enabled' flag.
Just do:

	return clk_bulk_prepare_enable();

> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> +	if (ret)
> +		return ret;
> +
> +	ultra->clks_enabled = true;
> +
> +	return 0;
> +}
> +
> +static void ultrarisc_pcie_disable_clks(void *data)
> +{
> +	struct ultrarisc_pcie *ultra = data;
> +
> +	if (!ultra->clks_enabled)
> +		return;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> +	ultra->clks_enabled = false;

Same here.

> +}
> +
> +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> +{
> +	struct device *dev = ultra->pci.dev;
> +	int ret;
> +
> +	ultra->clks[0].id = "core";
> +	ultra->clks[1].id = "dbi";
> +	ultra->clks[2].id = "aux";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);

Use devm_clk_bulk_get_all()

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> +
> +	ret = ultrarisc_pcie_enable_clks(ultra);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
> +
> +	return devm_add_action_or_reset(dev, ultrarisc_pcie_disable_clks, ultra);
> +}
> +
>  static int ultrarisc_pcie_probe(struct platform_device *pdev)
>  {
> +	struct ultrarisc_pcie *ultra;
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie_rp *pp;
>  	struct dw_pcie *pci;
>  	int ret;
>  
> -	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> -	if (!pci)
> +	ultra = devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);
> +	if (!ultra)
>  		return -ENOMEM;
>  
> +	pci = &ultra->pci;
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> @@ -117,7 +173,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
>  
>  	pp = &pci->pp;
>  
> -	platform_set_drvdata(pdev, pci);
> +	platform_set_drvdata(pdev, ultra);
> +
> +	ret = ultrarisc_pcie_init_clks(ultra);
> +	if (ret)
> +		return ret;
>  
>  	pp->num_vectors = MAX_MSI_IRQS;
>  	/* No L2/L3 Ready indication is available on this platform */
> @@ -135,16 +195,44 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
>  
>  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
>  {
> -	struct dw_pcie *pci = dev_get_drvdata(dev);
> +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &ultra->pci;
> +	int ret;
> +
> +	if (pci->suspended) {
> +		ultrarisc_pcie_disable_clks(ultra);
> +		return 0;
> +	}

Same as above. This looks redundant. Actually, it is wrong too as there cannot
be more than one suspend callback invocations.

- Mani


-- 
மணிவண்ணன் சதாசிவம்

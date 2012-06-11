Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33418 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2FKVWJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 17:22:09 -0400
Message-ID: <4FD6617C.4090805@wwwdotorg.org>
Date: Mon, 11 Jun 2012 15:22:04 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds a platform device driver for the PCIe controller on
> Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> converted and now initialize and register a corresponding platform
> device.

> -static int tegra_pcie_clocks_get(void)
> +static int tegra_pcie_clocks_get(struct tegra_pcie_info *pcie)
>  {
>  	int err;
>  
> -	tegra_pcie.pex_clk = clk_get(NULL, "pex");
> -	if (IS_ERR(tegra_pcie.pex_clk))
> -		return PTR_ERR(tegra_pcie.pex_clk);
> +	pcie->pex_clk = clk_get(NULL, "pex");
> +	if (IS_ERR(pcie->pex_clk))
> +		return PTR_ERR(pcie->pex_clk);

While we're changing this, can we convert this to devm_clk_get(), and ...

> -	tegra_pcie.regs = ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
> -	if (tegra_pcie.regs == NULL) {
> -		pr_err("PCIE: Failed to map PCI/AFI registers\n");
> +	regs = request_mem_region(regs->start, resource_size(regs), "PCI/AFI");
> +	if (regs == NULL) {
> +		dev_err(&pdev->dev, "failed to request PCI/AFI region: %d\n", err);
> +		goto err_req_reg;
> +	}
> +
> +	pcie->regs = ioremap_nocache(regs->start, resource_size(regs));
> +	if (pcie->regs == NULL) {
> +		dev_err(&pdev->dev, "failed to map PCI/AFI registers\n");
>  		err = -ENOMEM;
>  		goto err_map_reg;
>  	}

... that to devm_request_and_ioremap(). That would allow a bunch of the
cleanup code to be deleted rather than just modified.

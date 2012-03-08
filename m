Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47957 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab2CHVOn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 16:14:43 -0500
Message-ID: <4F59213F.6070107@wwwdotorg.org>
Date: Thu, 08 Mar 2012 14:14:39 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 07:51 AM, Thierry Reding wrote:
> This commit adds support for message signaled interrupts to the Tegra
> PCIe controller.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> This code is taken from the NVIDIA Vibrante kernel and therefore has no
> appropriate Signed-off-by from the original author. Maybe someone at
> NVIDIA can find out who wrote this code and maybe provide a proper
> Signed-off-by that I can add?

I think if you look in:
git://nv-tegra.nvidia.com/linux-2.6.git android-tegra-2.6.36

the following commits are what you're after:

de7fd8768b32da66eaf4eaf58473c65f7a76808d
arm: tegra: pcie: enabling MSI support for pcie

ac1f8310811c64a084511d2afc27f66334b31a81
ARM: tegra: pcie: fix return value from MSI irq routine

Although the patch below only partially resembles those patches, I guess
because you've rewritten the code a lot to conform to the current kernel
APIs, clean stuff up, etc. Perhaps just saying "based on code by Krishna
Kishore <kthota@nvidia.com>" is enough...

> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c

> +static int tegra_pcie_enable_msi(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
> +	volatile void *pages;
> +	unsigned long base;
> +	unsigned int msi;
> +	int msi_base;
> +	int err;
> +	u32 reg;
> +
> +	mutex_init(&pcie->msi_lock);
> +
> +	msi_base = irq_alloc_descs(-1, 0, INT_PCI_MSI_NR, 0);
> +	if (msi_base < 0) {
> +		dev_err(&pdev->dev, "failed to allocate IRQs\n");
> +		return msi_base;
> +	}
> +
> +	pcie->msi_domain = irq_domain_add_legacy(pcie->dev->of_node,
> +						 INT_PCI_MSI_NR, msi_base,
> +						 0, &irq_domain_simple_ops,
> +						 NULL);
> +	if (!pcie->msi_domain) {
> +		dev_err(&pdev->dev, "failed to create IRQ domain\n");

Free the IRQ descriptors in the error paths?

> +		return -ENOMEM;
> +	}
> +
> +	pcie->msi_chip.name = "PCIe-MSI";
> +	pcie->msi_chip.irq_enable = unmask_msi_irq;
> +	pcie->msi_chip.irq_disable = mask_msi_irq;
> +	pcie->msi_chip.irq_mask = mask_msi_irq;
> +	pcie->msi_chip.irq_unmask = unmask_msi_irq;
> +
> +	for (msi = 0; msi < INT_PCI_MSI_NR; msi++) {
> +		unsigned int irq = irq_find_mapping(pcie->msi_domain, msi);
> +
> +		irq_set_chip_data(irq, pcie);
> +		irq_set_chip_and_handler(irq, &pcie->msi_chip,
> +					 handle_simple_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +
> +	err = platform_get_irq(pdev, 1);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);

Same here, and undo setting IRQF_VALID?

> +		return err;
> +	}
...

> +static int tegra_pcie_disable_msi(struct platform_device *pdev)
> +{
> +	return 0;
> +}

This is empty in both the ifdef(CONFIG_PCI_MSI) case and otherwise. It
should probably clean everything up here right?

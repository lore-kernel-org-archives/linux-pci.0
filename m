Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50371 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab2FKVT5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 17:19:57 -0400
Message-ID: <4FD660F9.7030807@wwwdotorg.org>
Date: Mon, 11 Jun 2012 15:19:53 -0600
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
Subject: Re: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds support for message signaled interrupts to the Tegra
> PCIe controller. Based on code by Krishna Kishore <kthota@nvidia.com>.

> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c

> +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
...
> +			irq = irq_find_mapping(pcie->msi->domain, index);
> +			if (irq) {
> +				if (test_bit(index, pcie->msi->used))
> +					generic_handle_irq(irq);

This invokes the handler first ...

...
> +			/* clear the interrupt */
> +			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
> +			/* see if there's any more pending in this vector */
> +			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);

... then clears the interrupt status in the PCIe controller. Won't that
lose interrupts if one is raised between when the handler clears the
root-cause, and when this code clears the received interrupt status?

> +static int tegra_pcie_disable_msi(struct platform_device *pdev)

Should this free pcie->msi->pages?

Why allocate pcie->msi separately; why not include the fields directly
into struct tegra_pcie_info *pcie?

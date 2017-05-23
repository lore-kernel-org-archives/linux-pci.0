Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967265AbdEWT71 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:59:27 -0400
Date: Tue, 23 May 2017 14:59:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra: Support MSI 64-bit addressing
Message-ID: <20170523195925.GF7241@bhelgaas-glaptop.roam.corp.google.com>
References: <20170504201032.32633-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170504201032.32633-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 04, 2017 at 10:10:31PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The MSI target address can reside beyond the 32-bit boundary on devices
> with more than 2 GiB of system memory. The PCI host bridge on Tegra can
> easily support 64-bit addresses, so make sure to pass the upper 32 bits
> of the target address to endpoints when allocating MSI entries.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied both with Stephen's ack to pci/host-tegra for v4.13, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index ecf8b4f1bf05..e69f828a9ab2 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -235,6 +235,7 @@ struct tegra_msi {
>  	struct irq_domain *domain;
>  	unsigned long pages;
>  	struct mutex lock;
> +	u64 phys;
>  	int irq;
>  };
>  
> @@ -1468,9 +1469,8 @@ static int tegra_msi_setup_irq(struct msi_controller *chip,
>  
>  	irq_set_msi_desc(irq, desc);
>  
> -	msg.address_lo = virt_to_phys((void *)msi->pages);
> -	/* 32 bit address only */
> -	msg.address_hi = 0;
> +	msg.address_lo = lower_32_bits(msi->phys);
> +	msg.address_hi = upper_32_bits(msi->phys);
>  	msg.data = hwirq;
>  
>  	pci_write_msi_msg(irq, &msg);
> @@ -1519,7 +1519,6 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_msi *msi = &pcie->msi;
>  	struct device *dev = pcie->dev;
> -	unsigned long base;
>  	int err;
>  	u32 reg;
>  
> @@ -1553,10 +1552,10 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  
>  	/* setup AFI/FPCI range */
>  	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> -	base = virt_to_phys((void *)msi->pages);
> +	msi->phys = virt_to_phys((void *)msi->pages);
>  
> -	afi_writel(pcie, base >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
> -	afi_writel(pcie, base, AFI_MSI_AXI_BAR_ST);
> +	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
> +	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
>  	/* this register is in 4K increments */
>  	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
>  
> -- 
> 2.12.0
> 

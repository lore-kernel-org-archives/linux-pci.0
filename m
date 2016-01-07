Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46714 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbcAGAKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 19:10:51 -0500
Date: Wed, 6 Jan 2016 18:10:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ray Jui <rjui@broadcom.com>,
	Vikram Prakash <vikramp@broadcom.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: iproc: fix msi driver selection
Message-ID: <20160107001046.GA7083@localhost>
References: <1541985.1Jq5kHC7MS@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1541985.1Jq5kHC7MS@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 03:57:53PM +0100, Arnd Bergmann wrote:
> The newly added MSI support for iproc causes a link error when its
> Kconfig option is disabled:
> 
> ERROR: "iproc_msi_exit" [drivers/pci/host/pcie-iproc.ko] undefined!
> ERROR: "iproc_msi_init" [drivers/pci/host/pcie-iproc.ko] undefined!
> 
> This changes the header file so we use stub functions whenever
> the driver is not built, even when CONFIG_MSI is enabled.
> 
> As the Kconfig logic for the driver is a bit off, I'm rectifying
> that as well, by making it depend on the specific drivers that
> call into the driver, and moving the option behind those instead
> of before them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 610894347cbf ("PCI: iproc: Add iProc PCIe MSI support")

Applied with Ray's Reviewed-by to pci/host-iproc for v4.5, thanks!

Actually, since 610894347cbf hasn't been merged upstream yet, I just
squashed this fix into it and updated "pci/host-iproc" and "next".

> ---
> Found on ARM randconfig builds a couple of days ago
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 490476e172fd..d7c05894af70 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -124,15 +124,6 @@ config PCIE_IPROC
>  	  iProc family of SoCs. An appropriate bus interface driver needs
>  	  to be enabled to select this.
>  
> -config PCIE_IPROC_MSI
> -	bool "Broadcom iProc PCIe MSI support"
> -	depends on ARCH_BCM_IPROC && PCI_MSI
> -	select PCI_MSI_IRQ_DOMAIN
> -	default ARCH_BCM_IPROC
> -	help
> -	  Say Y here if you want to enable MSI support for Broadcom's iProc
> -	  PCIe controller
> -
>  config PCIE_IPROC_PLATFORM
>  	tristate "Broadcom iProc PCIe platform bus driver"
>  	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> @@ -154,6 +145,16 @@ config PCIE_IPROC_BCMA
>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
>  	  through the BCMA bus interface
>  
> +config PCIE_IPROC_MSI
> +	bool "Broadcom iProc PCIe MSI support"
> +	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
> +	depends on PCI_MSI
> +	select PCI_MSI_IRQ_DOMAIN
> +	default ARCH_BCM_IPROC
> +	help
> +	  Say Y here if you want to enable MSI support for Broadcom's iProc
> +	  PCIe controller
> +
>  config PCIE_ALTERA
>  	bool "Altera PCIe controller"
>  	depends on ARM || NIOS2
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index 6def23a7eb54..e84d93c53c7b 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -79,7 +79,7 @@ struct iproc_pcie {
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>  int iproc_pcie_remove(struct iproc_pcie *pcie);
>  
> -#ifdef CONFIG_PCI_MSI
> +#ifdef CONFIG_PCIE_IPROC_MSI
>  int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
>  void iproc_msi_exit(struct iproc_pcie *pcie);
>  #else
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

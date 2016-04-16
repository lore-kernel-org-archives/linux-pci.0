Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40247 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcDPXdZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2016 19:33:25 -0400
Date: Sun, 17 Apr 2016 09:33:21 +1000
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: select PCI_MSI_IRQ_DOMAIN
Message-ID: <20160416233321.GC15763@verge.net.au>
References: <1460837798-1239513-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460837798-1239513-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 16, 2016 at 10:15:46PM +0200, Arnd Bergmann wrote:
> The R-CAR PCIe driver requires the use of irq domains for its
> MSI code:
> 
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_msi_irq':
> drivers/pci/host/pcie-rcar.c:635:9: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
> drivers/pci/host/pcie-rcar.c: In function 'rcar_msi_setup_irq':
> drivers/pci/host/pcie-rcar.c:666:8: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_enable_msi':
> drivers/pci/host/pcie-rcar.c:725:16: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
> drivers/pci/host/pcie-rcar.c:725:14: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>   msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
>               ^
> drivers/pci/host/pcie-rcar.c:762:2: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
> 
> This ensures that the feature is always enabled by adding a
> Kconfig select statement. This is not consistent with what the
> other drivers do at the moment, but I have another patch that
> changes them to do it like this one, which is more logical.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This seems reasonable to me:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 169c545bf70a..6d642aa390b0 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -72,6 +72,8 @@ config PCI_RCAR_GEN2
>  config PCI_RCAR_GEN2_PCIE
>  	bool "Renesas R-Car PCIe controller"
>  	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> +	select PCI_MSI
> +	select PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
>  
> -- 
> 2.7.0
> 

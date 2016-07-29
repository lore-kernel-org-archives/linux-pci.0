Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53076 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbcG2WeU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jul 2016 18:34:20 -0400
Date: Fri, 29 Jul 2016 17:34:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <niklas.cassel@axis.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: artpec: add PCI_MSI_IRQ_DOMAIN dependency
Message-ID: <20160729223415.GB13632@localhost>
References: <20160706124640.1521466-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160706124640.1521466-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 06, 2016 at 02:46:04PM +0200, Arnd Bergmann wrote:
> The designware PCIe driver requires MSI support, so we get a warning
> for the artpec6 glue driver if that is not enabled:
> 
> warning: (PCIE_ARTPEC6) selects PCIE_DW which has unmet direct dependencies (PCI && PCI_MSI_IRQ_DOMAIN)
> 
> This adds the same dependency that all other such drivers have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to pci/host-artpec with Niklas's ack for v4.8.

> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c917e2fede05..a1ef0c06dbb4 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -258,6 +258,7 @@ config PCIE_ARMADA_8K
>  config PCIE_ARTPEC6
>  	bool "Axis ARTPEC-6 PCIe controller"
>  	depends on MACH_ARTPEC6
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW
>  	select PCIEPORTBUS
>  	help
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

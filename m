Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:57976 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbcGMXLh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jul 2016 19:11:37 -0400
Subject: Re: [PATCH] PCI: artpec: add PCI_MSI_IRQ_DOMAIN dependency
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
References: <20160706124640.1521466-1-arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <70a4d4da-e6b6-570a-d1d4-6ed4295e8cf5@axis.com>
Date: Thu, 14 Jul 2016 01:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160706124640.1521466-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Niklas Cassel <niklas.cassel@axis.com>


On 07/06/2016 02:46 PM, Arnd Bergmann wrote:
> The designware PCIe driver requires MSI support, so we get a warning
> for the artpec6 glue driver if that is not enabled:
>
> warning: (PCIE_ARTPEC6) selects PCIE_DW which has unmet direct dependencies (PCI && PCI_MSI_IRQ_DOMAIN)
>
> This adds the same dependency that all other such drivers have.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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


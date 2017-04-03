Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdDCVSj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Apr 2017 17:18:39 -0400
Date: Mon, 3 Apr 2017 16:18:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: dwc: hisi needs PCI_HOST_COMMON
Message-ID: <20170403211835.GD13232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170321143229.3372903-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321143229.3372903-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 03:32:11PM +0100, Arnd Bergmann wrote:
> Without PCI_HOST_COMMON support enabled, we get a link error:
> 
> drivers/pci/dwc/built-in.o: In function `hisi_pcie_map_bus':
> pcie-hisi.c:(.text+0x8860): undefined reference to `pci_ecam_map_bus'
> drivers/pci/dwc/built-in.o: In function `hisi_pcie_almost_ecam_probe':
> pcie-hisi.c:(.text+0x88b4): undefined reference to `pci_host_common_probe'
> 
> This adds an explicit 'select', as the other users have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied with Jingoo's ack to for-linus for v4.11, since this got broken in
the v4.11 merge window.

> ---
>  drivers/pci/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index dfb8a69afc28..d2d2ba5b8a68 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -89,6 +89,7 @@ config PCI_HISI
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIEPORTBUS
>  	select PCIE_DW_HOST
> +	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want PCIe controller support on HiSilicon
>  	  Hip05 and Hip06 SoCs
> -- 
> 2.9.0
> 

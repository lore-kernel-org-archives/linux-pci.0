Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756185AbeARNp2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jan 2018 08:45:28 -0500
Date: Thu, 18 Jan 2018 13:46:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>, vigneshr@ti.com, kishon@ti.com,
        niklas.cassel@axis.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: dra7xx: add back CONFIG_PCI dependency for
 endpoint
Message-ID: <20180118134631.GA11777@red-moon>
References: <20180118131612.871559-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118131612.871559-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 02:15:54PM +0100, Arnd Bergmann wrote:
> It was a nice idea to split out the PCI host and endpoint mode configuration
> into separate options. Unfortunately it doesn't build:
> 
> drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)

It is two series tripping over each others in my pci/dwc branch and the
kbuild bot did not manage to test the merged result with a config that
fails - so here we go.

Niklas, Vignesh, Kishon, is this the way you want to get this fixed ?

Otherwise please send a patch asap on top of my pci/dwc branch.

Thanks,
Lorenzo

> This is certainly a fixable problem, but since it's clear that this
> configuration was never tested, let's maybe revert back to the
> dependency for now, until it can be done in a way that works
> better.
> 
> Fixes: b052835c6385 ("PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 0fb96c7754de..540419527a92 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
>  config PCI_DRA7XX_EP
>  	bool "TI DRA7xx PCIe controller Endpoint Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on PCI_ENDPOINT
> +	depends on PCI && PCI_ENDPOINT
>  	depends on OF && HAS_IOMEM && TI_PIPE3
>  	select PCIE_DW_EP
>  	select PCI_DRA7XX
> -- 
> 2.9.0
> 

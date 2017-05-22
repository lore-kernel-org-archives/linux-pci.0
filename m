Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934403AbdEVWA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 18:00:59 -0400
Date: Mon, 22 May 2017 17:00:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: dwc: dra7xx: Depend on appropriate SoC or compile
 test
Message-ID: <20170522220056.GF19733@bhelgaas-glaptop.roam.corp.google.com>
References: <20170515122617.20706-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170515122617.20706-1-pbrobinson@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 01:26:17PM +0100, Peter Robinson wrote:
> The PCI controller attached to a SoC isn't much use if the core SoC isn't
> enabled, unless of course it's compile testing, so add appropriate dependency.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to pci/host-dra7xx for v4.13, thanks!

Kishon, let me know if you object.  I think I'll start speculatively
applying simple patches without maintainer acks to try to streamline
things, on the assumption that you'll speak up if you object.

> ---
>  drivers/pci/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index b7e15526d676..d34b6dfbb351 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -16,6 +16,7 @@ config PCIE_DW_EP
>  
>  config PCI_DRA7XX
>  	bool "TI DRA7xx PCIe controller"
> +	depends on SOC_DRA7XX || COMPILE_TEST
>  	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
>  	depends on OF && HAS_IOMEM && TI_PIPE3
>  	help
> -- 
> 2.13.0
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdCPUUN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Mar 2017 16:20:13 -0400
Date: Thu, 16 Mar 2017 15:20:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Mason <jon.mason@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH] PCI: iproc: Add PCI_DOMAIN dependency to PCI Kconfig
Message-ID: <20170316202009.GD9739@bhelgaas-glaptop.roam.corp.google.com>
References: <1488383593-31666-1-git-send-email-jon.mason@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488383593-31666-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 01, 2017 at 10:53:13AM -0500, Jon Mason wrote:
> From: Jon Mason <jonmason@broadcom.com>
> 
> 2+ PCI devices fail to be discovered due to each bus having the same
> PCI domain.  This is because the domain defined in the device tree file
> is not being added due to PCI_DOMAIN not being enabled.  So, every PCI
> bus has a domain of zero.  When PCI_DOMAIN is selected by the Kconfig,
> it picks-up the domain defined in the device tree file and everything
> works as expected.
> 
> Since both PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA need PCI_DOMAIN,
> moving it to PCIE_IPROC (so it can be automatically selected for both).
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

Applied to pci/host-iproc for v4.12, thanks, Jon!

> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 898d2c4..82496b6 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -165,6 +165,7 @@ config PCI_VERSATILE
>  
>  config PCIE_IPROC
>  	tristate
> +	select PCI_DOMAINS
>  	help
>  	  This enables the iProc PCIe core controller support for Broadcom's
>  	  iProc family of SoCs. An appropriate bus interface driver needs
> @@ -185,7 +186,6 @@ config PCIE_IPROC_BCMA
>  	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
>  	select PCIE_IPROC
>  	select BCMA
> -	select PCI_DOMAINS
>  	default ARCH_BCM_5301X
>  	help
>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
> -- 
> 2.7.4
> 

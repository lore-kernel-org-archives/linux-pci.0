Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38150 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbbKXV3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 16:29:37 -0500
Date: Tue, 24 Nov 2015 15:29:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com.com>,
	zajec5@gmail.com
Subject: Re: [PATCH] PCI: iproc: hide CONFIG_PCIE_IPROC
Message-ID: <20151124212934.GD17377@localhost>
References: <11420214.lrdhuUq0ZO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11420214.lrdhuUq0ZO@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 17, 2015 at 05:08:33PM +0100, Arnd Bergmann wrote:
> PCIE_IPROC_BCMA does not require CONFIG_OF in Kconfig, but
> CONFIG_PCIE_IPROC does, so we can get a warning when building
> for an ARM platform without DT support:
> 
> warning: (PCIE_IPROC_PLATFORM && PCIE_IPROC_BCMA) selects PCIE_IPROC which has unmet direct dependencies (PCI && OF && (ARM || ARM64))
> 
> It turns out that CONFIG_PCIE_IPROC never needs to be enabled
> by a user anyway, we can simply rely on it being selected
> implictly through either PCIE_IPROC_PLATFORM or PCIE_IPROC_BCMA.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4785ffbdc9b5 ("PCI: iproc: Add BCMA PCIe driver")

Applied with Hauke's ack to pci/host-iproc for v4.5, thanks!

> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f131ba947dc6..767605a5c659 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -118,13 +118,11 @@ config PCI_VERSATILE
>  	depends on ARCH_VERSATILE
>  
>  config PCIE_IPROC
> -	tristate "Broadcom iProc PCIe controller"
> -	depends on OF && (ARM || ARM64)
> -	default n
> +	tristate
>  	help
>  	  This enables the iProc PCIe core controller support for Broadcom's
> -	  iProc family of SoCs. An appropriate bus interface driver also needs
> -	  to be enabled
> +	  iProc family of SoCs. An appropriate bus interface driver needs
> +	  to be enabled to select this.
>  
>  config PCIE_IPROC_PLATFORM
>  	tristate "Broadcom iProc PCIe platform bus driver"
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

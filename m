Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41146 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbcDESK6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 14:10:58 -0400
Date: Tue, 5 Apr 2016 13:10:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
Message-ID: <20160405181054.GB15353@localhost>
References: <1459384523-16146-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459384523-16146-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On Thu, Mar 31, 2016 at 09:35:23AM +0900, Simon Horman wrote:
> It appears that Gen2 is a misnomer for the R-Car PCIE driver
> which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> from the help text and Kconfig symbol.
> 
> Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> This appears to be in keeping with other PCIE Kconfig symbols.
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Bjorn, if this patch is acceptable I would like to request that we
> co-ordinate things so that I can queue-up corresponding updates for
> arm and arm64 defconfigs in the same release. From my point of view
> v4.7 would make sense.

I'm fine with this.  What sort of coordination do you want to do?
It would probably be nice to combine this patch with the defconfig updates
so we don't have a bisection problem.  If you want to include this patch
and merge through another tree,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> v2
> * As suggested by Geert Uytterhoeven:
>   - Use PCIE as prefix in Kconfig symbol
> ---
>  drivers/pci/host/Kconfig  | 4 ++--
>  drivers/pci/host/Makefile | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7a0780d56d2d..8fb1cf54617d 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -69,11 +69,11 @@ config PCI_RCAR_GEN2
>  	  There are 3 internal PCI controllers available with a single
>  	  built-in EHCI/OHCI host controller present on each one.
>  
> -config PCI_RCAR_GEN2_PCIE
> +config PCIE_RCAR
>  	bool "Renesas R-Car PCIe controller"
>  	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
>  	help
> -	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
> +	  Say Y here if you want PCIe controller support on R-Car SoCs.
>  
>  config PCI_HOST_COMMON
>  	bool
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index d85b5faf9bbc..d3d8e1b36fb9 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>  obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
> -obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
> +obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
>  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

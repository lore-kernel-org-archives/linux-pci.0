Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55478 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbcCKSIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 13:08:30 -0500
Date: Fri, 11 Mar 2016 12:08:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
Message-ID: <20160311180826.GB4725@localhost>
References: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 09:45:56AM +0900, Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> 
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied with Geert's ack to pci/host-rcar for v4.6, thanks, Simon!

> ---
>  drivers/pci/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
>  Based on the next branch of the pci tree
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 75a605426538..dcf4d5a349ca 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -41,7 +41,7 @@ config PCI_TEGRA
>  config PCI_RCAR_GEN2
>  	bool "Renesas R-Car Gen2 Internal PCI controller"
>  	depends on ARM
> -	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	help
>  	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
>  	  There are 3 internal PCI controllers available with a single
> @@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
>  
>  config PCI_RCAR_GEN2_PCIE
>  	bool "Renesas R-Car PCIe controller"
> -	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> +	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
>  
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

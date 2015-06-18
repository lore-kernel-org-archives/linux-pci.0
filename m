Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35572 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbbFRQ77 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 12:59:59 -0400
Received: by iefd2 with SMTP id d2so2396218ief.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 09:59:58 -0700 (PDT)
Date: Thu, 18 Jun 2015 11:59:54 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm@kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 10/15] PCI: kill off set_irq_flags usage
Message-ID: <20150618165954.GE7710@google.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-11-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1433874401-27161-11-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 01:26:36PM -0500, Rob Herring wrote:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

This is the only part of the series on linux-pci, so I assume this will be
merged by somebody else along with the rest.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/host/pci-dra7xx.c      | 1 -
>  drivers/pci/host/pci-keystone-dw.c | 2 --
>  drivers/pci/host/pci-tegra.c       | 1 -
>  drivers/pci/host/pcie-designware.c | 1 -
>  drivers/pci/host/pcie-rcar.c       | 1 -
>  drivers/pci/host/pcie-xilinx.c     | 2 --
>  6 files changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 2d57e19..94cbc4d 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -160,7 +160,6 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index f34892e..f1d0749 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -196,7 +196,6 @@ static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>  	irq_set_chip_and_handler(irq, &ks_dw_pcie_msi_irq_chip,
>  				 handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> @@ -277,7 +276,6 @@ static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
>  	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
>  				 handle_level_irq);
>  	irq_set_chip_data(irq, d->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 00e9272..36bd700 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1263,7 +1263,6 @@ static int tegra_msi_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &tegra_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	tegra_cpuidle_pcie_irqs_in_use();
>  
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2e9f84f..5caa94d 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -333,7 +333,6 @@ static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index c086210..7678fe0 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -664,7 +664,6 @@ static int rcar_msi_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index f1a06a0..72015119 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -338,7 +338,6 @@ static int xilinx_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &xilinx_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> @@ -377,7 +376,6 @@ static int xilinx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>  
>  	return 0;
>  }
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

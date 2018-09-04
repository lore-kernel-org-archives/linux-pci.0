Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeIDSON (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 14:14:13 -0400
Date: Tue, 4 Sep 2018 08:48:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Message-ID: <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2018 at 09:09:40PM +0530, Bharat Kumar Gogada wrote:
> Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
> register platform provided IRQ number to kernel AER service.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index fb32840..285647b 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -22,6 +22,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
>  
>  /* Bridge core config registers */
>  #define BRCFG_PCIE_RX0			0x00000000
> @@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  	return 0;
>  }
>  
> +int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
> +			   int plat_mask)
> +{
> +	struct nwl_pcie *pcie;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
> +		plat_mask &= ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
> +	}

If I understand correctly, this ultimately results in pcie->irq_misc
being hooked up to aer_irq() via the aer_probe() path.  We already
have pcie->irq_misc being hooked up to nwl_pcie_misc_handler() via
nwl_pcie_bridge_init().

We can't rely on the ordering of the two handlers.  Is it safe if
nwl_pcie_misc_handler() runs first, followed by aer_irq()?  It looks
like nwl_pcie_misc_handler() might log messages and clear AER-related
errors.  If that's the case aer_irq() might not find anything to do.

> +
> +	return plat_mask;
> +}
> +
>  static const struct of_device_id nwl_pcie_of_match[] = {
>  	{ .compatible = "xlnx,nwl-pcie-2.11", },
>  	{}
> @@ -880,6 +895,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  	bridge->ops = &nwl_pcie_ops;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		err = nwl_pcie_enable_msi(pcie);
> -- 
> 1.7.1
> 

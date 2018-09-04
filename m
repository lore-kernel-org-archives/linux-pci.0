Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbeIDShq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 14:37:46 -0400
Date: Tue, 4 Sep 2018 09:12:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Message-ID: <20180904141227.GD107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2018 at 09:09:39PM +0530, Bharat Kumar Gogada wrote:
> Platforms may have dedicated IRQ lines for PCIe services like
> AER/PME etc., check for such IRQ lines.
> Check mask and fill legacy irq line for services other than

Capitalize "IRQ" consistently in English text like this.

Insert blank lines between paragraphs.

Add a reference to the relevant spec sections.  PCIe r4.0, sec
6.2.4.1.2, 6.2.6, 7.5.3.12 seem pertinent.

> platform supported service IRQ number.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e0261ad..a7d024c 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -166,6 +166,19 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  		irqs[i] = -1;
>  
>  	/*
> +	 * Some platforms have dedicated interrupt line from root complex to
> +	 * interrupt controller for PCIe services like AER/PME etc., check
> +	 * if platform registered with any such IRQ.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		int plat_mask;
> +
> +		plat_mask = pci_check_platform_service_irqs(dev, irqs, mask);
> +		if (plat_mask > 0)

Masks should be unsigned and tested for zero or "mask & bit".  The
rest of this file uses "int", which is sloppy because it does the
wrong thing if we happen to use the high-order bit in the mask.

> +			mask = mask & plat_mask;
> +	}

I think these platform IRQs are neither MSI-X/MSI nor PCI INTx wires.
But as written, I think this patch executes pcie_port_enable_irq_vec(),
which only does MSI-X/MSI stuff.  So this must rely on that failing?

And then we fall through to run pci_alloc_irq_vectors(), which is for
PCI INTx interrupts, which doesn't seem appropriate either.

It seems like this platform IRQ case should be completely separated
from the other MSI/INTx cases, i.e., set
irqs[PCIE_PORT_SERVICE_AER_SHIFT] directly (I think you already do
this inside pci_check_platform_service_irqs()) and immediately return.
Then I think you wouldn't need the other hunk below.

> +
> +	/*
>  	 * If we support PME but can't use MSI/MSI-X for it, we have to
>  	 * fall back to INTx or other interrupts, e.g., a system shared
>  	 * interrupt.
> @@ -183,8 +196,10 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if (ret < 0)
>  		return -ENODEV;
>  
> -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> -		irqs[i] = pci_irq_vector(dev, 0);
> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> +		if (mask & (1 << i))
> +			irqs[i] = pci_irq_vector(dev, 0);
> +	}
>  
>  	return 0;
>  }
> -- 
> 1.7.1
> 

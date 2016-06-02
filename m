Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39948 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbcFBDsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jun 2016 23:48:33 -0400
Date: Wed, 1 Jun 2016 22:48:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Roy Zang <roy.zang@nxp.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Mingkai Hu <mingkai.hu@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160602034828.GA10240@localhost>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rob]

Hi Po,

On Thu, May 26, 2016 at 02:00:06PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file.

My understanding is that AER interrupt signaling can be done via INTx,
MSI, or MSI-X (PCIe spec r3.0, sec 6.2.4.1.2).  Apparently your device
doesn't support MSI or MSI-X.  Are you saying it doesn't support INTx
either?  How is the interrupt you're requesting here different from
INTx?

My guess is that your device *does* support INTx, and we should use
that.  ACPI has the generic _PRT that describes INTx routing.  There
must be something similar for DT, but I don't know what it is.  It
seems like this should be described using that DT mechanism (whatever
it is), and we shouldn't need special-case code in the portdrv code.

> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 32d4d0a..64833e5 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/pcieport_if.h>
>  #include <linux/aer.h>
> +#include <linux/of_irq.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -199,6 +200,28 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
>  static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  {
>  	int i, irq = -1;
> +	int ret;
> +	struct device_node *np = NULL;
> +
> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> +		irqs[i] = 0;
> +
> +	if (dev->bus->dev.of_node)
> +		np = dev->bus->dev.of_node;
> +
> +	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
> +	 * request irq for aer
> +	 */
> +	if (IS_ENABLED(CONFIG_OF_IRQ) && np &&
> +			(mask & PCIE_PORT_SERVICE_PME)) {
> +		ret = of_irq_get_byname(np, "aer");
> +		if (ret > 0) {
> +			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
> +			if (dev->irq)
> +				irq = dev->irq;
> +			goto no_msi;
> +		}
> +	}
>  
>  	/*
>  	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
> @@ -224,11 +247,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  		irq = dev->irq;
>  
>   no_msi:
> -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> -		irqs[i] = irq;
> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> +		if (!irqs[i])
> +			irqs[i] = irq;
> +	}
>  	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
>  
> -	if (irq < 0)
> +	if (irq < 0 && irqs[PCIE_PORT_SERVICE_AER_SHIFT] < 0)
>  		return -ENODEV;
>  	return 0;
>  }
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

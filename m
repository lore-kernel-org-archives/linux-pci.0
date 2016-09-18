Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754857AbcIRAw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Sep 2016 20:52:28 -0400
Date: Sun, 18 Sep 2016 08:52:12 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160918005212.GF15478@tiger>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
 <1473741659-17618-3-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 12:40:59PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>

Will the new kernel work with existing/old DTB?  I'm trying to
understand the dependency between driver and DTS changes.

Shawn

> ---
> changes for v5:
> 	- Add clear 'aer' interrup-names description
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     | 11 +++++---
>  drivers/pci/pcie/portdrv_core.c                    | 31 +++++++++++++++++++---
>  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 41e9f55..101d0a7 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -18,8 +18,10 @@ Required properties:
>  - reg: base addresses and lengths of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +- interrupt-names: It may be include the following entries:
> +  "aer": The interrupt that is asserted for aer interrupt
> +  "pme": The interrupt that is asserted for pme interrupt
> +  ......
>  - fsl,pcie-scfg: Must include two entries.
>    The first entry must be a link to the SCFG device node
>    The second entry must be '0' or '1' based on physical PCIe controller index.
> @@ -35,8 +37,9 @@ Example:
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> -		interrupt-names = "intr";
> +		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer interrupt */
> +			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme interrupt */
> +		interrupt-names = "aer", "pme";
>  		fsl,pcie-scfg = <&scfg 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e9270b4..7c4943d 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/pcieport_if.h>
>  #include <linux/aer.h>
> +#include <linux/of_irq.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -200,6 +201,28 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
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
> @@ -225,11 +248,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
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

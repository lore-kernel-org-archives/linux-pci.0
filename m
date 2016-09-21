Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 21 Sep 2016 17:37:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160921223741.GG20006@localhost>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
 <1473741659-17618-3-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 12:40:59PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
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

We definitely need to solve this somehow.  But this approach doesn't
feel quite right because it's hard to map this code back to anything
in the spec, and it uses a completely platform-dependent name
("interrupt-names aer") in code that is supposedly generic.

What if we added some sort of hook that would return the IRQ?  Maybe a
pcibios_*() hook right now, with the idea of making it a
pci_host_bridge function pointer someday?

I know the body of the hook would look a lot like what you have here,
but at least it would be more obvious that it's platform-specific
code.

I think your platform supports PME interrupts as well as AER, and
they're different IRQs.  So you'd probably have to do something
similar to the pcie_port_enable_msix() interface, so you can fill in
both IRQs.

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

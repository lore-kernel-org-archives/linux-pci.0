Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Jun 2016 08:54:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v2 2/2] pci/aer: interrupt fixup in the quirk
Message-ID: <20160616135420.GA31343@localhost>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465884747-1517-1-git-send-email-po.liu@nxp.com>
 <1465884747-1517-2-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465884747-1517-2-git-send-email-po.liu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 02:12:27PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for V2:
> 	- Move to the quirk file
> 
>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ee72ebe..909d479 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

Is there any possibility of this part being used on different arches,
or will it only ever be on arm64 (or whatever it is)?  If the latter,
it could go somewhere like arch/arm64/kernel/quirks.c (which doesn't
exist yet).

> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
>  #include <linux/mm.h>
> +#include <linux/of_irq.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -4419,3 +4420,25 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> +
> +/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
> + * but use standalone irq. Read the device tree for the aer
> + * interrupt number.
> + */
> +static void quirk_aer_interrupt(struct pci_dev *dev)
> +{
> +	int ret;
> +	struct device_node *np = NULL;
> +
> +	if (dev->bus->dev.of_node)
> +		np = dev->bus->dev.of_node;
> +
> +	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
> +		ret = of_irq_get_byname(np, "aer");
> +		if (ret > 0) {
> +			dev->no_msi = 1;
> +			dev->irq = ret;
> +		}
> +	}

What does this mean for the other PCIe services, e.g., PME?  I
guess this makes the existing AER code work unchanged.  But I thought
PME had a similar situation and was connected up to a different
interrupt than AER was.

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_aer_interrupt);
> -- 
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

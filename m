Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:18134 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142AbcGDIqt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 04:46:49 -0400
Subject: Re: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
To: Po Liu <po.liu@nxp.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-2-git-send-email-po.liu@nxp.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"Marc Zyngier" <marc.zyngier@arm.com>,
	Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Linuxarm <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <577A21E4.1030301@huawei.com>
Date: Mon, 4 Jul 2016 16:44:20 +0800
MIME-Version: 1.0
In-Reply-To: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Po

I found a problem with the similar patch. as the below log.

[    4.287060] pci 0000:80:00.0: quirk_aer_interrupt dev->irq 416
[    4.293778] pcieport 0000:80:00.0: pci_device_probe in
[    4.299605] pcieport 0000:80:00.0: of_irq_parse_pci() failed with rc=-22
[    4.307209] pcieport 0000:80:00.0: init_service_irqs  dev->irq 0

The fucntions are called as below sequence.
1. quirk_aer_interrupt, get the aer dev->irq 416.
2. pci_device_probe->of_irq_parse_pci, of_irq_parse_pci() failed, then dev->irq changed to 0.

So this patch could not work with aer.

Thanks
Dongdong
ÔÚ 2016/6/14 16:24, Po Liu Ð´µÀ:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.
>
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for V3:
> 	- Move to quirk;
> 	- Only correct the irq in RC mode;
>
>   drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ee72ebe..8b39cce 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -25,6 +25,7 @@
>   #include <linux/sched.h>
>   #include <linux/ktime.h>
>   #include <linux/mm.h>
> +#include <linux/of_irq.h>
>   #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>   #include "pci.h"
>
> @@ -4419,3 +4420,31 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>   	}
>   }
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> +
> +/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
> + * but use standalone irq. Read the device tree for the aer
> + * interrupt number.
> + */
> +static void quirk_aer_interrupt(struct pci_dev *dev)
> +{
> +	int ret;
> +	u8 header_type;
> +	struct device_node *np = NULL;
> +
> +	/* Only for the RC mode device */
> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
> +	if ((header_type & 0x7F) != PCI_HEADER_TYPE_BRIDGE)
> +		return;
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
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_aer_interrupt);
>



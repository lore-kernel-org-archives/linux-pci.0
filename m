Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:39467 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbcGFImH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 04:42:07 -0400
Subject: Re: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
To: Po Liu <po.liu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <577A21E4.1030301@huawei.com>
 <VI1PR0401MB1709D556D0A7F7BB9188221E92390@VI1PR0401MB1709.eurprd04.prod.outlook.com>
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
Message-ID: <577CC37B.9070806@huawei.com>
Date: Wed, 6 Jul 2016 16:38:19 +0800
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB1709D556D0A7F7BB9188221E92390@VI1PR0401MB1709.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Po

在 2016/7/5 11:03, Po Liu 写道:
> Hi Dongdong,
>
> The patch were intend to fixup the NXP layerscape serial SOC and were tested ok.
> I am not clear what platform are you trying to fix.

My platform is an ARM64 platform, PCIe host controller also use Synopsys Designware.

> The problem on your board may be as below comments:
>
>
>>   -----Original Message-----
>>   From: Dongdong Liu [mailto:liudongdong3@huawei.com]
>>   Sent: Monday, July 04, 2016 4:44 PM
>>   To: Po Liu; linux-pci@vger.kernel.org; linux-arm-
>>   kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>   devicetree@vger.kernel.org
>>   Cc: Bjorn Helgaas; Shawn Guo; Marc Zyngier; Rob Herring; Roy Zang;
>>   Mingkai Hu; Stuart Yoder; Yang-Leo Li; Arnd Bergmann; Minghuan Lian;
>>   Murali Karicheri; Linuxarm
>>   Subject: Re: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
>>
>>   Hi Po
>>
>>   I found a problem with the similar patch. as the below log.
>>
>>   [    4.287060] pci 0000:80:00.0: quirk_aer_interrupt dev->irq 416
>>   [    4.293778] pcieport 0000:80:00.0: pci_device_probe in
>>   [    4.299605] pcieport 0000:80:00.0: of_irq_parse_pci() failed with
>>   rc=-22
>>   [    4.307209] pcieport 0000:80:00.0: init_service_irqs  dev->irq 0
>>
>>   The fucntions are called as below sequence.
>>   1. quirk_aer_interrupt, get the aer dev->irq 416.
>
> This code quirk_aer_interrupt() should be run at pci_fixup_device(pci_fixup_final) which is in the pci_bus_add_devices()

Yes, you are right.

>
>>   2. pci_device_probe->of_irq_parse_pci, of_irq_parse_pci() failed, then
>>   dev->irq changed to 0.
>
> pci_device_probe->of_irq_parse_pci which in the pci_scan_child_bus() run before  pci_bus_add_devices(). See dw_pcie_host_init().
> Apparently , your quirk_aer_interrupt() is running before the dev->irq assignment in the of_irq_parse_pci().
>
> So make sure your configure the quirk_aer_interrupt() run in the FINAL stage in the quirk.c OR check your host driver which you are using.

Yes , It is FINAL stage in the quirk. I use DECLARE_PCI_FIXUP_FINAL.
I find it is the below patch affect this. (https://patchwork.kernel.org/patch/9170333/),
but the patch will be applied to linux 4.8. So the problem will also be existed.

ARM64: PCI: ACPI support for legacy IRQs parsing and consolidation with DT code
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index d5d3d26..b3b8a2c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -51,11 +51,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
  }

  /*
- * Try to assign the IRQ number from DT when adding a new device
+ * Try to assign the IRQ number when probing a new device
   */
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
  {
-   dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+ if (acpi_disabled)
+         dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#ifdef CONFIG_ACPI
+ else
+         return acpi_pci_irq_enable(dev);
+#endif

         return 0;
  }

Thanks
Dongdong
>
>
>>
>>   So this patch could not work with aer.
>>
>>   Thanks
>>   Dongdong
>>   在 2016/6/14 16:24, Po Liu 写道:
>>   > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
>>   > When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
>>   > maybe there is interrupt line for aer pme etc. Search the interrupt
>>   > number in the fdt file. Then fixup the dev->irq with it.
>>   >
>>   > Signed-off-by: Po Liu <po.liu@nxp.com>
>>   > ---
>>   > changes for V3:
>>   > 	- Move to quirk;
>>   > 	- Only correct the irq in RC mode;
>>   >
>>   >   drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++
>>   >   1 file changed, 29 insertions(+)
>>   >
>>   > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
>>   > ee72ebe..8b39cce 100644
>>   > --- a/drivers/pci/quirks.c
>>   > +++ b/drivers/pci/quirks.c
>>   > @@ -25,6 +25,7 @@
>>   >   #include <linux/sched.h>
>>   >   #include <linux/ktime.h>
>>   >   #include <linux/mm.h>
>>   > +#include <linux/of_irq.h>
>>   >   #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>>   >   #include "pci.h"
>>   >
>>   > @@ -4419,3 +4420,31 @@ static void quirk_intel_qat_vf_cap(struct
>>   pci_dev *pdev)
>>   >   	}
>>   >   }
>>   >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
>>   > quirk_intel_qat_vf_cap);
>>   > +
>>   > +/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
>>   > + * but use standalone irq. Read the device tree for the aer
>>   > + * interrupt number.
>>   > + */
>>   > +static void quirk_aer_interrupt(struct pci_dev *dev) {
>>   > +	int ret;
>>   > +	u8 header_type;
>>   > +	struct device_node *np = NULL;
>>   > +
>>   > +	/* Only for the RC mode device */
>>   > +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
>>   > +	if ((header_type & 0x7F) != PCI_HEADER_TYPE_BRIDGE)
>>   > +		return;
>>   > +
>>   > +	if (dev->bus->dev.of_node)
>>   > +		np = dev->bus->dev.of_node;
>>   > +
>>   > +	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
>>   > +		ret = of_irq_get_byname(np, "aer");
>>   > +		if (ret > 0) {
>>   > +			dev->no_msi = 1;
>>   > +			dev->irq = ret;
>>   > +		}
>>   > +	}
>>   > +}
>>   > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
>>   > +quirk_aer_interrupt);
>>   >
>>
>
> �{.n�+�������+%��lzwm��b�맲��r��zX��\�)���w*jg��������ݢj/���z�ޖ��2�ޙ���&�)ߡ�a�����G���h��j:+v���w�٥
>


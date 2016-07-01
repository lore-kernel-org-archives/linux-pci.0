Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Po Liu <po.liu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v2 2/2] pci/aer: interrupt fixup in the quirk
Date: Fri, 1 Jul 2016 08:46:31 +0000
Message-ID: <VI1PR0401MB1709A82B3C59528D0953259892250@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465884747-1517-1-git-send-email-po.liu@nxp.com>
 <1465884747-1517-2-git-send-email-po.liu@nxp.com>
 <20160616135420.GA31343@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Roy Zang <roy.zang@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

So could we keep it in the pci/quirk.c ? 
If yes, I would only move the binding description in the documentation into this driver the next version.

>  -----Original Message-----
>  From: Po Liu
>  Sent: Friday, June 17, 2016 11:31 AM
>  To: 'Bjorn Helgaas'
>  Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Bjorn Helgaas;
>  Shawn Guo; Marc Zyngier; Rob Herring; Roy Zang; Mingkai Hu; Stuart Yoder;
>  Yang-Leo Li; Arnd Bergmann; Minghuan Lian; Murali Karicheri
>  Subject: RE: [PATCH v2 2/2] pci/aer: interrupt fixup in the quirk
>  
>  
>  
>  >  -----Original Message-----
>  >  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>  >  Sent: Thursday, June 16, 2016 9:54 PM
>  >  To: Po Liu
>  >  Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>  >  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Bjorn
>  > Helgaas;  Shawn Guo; Marc Zyngier; Rob Herring; Roy Zang; Mingkai Hu;
>  > Stuart Yoder;  Yang-Leo Li; Arnd Bergmann; Minghuan Lian; Murali
>  > Karicheri
>  >  Subject: Re: [PATCH v2 2/2] pci/aer: interrupt fixup in the quirk
>  >
>  >  On Tue, Jun 14, 2016 at 02:12:27PM +0800, Po Liu wrote:
>  >  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC
>  mode.
>  >  > When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
>  > > maybe there is interrupt line for aer pme etc. Search the interrupt
>  > > number in the fdt file. Then fixup the dev->irq with it.
>  >  >
>  >  > Signed-off-by: Po Liu <po.liu@nxp.com>  > ---  > changes for V2:
>  >  > 	- Move to the quirk file
>  >  >
>  >  >  drivers/pci/quirks.c | 23 +++++++++++++++++++++++  >  1 file
>  > changed, 23 insertions(+)  >  > diff --git a/drivers/pci/quirks.c
>  > b/drivers/pci/quirks.c index  > ee72ebe..909d479 100644  > ---
>  > a/drivers/pci/quirks.c  > +++ b/drivers/pci/quirks.c
>  >
>  >  Is there any possibility of this part being used on different arches,
>  > or  will it only ever be on arm64 (or whatever it is)?  If the latter,
>  > it  could go somewhere like arch/arm64/kernel/quirks.c (which doesn't
>  > exist  yet).
>  
>  NXP Layerscape1 is base on the arm 32bit design. Also need the fixup.
>  
>  >
>  >  > @@ -25,6 +25,7 @@
>  >  >  #include <linux/sched.h>
>  >  >  #include <linux/ktime.h>
>  >  >  #include <linux/mm.h>
>  >  > +#include <linux/of_irq.h>
>  >  >  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  >  >  #include "pci.h"
>  >  >
>  >  > @@ -4419,3 +4420,25 @@ static void quirk_intel_qat_vf_cap(struct
>  > pci_dev *pdev)
>  >  >  	}
>  >  >  }
>  >  >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,  >
>  > quirk_intel_qat_vf_cap);  > +  > +/* If root port doesn't support
>  > MSI/MSI-X/INTx in RC mode,  > + * but use standalone irq. Read the
>  > device tree for the aer  > + * interrupt number.
>  >  > + */
>  >  > +static void quirk_aer_interrupt(struct pci_dev *dev) {
>  >  > +	int ret;
>  >  > +	struct device_node *np = NULL;
>  >  > +
>  >  > +	if (dev->bus->dev.of_node)
>  >  > +		np = dev->bus->dev.of_node;
>  >  > +
>  >  > +	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
>  >  > +		ret = of_irq_get_byname(np, "aer");
>  >  > +		if (ret > 0) {
>  >  > +			dev->no_msi = 1;
>  >  > +			dev->irq = ret;
>  >  > +		}
>  >  > +	}
>  >
>  >  What does this mean for the other PCIe services, e.g., PME?  I guess
>  > this makes the existing AER code work unchanged.  But I thought PME
>  > had  a similar situation and was connected up to a different interrupt
>  > than  AER was.
>  
>  Yes, PME is similar, HP is not support. I think better to disable the
>  PME service irq in the quirk.
>  But seems it is no use because quirk fixup is only running in init phase
>  time(except suspend, resume).
>  
>  >
>  >  > +}
>  >  > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,  >
>  > +quirk_aer_interrupt);  > --  > 2.1.0.27.g96db324  >  > --  > To
>  > unsubscribe from this list: send the line "unsubscribe linux-pci"
>  >  > in the body of a message to majordomo@vger.kernel.org More
>  > majordomo  > info at  http://vger.kernel.org/majordomo-info.html
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
Date: Wed, 21 Sep 2016 06:51:55 +0000
Message-ID: <VI1PR0401MB170983489310BF383C8C7E5B92F60@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <20160729224154.GC13632@localhost>
 <VI1PR0401MB170958461E597D1BC7D280FF92E80@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160920204725.GA10804@localhost>
In-Reply-To: <20160920204725.GA10804@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, "M.H.
 Lian" <minghuan.lian@nxp.com>, Murali Karicheri <m-karicheri2@ti.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

>  -----Original Message-----
>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>  Sent: Wednesday, September 21, 2016 4:47 AM
>  To: Po Liu
>  Cc: Roy Zang; Arnd Bergmann; devicetree@vger.kernel.org; Marc Zyngier;
>  linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Stuart Yoder;
>  M.H. Lian; Murali Karicheri; Mingkai Hu; Bjorn Helgaas; Leo Li; Shawn
>  Guo; linux-arm-kernel@lists.infradead.org
>  Subject: Re: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
>  
>  On Mon, Aug 22, 2016 at 10:09:18AM +0000, Po Liu wrote:
>  > Hi Bjorn,
>  >
>  > Sorry for late reply.
>  >
>  > I checked the updated kernel with Dongdong mentioned ACPI patch which
>  was truly affected my quirk patch uploaded. So I suppose the quirk patch
>  is not qualify to fix the bug.
>  
>  I don't understand what you're saying here.
>  
>  The quirk worked on your machine.  It apparently didn't work on
>  Dongdong's machine because of_irq_parse_and_map_pci() is run after the
>  quirk in this path:
>  
>    pci_device_probe
>      pcibios_alloc_irq                 # arm64
>        dev->irq = of_irq_parse_and_map_pci
>  
>  and of_irq_parse_and_map_pci() returned zero, probably because
>  of_irq_parse_pci() failed.  My guess is that the reason it works on your
>  machine but not Dongdong's is that your DTs are different such that
>  of_irq_parse_pci() works for you but not for Dongdong.
>  
>  I think the idea of of_irq_parse_and_map_pci() is to set up a device's
>  INTx line.  But that doesn't quite apply here because your device
>  doesn't actually *use* INTx.  So I don't know why of_irq_parse_pci()
>  works for you.  Maybe that's a symptom of a problem in your DT.
>  
>  Or maybe you're saying that the quirk *didn't* work on your machine when
>  you tested it in a kernel that included d8ed75d59332 ("ARM64:
>  PCI: ACPI support for legacy IRQs parsing and consolidation with DT
>  code"). 

Yes, this point is what I mean. After this patch my quirk patch would not work. 
Since I discussed with Dongdong, the patches d8ed75d59332 ACPI related were not be merged yet.


>  But that doesn't make sense either, because prior to
>  d8ed75d59332, we *always* set
>  
>    dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>  
>  and after the patch we only do it if "acpi_disabled".  I guess I just
>  don't understand what you're saying.

Before the patch merged. pcibios_add_device()(which run the ->irq = of_irq_parse_and_map_pci(dev, 0, 0);) was loaded before the pci_fixup_device(pci_fixup_final). 
But after the patch d8ed75d59332("ARM64: PCI: ACPI support for legacy IRQs parsing and consolidation with DT code") merged, the pci_fixup_device(pci_fixup_final) run BEFORE the pcibios_alloc_irq()(which run the ->irq = of_irq_parse_and_map_pci(dev, 0, 0);). So the dev->irq were overwhelm by the pcibios_alloc_irq().

When I test, the acpi_disabled is '1' although my kernel config default is CONFIG_ACPI=y. And no setting in the uboot with apci=xxx. But this is another issue, I didn't deep to check it. 

>  
>  > I were keep thinking what your "explicitly checking for a root port
>  device" meaning. Do you mean I should upload again the first version
>  patch which fix it in the portdrv_core.c ? I would upload again if yes.
>  
>  No, I did not mean you should go back to the first version of the patch.
>  If we *can* do this in a quirk, I think that would be much better than
>  doing it in the PCIe port driver.  I meant that Dongdong's suggestion of
>  adding this:
>  
>    if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
>      return;
>  
>  to your quirk made sense to me.

If the quirk patch could make workaround. It should be the better way.

Po Liu

>  
>  > >  -----Original Message-----
>  > >  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>  > >  Sent: Saturday, July 30, 2016 6:42 AM
>  > >  To: Po Liu
>  > >  Cc: linux-pci@vger.kernel.org;
>  > > linux-arm-kernel@lists.infradead.org;
>  > >  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Roy Zang;
>  > > Arnd  Bergmann; Marc Zyngier; Stuart Yoder; Yang-Leo Li; Minghuan
>  > > Lian; Murali  Karicheri; Bjorn Helgaas; Shawn Guo; Mingkai Hu
>  > >  Subject: Re: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
>  > >
>  > >  On Tue, Jun 14, 2016 at 04:24:05PM +0800, Po Liu wrote:
>  > >  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC
>  mode.
>  > >  > When chip support the aer interrupt with none MSI/MSI-X/INTx
>  > > mode,  > maybe there is interrupt line for aer pme etc. Search the
>  > > interrupt  > number in the fdt file. Then fixup the dev->irq with it.
>  > >  >
>  > >  > Signed-off-by: Po Liu <po.liu@nxp.com>
>  > >
>  > >  I'm not sure where we're at with this.  Dongdong had some issue
>  > > (possibly with a version of the quirk on a different platform?), and
>  > > I  think the suggestion of explicitly checking for a root port
>  > > device was a  good one.
>  > >
>  > >  So please update and repost this for next cycle.
>  > >
>  > >  > ---
>  > >  > changes for V3:
>  > >  > 	- Move to quirk;
>  > >  > 	- Only correct the irq in RC mode;
>  > >  >
>  > >  >  drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++  >  1
>  > > file changed, 29 insertions(+)  >  > diff --git
>  > > a/drivers/pci/quirks.c b/drivers/pci/quirks.c index  >
>  > > ee72ebe..8b39cce 100644  > --- a/drivers/pci/quirks.c  > +++
>  > > b/drivers/pci/quirks.c  > @@ -25,6 +25,7 @@  >  #include
>  > > <linux/sched.h>  >  #include <linux/ktime.h>  >  #include
>  > > <linux/mm.h>  > +#include <linux/of_irq.h>
>  > >  >  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  > >  >  #include "pci.h"
>  > >  >
>  > >  > @@ -4419,3 +4420,31 @@ static void quirk_intel_qat_vf_cap(struct
>  > > pci_dev *pdev)
>  > >  >  	}
>  > >  >  }
>  > >  >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,  >
>  > > quirk_intel_qat_vf_cap);  > +  > +/* If root port doesn't support
>  > > MSI/MSI-X/INTx in RC mode,  > + * but use standalone irq. Read the
>  > > device tree for the aer  > + * interrupt number.
>  > >  > + */
>  > >  > +static void quirk_aer_interrupt(struct pci_dev *dev) {
>  > >  > +	int ret;
>  > >  > +	u8 header_type;
>  > >  > +	struct device_node *np = NULL;
>  > >  > +
>  > >  > +	/* Only for the RC mode device */
>  > >  > +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
>  > >  > +	if ((header_type & 0x7F) != PCI_HEADER_TYPE_BRIDGE)
>  > >  > +		return;
>  > >  > +
>  > >  > +	if (dev->bus->dev.of_node)
>  > >  > +		np = dev->bus->dev.of_node;
>  > >  > +
>  > >  > +	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
>  > >  > +		ret = of_irq_get_byname(np, "aer");
>  > >  > +		if (ret > 0) {
>  > >  > +			dev->no_msi = 1;
>  > >  > +			dev->irq = ret;
>  > >  > +		}
>  > >  > +	}
>  > >  > +}
>  > >  > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,  >
>  > > +quirk_aer_interrupt);  > --  > 2.1.0.27.g96db324  >  >  >
>  > > _______________________________________________
>  > >  > linux-arm-kernel mailing list
>  > >  > linux-arm-kernel@lists.infradead.org
>  > >  > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>  > _______________________________________________
>  > linux-arm-kernel mailing list
>  > linux-arm-kernel@lists.infradead.org
>  > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Jun 2016 23:09:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Po Liu <po.liu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Message-ID: <20160603040952.GA17904@localhost>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <20160602034828.GA10240@localhost>
 <VI1PR0401MB1709E215DCE264B2C27B3DAB92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160602135546.GA8262@localhost>
 <575052B8.3090203@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575052B8.3090203@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 11:37:28AM -0400, Murali Karicheri wrote:
> On 06/02/2016 09:55 AM, Bjorn Helgaas wrote:
> > On Thu, Jun 02, 2016 at 05:01:19AM +0000, Po Liu wrote:
> >>>  -----Original Message-----
> >>>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >>>  Sent: Thursday, June 02, 2016 11:48 AM
> >>>  To: Po Liu
> >>>  Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >>>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Arnd Bergmann;
> >>>  Roy Zang; Marc Zyngier; Stuart Yoder; Yang-Leo Li; Minghuan Lian; Bjorn
> >>>  Helgaas; Shawn Guo; Mingkai Hu; Rob Herring
> >>>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
> >>>  MSI/MSI-X/INTx mode
> >>>  
> >>>  [+cc Rob]
> >>>  
> >>>  Hi Po,
> >>>  
> >>>  On Thu, May 26, 2016 at 02:00:06PM +0800, Po Liu wrote:
> >>>  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> >>>  > When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> >>>  > maybe there is interrupt line for aer pme etc. Search the interrupt
> >>>  > number in the fdt file.
> >>>  
> >>>  My understanding is that AER interrupt signaling can be done via INTx,
> >>>  MSI, or MSI-X (PCIe spec r3.0, sec 6.2.4.1.2).  Apparently your device
> >>>  doesn't support MSI or MSI-X.  Are you saying it doesn't support INTx
> >>>  either?  How is the interrupt you're requesting here different from INTx?
> >>
> >> Layerscape use none of MSI or MSI-X or INTx to indicate the devices
> >> or root error in RC mode. But use an independent SPI interrupt(arm
> >> interrupt controller) line.  
> > 
> > The Root Port is a PCI device and should follow the normal PCI rules
> > for interrupts.  As far as I understand, that means it should use MSI,
> > MSI-X, or INTx.  If your Root Port doesn't use MSI or MSI-X, it should
> > use INTx, the PCI_INTERRUPT_PIN register should tell us which (INTA/
> > INTB/etc.), and PCI_COMMAND_INTX_DISABLE should work to disable it.
> > That's all from the PCI point of view, of course.
> 
> I am faced with the same issue on Keystone PCI hardware and it has been
> on my TODO list  for quite some time. Keystone PCI hardware also doesn't
> use MSI or MSI-X or INTx for reporting errors received at the root port,
> but use a platform interrupt instead (not complaint to PCI standard as
> per PCI base spec). So I would need similar change to have the error
> interrupt passed to the aer driver. So there are hardware out there
> like Keystone which requires to support this through platform IRQ.

This is not a new area of the spec, and it's hard for me to believe
that these two new PCIe controllers are both broken the same way
(although I guess both are DesignWare-based, so maybe this is the same
underlying problem in both cases?).  I think it's more likely that we
just haven't figured out the right way to describe this in the DT.

I assume you have a Root Port with an AER capability, no MSI
capability, and no MSI-X capability, right?  What does its Interrupt
Pin register contain?  If it's zero, it doesn't use INTx either, so
according to the spec it should generate no interrupts.

But if Interrupt Pin is non-zero, that means the Root Port should be
able to generate virtual INTx interrupts.  Presumably the Root Complex
connects those interrupts to something; maybe to your platform
interrupt?

PCI doesn't say anything about an interrupt after it leaves the Root
Complex, so the fact that it's connected to a "platform interrupt" or
"SPI interrupt" or "IOAPIC interrupt" doesn't make it non-compliant.
Shouldn't we be able to use the interrupt-map and related DT
properties to express the fact that Root Port virtual INTx is routed
to platform interrupt Y, even without any special-case code in
portdrv?

> > What's on the other end of those interrupts is outside the scope of
> > PCI.  An INTx interrupt (either a conventional PCI wire or a PCIe
> > virtual INTx wire) might be connected to an IOAPIC, an ARM SPI, or
> > something else.  Drivers should not care about how it is connected,
> > and that's why I don't think this code really fits in portdrv.
> > 
> > Maybe your Root Port is non-compliant in some way and maybe we need a
> > quirk or something to work around that hardware defect.  But I'm not
> > convinced yet that we have that sort of problem.  It seems like we
> > just don't have the correct DT description.
> 
> Is quirk is what is suggested here to support this?

No, I don't understand the problem yet, so I'm not ready to suggest a
solution.

> >> And at same time, AER capability list
> >> in PCIe register descriptors. And also, The Root Error
> >> Command/status register was proper to enable/disable the AER
> >> interrupt.
> > 
> > I'm not sure what you're saying here.  Here's what I think you said;
> > please correct me if I'm wrong:
> > 
> >   - Your Root Port has an AER capability.
> > 
> >   - Your Root Port does not support MSI or MSI-X.  (This would
> >     actually be a spec violation because the PCIe spec r3.0, sec 7.7
> >     says "All PCI Express device Functions that are capable of
> >     generating interrupts must implement MSI or MSI-X or both.")
> >   
> >   - The three enable bits in the Root Error Command Register enable or
> >     disable generation of interrupts.  These enable bits control all
> >     interrupts, whether MSI, MSI-X, or INTx.
> > 
> >   - The Root Error Status Register contains an "Advanced Error
> >     Interrupt Message Number" field, but that's only applicable if MSI
> >     or MSI-X is enabled, and if your device doesn't support MSI or
> >     MSI-X, this field doesn't apply.
> > 
> >> This hardware implementation make sense in some platforms, and this
> >> was described in the function init_service_irqs() in the
> >> drivers/pci/pcie/portdrv_core.c in current kernel as:
> > 
> >>
> >> 241      * We're not going to use MSI-X, so try MSI and fall back to INTx.     
> >> 242      * If neither MSI/MSI-X nor INTx available, try other interrupt.  On  
> >> 243      * some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode
> >> 244      */                                                                             
> >>
> >> So I think this was the proper place to update the irq number before aer service
> >> driver was loaded.
> >>
> >>>  
> >>>  My guess is that your device *does* support INTx, and we should use that.
> >>>  ACPI has the generic _PRT that describes INTx routing.  There must be
> >>>  something similar for DT, but I don't know what it is.  It seems like
> >>>  this should be described using that DT mechanism (whatever it is), and
> >>>  we shouldn't need special-case code in the portdrv code.
> >>>  
> >>>  > Signed-off-by: Po Liu <po.liu@nxp.com>
> >>>  > ---
> >>>  >  drivers/pci/pcie/portdrv_core.c | 31 ++++++++++++++++++++++++++++---
> >>>  >  1 file changed, 28 insertions(+), 3 deletions(-)
> >>>  >
> >>>  > diff --git a/drivers/pci/pcie/portdrv_core.c
> >>>  > b/drivers/pci/pcie/portdrv_core.c index 32d4d0a..64833e5 100644
> >>>  > --- a/drivers/pci/pcie/portdrv_core.c
> >>>  > +++ b/drivers/pci/pcie/portdrv_core.c
> >>>  > @@ -15,6 +15,7 @@
> >>>  >  #include <linux/slab.h>
> >>>  >  #include <linux/pcieport_if.h>
> >>>  >  #include <linux/aer.h>
> >>>  > +#include <linux/of_irq.h>
> >>>  >
> >>>  >  #include "../pci.h"
> >>>  >  #include "portdrv.h"
> >>>  > @@ -199,6 +200,28 @@ static int pcie_port_enable_msix(struct pci_dev
> >>>  > *dev, int *vectors, int mask)  static int init_service_irqs(struct
> >>>  > pci_dev *dev, int *irqs, int mask)  {
> >>>  >  	int i, irq = -1;
> >>>  > +	int ret;
> >>>  > +	struct device_node *np = NULL;
> >>>  > +
> >>>  > +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> >>>  > +		irqs[i] = 0;
> >>>  > +
> >>>  > +	if (dev->bus->dev.of_node)
> >>>  > +		np = dev->bus->dev.of_node;
> >>>  > +
> >>>  > +	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
> >>>  > +	 * request irq for aer
> >>>  > +	 */
> >>>  > +	if (IS_ENABLED(CONFIG_OF_IRQ) && np &&
> >>>  > +			(mask & PCIE_PORT_SERVICE_PME)) {
> >>>  > +		ret = of_irq_get_byname(np, "aer");
> >>>  > +		if (ret > 0) {
> >>>  > +			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
> >>>  > +			if (dev->irq)
> >>>  > +				irq = dev->irq;
> >>>  > +			goto no_msi;
> >>>  > +		}
> >>>  > +	}
> >>>  >
> >>>  >  	/*
> >>>  >  	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
> >>>  @@
> >>>  > -224,11 +247,13 @@ static int init_service_irqs(struct pci_dev *dev,
> >>>  int *irqs, int mask)
> >>>  >  		irq = dev->irq;
> >>>  >
> >>>  >   no_msi:
> >>>  > -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> >>>  > -		irqs[i] = irq;
> >>>  > +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> >>>  > +		if (!irqs[i])
> >>>  > +			irqs[i] = irq;
> >>>  > +	}
> >>>  >  	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
> >>>  >
> >>>  > -	if (irq < 0)
> >>>  > +	if (irq < 0 && irqs[PCIE_PORT_SERVICE_AER_SHIFT] < 0)
> >>>  >  		return -ENODEV;
> >>>  >  	return 0;
> >>>  >  }
> >>>  > --
> >>>  > 2.1.0.27.g96db324
> >>>  >
> >>>  >
> >>>  > _______________________________________________
> >>>  > linux-arm-kernel mailing list
> >>>  > linux-arm-kernel@lists.infradead.org
> >>>  > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Murali Karicheri
> Linux Kernel, Keystone

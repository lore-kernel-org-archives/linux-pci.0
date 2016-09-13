Return-Path: <mayurkumar.patel@intel.com>
Return-Path: <mayurkumar.patel@intel.com>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Busch, Keith" <keith.busch@intel.com>,
	"Tarazona-Duarte, Luis Antonio" <luis.antonio.tarazona-duarte@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v2 1/8] PCI: pciehp: Rename pcie_isr() locals for clarity
Date: Tue, 13 Sep 2016 16:09:07 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B284665AD0A7@IRSMSX101.ger.corp.intel.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160912210855.22258.32643.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <92EBB4272BF81E4089A7126EC1E7B284665ABBDA@IRSMSX101.ger.corp.intel.com>
 <20160913135749.GA27748@localhost>
In-Reply-To: <20160913135749.GA27748@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> =

> On Tue, Sep 13, 2016 at 10:05:31AM +0000, Patel, Mayurkumar wrote:
> >
> > > Rename "detected" and "intr_loc" to "status" and "events" for clarity.
> > > "status" is the value we read from the Slot Status register; "events"=
 is
> > > the set of hot-plug events we need to process.  No functional change
> > > intended.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/hotplug/pciehp_hpc.c |   46 +++++++++++++++++++++-------=
----------
> > >  1 file changed, 25 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/p=
ciehp_hpc.c
> > > index 08e84d6..264df36 100644
> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > @@ -542,7 +542,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
> > >  	struct pci_bus *subordinate =3D pdev->subordinate;
> > >  	struct pci_dev *dev;
> > >  	struct slot *slot =3D ctrl->slot;
> > > -	u16 detected, intr_loc;
> > > +	u16 status, events;
> > >  	u8 present;
> > >  	bool link;
> > >
> > > @@ -555,31 +555,35 @@ static irqreturn_t pcie_isr(int irq, void *dev_=
id)
> > >  	 * serviced, we need to re-inspect Slot Status register after
> > >  	 * clearing what is presumed to be the last pending interrupt.
> > >  	 */
> > > -	intr_loc =3D 0;
> > > +	events =3D 0;
> > >  	do {
> > > -		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
> > > -		if (detected =3D=3D (u16) ~0) {
> > > +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> > > +		if (status =3D=3D (u16) ~0) {
> > >  			ctrl_info(ctrl, "%s: no response from device\n",
> > >  				  __func__);
> > >  			return IRQ_HANDLED;
> > >  		}
> > >
> > > -		detected &=3D (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> > > -			     PCI_EXP_SLTSTA_PDC |
> > > -			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
> > > -		detected &=3D ~intr_loc;
> > > -		intr_loc |=3D detected;
> > > -		if (!intr_loc)
> > > +		/*
> > > +		 * Slot Status contains plain status bits as well as event
> > > +		 * notification bits; right now we only want the event bits.
> > > +		 */
> > > +		status &=3D (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> > > +			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
> > > +			   PCI_EXP_SLTSTA_DLLSC);
> > > +		status &=3D ~events;
> > > +		events |=3D status;
> > > +		if (!events)
> > >  			return IRQ_NONE;
> > > -		if (detected)
> > > +		if (status)
> > >  			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> > > -						   intr_loc);
> > > -	} while (detected);
> > > +						   events);
> > > +	} while (status);
> > >
> > > -	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", intr_=
loc);
> > > +	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", event=
s);
> > >
> > >  	/* Check Command Complete Interrupt Pending */
> > > -	if (intr_loc & PCI_EXP_SLTSTA_CC) {
> > > +	if (events & PCI_EXP_SLTSTA_CC) {
> > >  		ctrl->cmd_busy =3D 0;
> > >  		smp_mb();
> > >  		wake_up(&ctrl->queue);
> > > @@ -589,24 +593,24 @@ static irqreturn_t pcie_isr(int irq, void *dev_=
id)
> > >  		list_for_each_entry(dev, &subordinate->devices, bus_list) {
> > >  			if (dev->ignore_hotplug) {
> > >  				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no ho=
tplug)\n",
> > > -					 intr_loc, pci_name(dev));
> > > +					 events, pci_name(dev));
> > >  				return IRQ_HANDLED;
> >
> > Does it make sense here also to return IRQ_NONE?
> =

> I don't think so.  Here's my reasoning; see if it makes sense:
> IRQ_NONE means "I don't see any indication that my device needs
> service."  If every handler for the IRQ returns IRQ_NONE, the
> interrupt was spurious, and if we see enough spurious interrupts,
> we'll disable that IRQ completely.  In this case, our device
> definitely *did* request service; it's just that a driver wants us to
> ignore hotplug events.  From the point of view of the kernel, we did
> handle the IRQ (by ignoring it and clearing the interrupt request).
> =


Yes it does. Thanks a lot for the clarifications.

> > >  			}
> > >  		}
> > >  	}
> > >
> > > -	if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
> > > +	if (!(events & ~PCI_EXP_SLTSTA_CC))
> > >  		return IRQ_HANDLED;
> > >
> > >  	/* Check Attention Button Pressed */
> > > -	if (intr_loc & PCI_EXP_SLTSTA_ABP) {
> > > +	if (events & PCI_EXP_SLTSTA_ABP) {
> > >  		ctrl_info(ctrl, "Button pressed on Slot(%s)\n",
> > >  			  slot_name(slot));
> > >  		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
> > >  	}
> > >
> > >  	/* Check Presence Detect Changed */
> > > -	if (intr_loc & PCI_EXP_SLTSTA_PDC) {
> > > +	if (events & PCI_EXP_SLTSTA_PDC) {
> > >  		pciehp_get_adapter_status(slot, &present);
> > >  		ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
> > >  			  present ? "" : "not ", slot_name(slot));
> > > @@ -615,13 +619,13 @@ static irqreturn_t pcie_isr(int irq, void *dev_=
id)
> > >  	}
> > >
> > >  	/* Check Power Fault Detected */
> > > -	if ((intr_loc & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected)=
 {
> > > +	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
> > >  		ctrl->power_fault_detected =3D 1;
> > >  		ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(slot));
> > >  		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
> > >  	}
> > >
> > > -	if (intr_loc & PCI_EXP_SLTSTA_DLLSC) {
> > > +	if (events & PCI_EXP_SLTSTA_DLLSC) {
> > >  		link =3D pciehp_check_link_active(ctrl);
> > >  		ctrl_info(ctrl, "slot(%s): Link %s event\n",
> > >  			  slot_name(slot), link ? "Up" : "Down");
> >
> > Intel Deutschland GmbH
> > Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> > Tel: +49 89 99 8853-0, www.intel.de
> > Managing Directors: Christin Eisenschmid, Christian Lamprechter
> > Chairperson of the Supervisory Board: Nicole Lau
> > Registered Office: Munich
> > Commercial Register: Amtsgericht Muenchen HRB 186928
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

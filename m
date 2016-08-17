Return-Path: <mayurkumar.patel@intel.com>
Return-Path: <mayurkumar.patel@intel.com>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "mika.westerberg@linux.intel.com"
	<mika.westerberg@linux.intel.com>, "Shevchenko, Andriy"
	<andriy.shevchenko@intel.com>, "Busch, Keith" <keith.busch@intel.com>,
	"Tarazona-Duarte, Luis Antonio" <luis.antonio.tarazona-duarte@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: RE: [PATCH v1] PCI: pciehp: Fix presence detect change interrupt
 handling
Date: Wed, 17 Aug 2016 22:37:13 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
 <20160817171225.GA27353@localhost>
 <CACK8Z6H2G1cA6W+7timaKdeK2wuPNQfdLeZQCx=C8VkBESUOfQ@mail.gmail.com>
 <20160817181459.GB27353@localhost>
In-Reply-To: <20160817181459.GB27353@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and Rajat
Thanks for replying.
 =

> Hi Rajat, thanks for chiming in!
> =

> On Wed, Aug 17, 2016 at 10:54:12AM -0700, Rajat Jain wrote:
> > On Wed, Aug 17, 2016 at 10:12 AM, Bjorn Helgaas <helgaas@kernel.org> wr=
ote:
> > >
> > > Hi Mayurkumar,
> > >
> > > On Wed, Aug 17, 2016 at 01:42:18PM +0000, Patel, Mayurkumar wrote:
> > > > Currently, if very fast hotplug removal and insertion event comes
> > > > as following
> > > >
> > > > [  608.823412] pciehp 0000:00:1c.1:pcie04: Card not present on Slot=
(1)
> > > > [  608.835249] pciehp 0000:00:1c.1:pcie04: Card present on Slot(1)
> > > >
> > > > In this case following scenario happens,
> > > >
> > > > While removal:
> > > > pcie_isr() -> pciehp_queue_interrupt_event() -> triggers queue_work=
().
> > > > work invokes interrupt_event_handler() -> case INT_PRESENCE_OFF
> > > > and calls handle_surprise_event().
> > > >
> > > > handle_surprise_event() again calls pciehp_get_adapter_status()
> > > > and reads slot status which might have been changed
> > > > already due to PCI_EXP_SLTSTA_PDC event for hotplug insertion
> > > > has happened. So it queues, ENABLE_REQ for both removal
> > > > and insertion interrupt based on latest slot status.
> > > >
> > > > In this case, PCIe device can not be hot-add again because
> > > > it was never removed due to which device can not get enabled.
> > > >
> > > > handle_surprise_event() can be removed and pciehp_queue_power_work()
> > > > can be directly triggered based on INT_PRESENCE_ON and INT_PRESENCE=
_OFF
> > > > from the switch case exist in interrupt_event_hanlder().
> > > >
> > > > The patch ensures the pciehp_queue_power_work() processes
> > > > presence detect change for removal and insertion correctly.
> > > >
> > > > Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> >
> > Acked-by: Rajat Jain <rajatxjain@gmail.com>
> >
> > >
> > > > ---
> > > >  Resending the patch addressing to PCI Maintainer Bjorn Helgaas.
> > > >
> > > >  drivers/pci/hotplug/pciehp_ctrl.c |   18 ++----------------
> > > >  1 file changed, 2 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplu=
g/pciehp_ctrl.c
> > > > index 880978b..87c5bea 100644
> > > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > > @@ -301,20 +301,6 @@ static void handle_button_press_event(struct s=
lot *p_slot)
> > > >  /*
> > > >   * Note: This function must be called with slot->lock held
> > > >   */
> > > > -static void handle_surprise_event(struct slot *p_slot)
> > > > -{
> > > > -     u8 getstatus;
> > > > -
> > > > -     pciehp_get_adapter_status(p_slot, &getstatus);
> > > > -     if (!getstatus)
> > > > -             pciehp_queue_power_work(p_slot, DISABLE_REQ);
> > > > -     else
> > > > -             pciehp_queue_power_work(p_slot, ENABLE_REQ);
> > > > -}
> > > > -
> > > > -/*
> > > > - * Note: This function must be called with slot->lock held
> > > > - */
> > > >  static void handle_link_event(struct slot *p_slot, u32 event)
> > > >  {
> > > >       struct controller *ctrl =3D p_slot->ctrl;
> > > > @@ -377,14 +363,14 @@ static void interrupt_event_handler(struct wo=
rk_struct *work)
> > > >               pciehp_green_led_off(p_slot);
> > > >               break;
> > > >       case INT_PRESENCE_ON:
> > > > -             handle_surprise_event(p_slot);
> > > > +             pciehp_queue_power_work(p_slot, ENABLE_REQ);
> > > >               break;
> > > >       case INT_PRESENCE_OFF:
> > > >               /*
> > > >                * Regardless of surprise capability, we need to
> > > >                * definitely remove a card that has been pulled out!
> > > >                */
> > > > -             handle_surprise_event(p_slot);
> > > > +             pciehp_queue_power_work(p_slot, DISABLE_REQ);
> > > >               break;
> > > >       case INT_LINK_UP:
> > > >       case INT_LINK_DOWN:
> > >
> > > Thanks a lot for this.  I think other people have seen the same issue.
> > >
> > > Even with this fix, don't we have essentially the same problem one
> > > layer back?  The first thing pcie_isr() does is read PCI_EXP_SLTSTA,
> > > then few lines down, we call pciehp_get_adapter_status(), which reads
> > > PCI_EXP_SLTSTA *again*.  So I think the window is smaller but still
> > > there.
> > >
> > > I think what we really should do is read the status registers
> > > (PCI_EXP_SLTSTA and probably also PCI_EXP_LNKSTA) *once* in
> > > pcie_isr(), before we write PCI_EXP_SLTSTA to clear the RW1C bits
> > > there, and then queue up events based on those values, without
> > > re-reading the registers.
> > >
> > > What do you think?
> >
> >
> > Yes, I agree. =


Yes indeed that should be done too.

> > We need to do something about that *in addition * to the
> > above patch to cover the
> > whole story. However I think there still will be a room for some
> > interrupt misses because we are
> > collecting the interrupts in intr_loc, and theoretically we could be
> > in a situation where in the pcie_isr, the
> >
> > do {
> >     ...
> > } while(detected)
> >
> > loop gets a removal->insertion->removal all while in the same
> > invocation of pcie_isr().
> > If this happens, the intr_loc will have recorded a single insertion
> > and a single removal, and
> > the final result will depend on the order in which we decide to
> > process the events in intr_loc.
> =

> I don't quite understand how that "do { .. } while (detected)" loop
> works or why it's done that way.  Collecting interrupt status bits in
> an ISR is obviously a very common task; it seems like there should be
> a standard, idiomatic way of doing it, but I don't know it.
> =

> > Or, may be we can make the calls to pciehp_queue_interrupt_event()
> > before clearing the
> > RW1C in the slot status register (in the loop)?
> =

> Yeah, it seems like we should read PCI_EXP_SLTSTA once, queue up any
> events related to it, then clear the relevant SLTSTA bits.
> =


Do you mean to remove the do {...} while loop and just
read PCI_EXP_SLTSTA once in ISR , queue the work and clear interrupts?


> Bjorn
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

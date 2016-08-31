Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Wed, 31 Aug 2016 17:37:47 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Duc Dang <dhdang@apm.com>, Rafael Wysocki <rafael@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	patches <patches@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160831163747.GA28180@red-moon>
References: <20160825195917.0e75a8db@arm.com>
 <20160826090813.GA1038@red-moon>
 <20160826130832.2fde2327@arm.com>
 <f747c2c3-096a-f843-908c-3f76238a6acd@codeaurora.org>
 <20160826170615.GC23885@red-moon>
 <66f94732-7ce4-e577-9bec-52f0dc8e6ddb@codeaurora.org>
 <20160830100834.GA368@red-moon>
 <20160831130506.GB22908@localhost>
 <20160831133454.GA24732@red-moon>
 <20160831160510.GC16426@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831160510.GC16426@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 11:05:10AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 31, 2016 at 02:34:54PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Aug 31, 2016 at 08:05:06AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Aug 30, 2016 at 11:08:34AM +0100, Lorenzo Pieralisi wrote:
> > > > On Fri, Aug 26, 2016 at 06:53:29PM -0400, Sinan Kaya wrote:
> > > > > 
> > > > > >> Let me throw option d here.
> > > > > >>
> > > > > >> I know Bjorn wants to keep ACTIVE_LOW in the code for common code but
> > > > > >> can't we override this in an arch specific way (arm64's pci.c) while
> > > > > >> creating the root bridge? 
> > > > > > 
> > > > > > On what basis ? You were not copied in from the beginning, but that
> > > > > > is not different from Duc's initial proposal, which Marc discarded
> > > > > > because it should not be done at arch level, it depends on the interrupt
> > > > > > controller.
> > > > > 
> > > > > I happen to watch the linux-pci and linux-acpi mail-lists. I also saw
> > > > > Duc's initial proposal. 
> > > > > 
> > > > > I can't imagine someone building an ACPI compliant ARM64 platform
> > > > > without a GIC interrupt controller. 
> > > > > 
> > > > > The SBSA spec already mentions what kind of compatibility should be
> > > > > maintained with respect to GIC. You can't have an ACPI system that's
> > > > > SBSA compliant and not using GIC. 
> > > > > 
> > > > > Can't we just hard code this to ACTIVE_HIGH in arch directory if ACPI
> > > > > is defined.  Why do we have to reach out to the interrupt controller?
> > > > 
> > > > Patch below (horrible but no solution will be shiny either).
> > > > 
> > > > > https://lists.linaro.org/pipermail/linaro-acpi/2015-November/005973.html
> > > > 
> > > > [...]
> > > > 
> > > > > If you look at my email above, I tried getting rid of PCI Link object
> > > > > and I couldn't. I sticked to only thing that works.
> > > > 
> > > > That's what I object to. If the ACPI bindings do not work for ARM
> > > > we do not work around issues, we upgrade the specs because what may work
> > > > for you has to work on all ARM platforms (and all FW developers have
> > > > to be aware of that). Granted, this is a tiny snag, but the point is
> > > > that no one knows what's the correct way of describing PCI legacy IRQs
> > > > on ARM and we need that rectified.
> > > > 
> > > > This does the trick for me (I can turn it into a function/look-up
> > > > that returns the polarity), I am sure it will ruffle feathers but
> > > > we have to find a solution so here it is (that acpi_irq_model gem
> > > > is already used in generic code drivers/acpi/pci_link.c ;-))
> > > > 
> > > > -- >8 --
> > > > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > > > index 2c45dd3..c9b8c85 100644
> > > > --- a/drivers/acpi/pci_irq.c
> > > > +++ b/drivers/acpi/pci_irq.c
> > > > @@ -411,7 +411,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> > > >  	int gsi;
> > > >  	u8 pin;
> > > >  	int triggering = ACPI_LEVEL_SENSITIVE;
> > > > -	int polarity = ACPI_ACTIVE_LOW;
> > > > +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> > > > +				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
> > > >  	char *link = NULL;
> > > >  	char link_desc[16];
> > > >  	int rc;
> > > 
> > > This still seems weird to me.
> > > 
> > > If I understand correctly, this GIC has several inputs, all active
> > > high.  Some of those inputs are connected to inverters and then to PCI
> > > INTx wires.
> > > 
> > > A generic device driver knows about the hardware it drives, including
> > > the properties of its interrupt wires.  PCI drivers and the ACPI/PCI
> > > core know that conventional PCI device INTx wires are active low.
> > > These drivers, being generic, do not know about the GIC inverters.
> > > 
> > > The patch above basically says "if ACPI tells us about a PCI interrupt
> > > connected to a GIC, *assume* there is an inverter on the input."  But
> > > there's no actual description of that inverter anywhere in ACPI or a
> > > device tree.  Shouldn't that be made explicit somewhere?
> > 
> > It is explicit for all IRQs other than PCI legacy IRQs ;-), that's
> > the message I wanted to get across and I failed so far.
> > 
> > For "normal" IRQs we can use Extended Interrupt Descriptors, that allow
> > us to describe polarity. For PCI legacy IRQs we could use extended
> > interrupt descriptors if we were allowed to use PCI interrupt links,
> > except that, according to current ACPI specs, PCI interrupt links can
> > only be used for *configurable* interrupt pins.
> > 
> > So, some ARM vendors stuck to the static/hardwired configuration
> > in the _PRT, that does not give us a chance to describe polarity.
> > 
> > I think that we should be allowed to use interrupt links, but that would
> > not comply with the specs (and on top of that there is FW that is
> > already shipped in ACPI tables that we can't change anymore).
> > 
> > > If we connect a non-PCI device to a GIC, we need to know whether
> > > there's an inverter.  How could we figure that out?
> > 
> > Through an Extended Interrupt Descriptor. How are we solving this ?
> 
> OK, I think I'm convinced.  What in the spec says you can't use PCI
> Interrupt Links for this case?  I see the example in ACPI 5.0 sec
> 6.2.12 that only shows them changing interrupt numbers with Interrupt
> descriptors.  Is there something that prohibits Extended Interrupt
> descriptors for PNP0C0F devices?  Is there something in the code that
> doesn't handle that?

ACPI 6.1 (6.2.13, page 335), that describes the two ways _PRT can be used.

The problem is not about whether we can use Extended Interrupt
Descriptors for PNP0C0F, we *can* use them in their (CRS,SRS,PRS), the
problem is that by our specs reading, PNP0C0F PCI interrupt link devices
can *only* describe interrupt pins that are configurable; the GIC
pins are not (ie every PCI INTx is connected to a specific GIC pin
and can't be routed dynamically - it has an inverter in the path
though ;-)).

I suspect that's because a) PNP0C0F devices can have a _PRS (that
can be empty) b) that's how IRQ chips work on x86.

What (some) ARM vendors did, given the above, is hardcode the _PRT
source field to 0 and add the GSI in the source index (as per specs);
that does not work because it implies level low, and this thread is the
outcome.

So, there are two niggles to sort out:

1) Kernel code handles PCI interrupt links and we do not need anything
   on top of that; we do need to update the specs to allow ARM platforms
   to use them though

2) We still need a point hack (as the one I inlined) to cater
   for platforms that in current FW do NOT describe legacy IRQs with
   PCI interrupt link devices, is the patch I inlined ok ?

Thanks !
Lorenzo

Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, Duc Dang <dhdang@apm.com>, Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, patches <patches@apm.com>, Bjorn Helgaas <bhelgaas@google.com>, Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Date: Fri, 02 Sep 2016 23:28:55 +0200
Message-ID: <4606680.aT5o76C774@vostro.rjw.lan>
In-Reply-To: <20160902110905.GA10977@red-moon>
References: <20160825195917.0e75a8db@arm.com> <10604453.yVTAAeibdq@vostro.rjw.lan> <20160902110905.GA10977@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 02, 2016 12:09:13 PM Lorenzo Pieralisi wrote:
> On Thu, Sep 01, 2016 at 01:08:19AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, August 31, 2016 05:37:47 PM Lorenzo Pieralisi wrote:
> > > On Wed, Aug 31, 2016 at 11:05:10AM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 31, 2016 at 02:34:54PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Wed, Aug 31, 2016 at 08:05:06AM -0500, Bjorn Helgaas wrote:
> > > > > > On Tue, Aug 30, 2016 at 11:08:34AM +0100, Lorenzo Pieralisi wrote:
> > > > > > > On Fri, Aug 26, 2016 at 06:53:29PM -0400, Sinan Kaya wrote:
> > > > > > > > 
> > > > > > > > >> Let me throw option d here.
> > > > > > > > >>
> > > > > > > > >> I know Bjorn wants to keep ACTIVE_LOW in the code for common code but
> > > > > > > > >> can't we override this in an arch specific way (arm64's pci.c) while
> > > > > > > > >> creating the root bridge? 
> > > > > > > > > 
> > > > > > > > > On what basis ? You were not copied in from the beginning, but that
> > > > > > > > > is not different from Duc's initial proposal, which Marc discarded
> > > > > > > > > because it should not be done at arch level, it depends on the interrupt
> > > > > > > > > controller.
> > > > > > > > 
> > > > > > > > I happen to watch the linux-pci and linux-acpi mail-lists. I also saw
> > > > > > > > Duc's initial proposal. 
> > > > > > > > 
> > > > > > > > I can't imagine someone building an ACPI compliant ARM64 platform
> > > > > > > > without a GIC interrupt controller. 
> > > > > > > > 
> > > > > > > > The SBSA spec already mentions what kind of compatibility should be
> > > > > > > > maintained with respect to GIC. You can't have an ACPI system that's
> > > > > > > > SBSA compliant and not using GIC. 
> > > > > > > > 
> > > > > > > > Can't we just hard code this to ACTIVE_HIGH in arch directory if ACPI
> > > > > > > > is defined.  Why do we have to reach out to the interrupt controller?
> > > > > > > 
> > > > > > > Patch below (horrible but no solution will be shiny either).
> > > > > > > 
> > > > > > > > https://lists.linaro.org/pipermail/linaro-acpi/2015-November/005973.html
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > If you look at my email above, I tried getting rid of PCI Link object
> > > > > > > > and I couldn't. I sticked to only thing that works.
> > > > > > > 
> > > > > > > That's what I object to. If the ACPI bindings do not work for ARM
> > > > > > > we do not work around issues, we upgrade the specs because what may work
> > > > > > > for you has to work on all ARM platforms (and all FW developers have
> > > > > > > to be aware of that). Granted, this is a tiny snag, but the point is
> > > > > > > that no one knows what's the correct way of describing PCI legacy IRQs
> > > > > > > on ARM and we need that rectified.
> > > > > > > 
> > > > > > > This does the trick for me (I can turn it into a function/look-up
> > > > > > > that returns the polarity), I am sure it will ruffle feathers but
> > > > > > > we have to find a solution so here it is (that acpi_irq_model gem
> > > > > > > is already used in generic code drivers/acpi/pci_link.c ;-))
> > > > > > > 
> > > > > > > -- >8 --
> > > > > > > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > > > > > > index 2c45dd3..c9b8c85 100644
> > > > > > > --- a/drivers/acpi/pci_irq.c
> > > > > > > +++ b/drivers/acpi/pci_irq.c
> > > > > > > @@ -411,7 +411,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> > > > > > >  	int gsi;
> > > > > > >  	u8 pin;
> > > > > > >  	int triggering = ACPI_LEVEL_SENSITIVE;
> > > > > > > -	int polarity = ACPI_ACTIVE_LOW;
> > > > > > > +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> > > > > > > +				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
> > > > > > >  	char *link = NULL;
> > > > > > >  	char link_desc[16];
> > > > > > >  	int rc;
> > > > > > 
> > > > > > This still seems weird to me.
> > > > > > 
> > > > > > If I understand correctly, this GIC has several inputs, all active
> > > > > > high.  Some of those inputs are connected to inverters and then to PCI
> > > > > > INTx wires.
> > > > > > 
> > > > > > A generic device driver knows about the hardware it drives, including
> > > > > > the properties of its interrupt wires.  PCI drivers and the ACPI/PCI
> > > > > > core know that conventional PCI device INTx wires are active low.
> > > > > > These drivers, being generic, do not know about the GIC inverters.
> > > > > > 
> > > > > > The patch above basically says "if ACPI tells us about a PCI interrupt
> > > > > > connected to a GIC, *assume* there is an inverter on the input."  But
> > > > > > there's no actual description of that inverter anywhere in ACPI or a
> > > > > > device tree.  Shouldn't that be made explicit somewhere?
> > > > > 
> > > > > It is explicit for all IRQs other than PCI legacy IRQs ;-), that's
> > > > > the message I wanted to get across and I failed so far.
> > > > > 
> > > > > For "normal" IRQs we can use Extended Interrupt Descriptors, that allow
> > > > > us to describe polarity. For PCI legacy IRQs we could use extended
> > > > > interrupt descriptors if we were allowed to use PCI interrupt links,
> > > > > except that, according to current ACPI specs, PCI interrupt links can
> > > > > only be used for *configurable* interrupt pins.
> > > > > 
> > > > > So, some ARM vendors stuck to the static/hardwired configuration
> > > > > in the _PRT, that does not give us a chance to describe polarity.
> > > > > 
> > > > > I think that we should be allowed to use interrupt links, but that would
> > > > > not comply with the specs (and on top of that there is FW that is
> > > > > already shipped in ACPI tables that we can't change anymore).
> > > > > 
> > > > > > If we connect a non-PCI device to a GIC, we need to know whether
> > > > > > there's an inverter.  How could we figure that out?
> > > > > 
> > > > > Through an Extended Interrupt Descriptor. How are we solving this ?
> > > > 
> > > > OK, I think I'm convinced.  What in the spec says you can't use PCI
> > > > Interrupt Links for this case?  I see the example in ACPI 5.0 sec
> > > > 6.2.12 that only shows them changing interrupt numbers with Interrupt
> > > > descriptors.  Is there something that prohibits Extended Interrupt
> > > > descriptors for PNP0C0F devices?  Is there something in the code that
> > > > doesn't handle that?
> > > 
> > > ACPI 6.1 (6.2.13, page 335), that describes the two ways _PRT can be used.
> > > 
> > > The problem is not about whether we can use Extended Interrupt
> > > Descriptors for PNP0C0F, we *can* use them in their (CRS,SRS,PRS), the
> > > problem is that by our specs reading, PNP0C0F PCI interrupt link devices
> > > can *only* describe interrupt pins that are configurable;
> > 
> > That would be the case if _PRS/_SRS/_DIS were required for those objects.
> > It doesn't seem to be the case, though.
> 
> The kernel currently does not cope with eg missing _SRS on PCI interrupt
> link devices (and I suspect that's the case for other OSs), therefore it
> would only work on ARM64 with an empty _SRS and hardcoded _PRS. We should
> reword the specs, since this has created/is creating confusion (which
> resulted in buggy ACPI tables - ie this thread) and unfortunately we still
> need my hack to make sure static legacy IRQ configurations work on
> ARM64 systems, I would avoid it but there is not much we can do.

Fair enough.

Thanks,
Rafael

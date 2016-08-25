Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 25 Aug 2016 12:14:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Duc Dang <dhdang@apm.com>, Rafael Wysocki <rafael@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	patches <patches@apm.com>, bhelgaas@google.com
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160825111424.GA9244@red-moon>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
 <20160824142723.GA25843@red-moon>
 <20160824193000.GE23914@localhost>
 <20160824213005.1a9300ef@arm.com>
 <87pooxqi5p.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87pooxqi5p.fsf@e105922-lin.cambridge.arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 11:04:02AM +0100, Punit Agrawal wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
> > On Wed, 24 Aug 2016 14:30:00 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >> On Wed, Aug 24, 2016 at 03:27:23PM +0100, Lorenzo Pieralisi wrote:
> >> > [ +Bjorn, Punit]
> >> > 
> >> > On Wed, Aug 24, 2016 at 04:06:13AM -0700, Duc Dang wrote:  
> >> > > [Resend in plain text mode]
> >> > > 
> >> > > Hi Lorenzo, Rafael,
> >> > > 
> >> > > ACPI 6.1 spec does not specify how to set interrupt polarity and
> >> > > trigger mode in _PRT when the interrupts are static (hardwired to
> >> > > specific interrupt inputs in interrupt controller). In current
> >> > > acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
> >> > > default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
> >> > > ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
> >> > > GICv3 controllers and will cause failures in PCIe AER, PME services
> >> > > (on X-Gene platforms).  
> >> 
> >> PCI (not PCIe) r3.0, sec 2.2.6, says "Interrupts on PCI are optional
> >> and defined as 'level sensitive,' asserted low."
> >> 
> >> I've heard before that ARM64 does this differently, but I still don't
> >> understand the difference.  Obviously if you plug a legacy PCI card
> >> into an ARM64 system, it's still going to pull INTA# low to assert an
> >> interrupt.  So is there something special about ARM64 that inverts
> >> that, or what?
> >
> > There is certainly an inverter somewhere on the interrupt path, because
> > the GIC triggers on level high, not level low. But I don't think that's
> > the issue Duc is trying to outline here, because that's not something
> > SW can fix. I'm worried that in his system, the interrupt is edge
> > triggered instead. 

It would be nice if Duc reported the "failures" he is noticing,
instead of us having to guess them.

> >> > > Is there any way to specify polarity and trigger mode for static
> >> > > interrupts in _PRT?   
> >> 
> >> There is no way I'm aware of in _PRT to specify polarity and trigger
> >> mode.  I don't know the history, but my guess is that it would be seen
> >> as superfluous given that the PCI spec requires level, active low.
> >> 
> >> Obviously I'm missing something important.
> >
> > Same here, unless the HW is not PCI compliant...
> 
> I had faced this issue on Juno r2[0] a few months back - though AFAICS,
> it wasn't preventing anything to work but printed an annoying message on
> boot.
> 
> [ 1.353696] genirq: Setting trigger mode 8 for irq 9 failed (gic_set_type+0x0/0x5c)
> [ 1.478286] genirq: Setting trigger mode 8 for irq 17 failed (gic_set_type+0x0/0x5c)

This is not just annoying, that's the kernel failing to set-up legacy
IRQs IIUC and unless we have a way to specify interrupt polarity that's
going to happen on all ARM64 platforms booting with ACPI having a GIC
interrupt controller.

I suspect most of ARM partners are already using interrupt links to
work around this and Duc was the first one reporting the issue
with the ACPI specs (ie interrupt links should just be used for
configurable interrupt pins - which, I will say it again - it is
likely to be a consequence of how x86 and their APIC works).

> The ACPI code in the kernel (drivers/acpi/pci_irq.c) is behaving as per
> spec, so nothing to be done there IMHO. The problem arises due to the
> integration of two mismatched components - PCI is level low and the GIC
> supports only level high - making it necessary to introduce glue
> elements like the inverter.

That glue can well be the interrupt link. I reiterate my point:
I will start dumping x86 ACPI tables and peruse the _PRT on x86 systems,
but in principle even on x86 the legacy PCI interrupt can be re-routed
and their polarity specified through interrupt links. It is not a
given that the legacy IRQs are active low at interrupt controller
level even on x86, at least that's not ruled out by ACPI specs.

Am I wrong ?

The inverter you and Marc mentioned can be described through an
interrupt link defining the interrupt polarity. On x86 there is
probably an IRQ router sitting downstream the ACPI that allows
to a) configure the IOAPIC pin for the legacy IRQ and b) control
the polarity, but as I mentioned I do not have enough x86 knowledge,
so I am just guessing.

> This would all be OK if ACPI had a mechanism to specify the interrupt
> type (trigger and polarity). As an alternative, for Juno I created a
> link device (as Lorenzo suggests) to provide this information to the
> kernel.
> 
> With this fix the warnings went away and I suspect this will address
> Duc's issue as well. But that is playing naughty with the spec (ACPI 6.1
> Section. 6.2.13).

ACPI specs were written for x86 boxes, there is nothing naughty
in asking for them to be updated and work on other architectures.

The only issue I see with interrupt links is that they may allow
reprogramming through the _SRS method, which is optional BTW.

> If there are no good reason to restrict using link devices to
> configurable interrupts, perhaps the spec needs an update.

Yes and that's what I am going to ask if nobody complains.

> Perhaps Rafael knows why is there a restriction on using link devices
> for fixed interrupts in the ACPI spec...

See above, I do not know why that restriction is there given that
to me an interrupt link is a superset of static values, I do not
see why they should be prevented for non-configurable interrupts,
I am happy to be corrected if there is something we are missing.

Lorenzo

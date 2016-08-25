Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <20160825111424.GA9244@red-moon>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
 <20160824142723.GA25843@red-moon> <20160824193000.GE23914@localhost>
 <20160824213005.1a9300ef@arm.com> <87pooxqi5p.fsf@e105922-lin.cambridge.arm.com>
 <20160825111424.GA9244@red-moon>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 25 Aug 2016 09:46:25 -0700
Message-ID: <CADaLNDkJ5wQC-59oD26J0F8T+pP5BEJcSTN16j_EYm-pmfPi=A@mail.gmail.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, patches <patches@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 4:14 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Aug 25, 2016 at 11:04:02AM +0100, Punit Agrawal wrote:
>> Marc Zyngier <marc.zyngier@arm.com> writes:
>>
>> > On Wed, 24 Aug 2016 14:30:00 -0500
>> > Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >
>> >> On Wed, Aug 24, 2016 at 03:27:23PM +0100, Lorenzo Pieralisi wrote:
>> >> > [ +Bjorn, Punit]
>> >> >
>> >> > On Wed, Aug 24, 2016 at 04:06:13AM -0700, Duc Dang wrote:
>> >> > > [Resend in plain text mode]
>> >> > >
>> >> > > Hi Lorenzo, Rafael,
>> >> > >
>> >> > > ACPI 6.1 spec does not specify how to set interrupt polarity and
>> >> > > trigger mode in _PRT when the interrupts are static (hardwired to
>> >> > > specific interrupt inputs in interrupt controller). In current
>> >> > > acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
>> >> > > default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
>> >> > > ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
>> >> > > GICv3 controllers and will cause failures in PCIe AER, PME services
>> >> > > (on X-Gene platforms).
>> >>
>> >> PCI (not PCIe) r3.0, sec 2.2.6, says "Interrupts on PCI are optional
>> >> and defined as 'level sensitive,' asserted low."
>> >>
>> >> I've heard before that ARM64 does this differently, but I still don't
>> >> understand the difference.  Obviously if you plug a legacy PCI card
>> >> into an ARM64 system, it's still going to pull INTA# low to assert an
>> >> interrupt.  So is there something special about ARM64 that inverts
>> >> that, or what?
>> >
>> > There is certainly an inverter somewhere on the interrupt path, because
>> > the GIC triggers on level high, not level low. But I don't think that's
>> > the issue Duc is trying to outline here, because that's not something
>> > SW can fix. I'm worried that in his system, the interrupt is edge
>> > triggered instead.
>
> It would be nice if Duc reported the "failures" he is noticing,
> instead of us having to guess them.

I am sorry that I should be more specific. Please see failure information below.

>
>> >> > > Is there any way to specify polarity and trigger mode for static
>> >> > > interrupts in _PRT?
>> >>
>> >> There is no way I'm aware of in _PRT to specify polarity and trigger
>> >> mode.  I don't know the history, but my guess is that it would be seen
>> >> as superfluous given that the PCI spec requires level, active low.
>> >>
>> >> Obviously I'm missing something important.
>> >
>> > Same here, unless the HW is not PCI compliant...
>>
>> I had faced this issue on Juno r2[0] a few months back - though AFAICS,
>> it wasn't preventing anything to work but printed an annoying message on
>> boot.
>>
>> [ 1.353696] genirq: Setting trigger mode 8 for irq 9 failed (gic_set_type+0x0/0x5c)
>> [ 1.478286] genirq: Setting trigger mode 8 for irq 17 failed (gic_set_type+0x0/0x5c)

I got the same warning:
[    6.576842] genirq: Setting trigger mode 8 for irq 50 failed
(gic_set_type+0x0/0x64)

>
> This is not just annoying, that's the kernel failing to set-up legacy
> IRQs IIUC and unless we have a way to specify interrupt polarity that's
> going to happen on all ARM64 platforms booting with ACPI having a GIC
> interrupt controller.

The warning about gic_set_type above also happens with previous
kernel, but INTx interrupt handler is still registered successfully,
so things that use INTx still work. I dump a trace of PCIe AER service
initialization  in 4.6 and 4.8-rc1 and the code path leading to
gic_set_type is different: in 4.8-rc1, request_irq fails when
gic_set_type fails and the handler cannot be registered:

4.6-rc2 code path:
[    6.455289] [<ffff0000083624d0>] gic_set_type+0x50/0x64
[    6.460943] [<ffff0000080fb984>] __irq_set_trigger+0x58/0x178
[    6.467176] [<ffff0000080fd0e8>] irq_set_irq_type+0x30/0x5c
[    6.473169] [<ffff000008100dcc>] irq_create_fwspec_mapping+0x194/0x1e4
[    6.480121] [<ffff0000083d5368>] acpi_register_gsi+0x54/0x5c
[    6.486303] [<ffff0000083d2660>] acpi_pci_irq_enable+0xc8/0x14c
[    6.492771] [<ffff00000809382c>] pcibios_alloc_irq+0x20/0x58
[    6.498825] [<ffff000008398928>] pci_device_probe+0x28/0x108
[    6.504844] [<ffff000008481a20>] driver_probe_device+0x200/0x2a0
[    6.511241] [<ffff000008481b6c>] __driver_attach+0xac/0xb0
[    6.517138] [<ffff00000847fa90>] bus_for_each_dev+0x58/0x98
[    6.523138] [<ffff000008481330>] driver_attach+0x20/0x28
[    6.528792] [<ffff000008480f48>] bus_add_driver+0x1c8/0x22c
[    6.534741] [<ffff000008482424>] driver_register+0x60/0xf4
[    6.540594] [<ffff0000083977b8>] __pci_register_driver+0x40/0x48
[    6.546993] [<ffff000008b4fb20>] pcie_portdrv_init+0x84/0xa4
[    6.553175] [<ffff0000080829d8>] do_one_initcall+0x8c/0x19c
[    6.559176] [<ffff000008b2eb00>] kernel_init_freeable+0x150/0x1f0
[    6.565748] [<ffff0000087f05c0>] kernel_init+0x10/0xfc
[    6.571213] [<ffff000008085e10>] ret_from_fork+0x10/0x40
[    6.576842] genirq: Setting trigger mode 8 for irq 50 failed
(gic_set_type+0x0/0x64)
[    6.585689] aer 0000:00:00.0:pcie02: service driver aer loaded


4.8-rc1 code path:
[    5.829216] [<ffff000008384fb4>] gic_set_type+0x60/0x74
[    5.834778] [<ffff0000080fe344>] __irq_set_trigger+0x58/0x178
[    5.840890] [<ffff0000080fea3c>] __setup_irq+0x5d8/0x65c
[    5.846536] [<ffff0000080fec9c>] request_threaded_irq+0x114/0x1c4
[    5.853038] [<ffff0000083db4bc>] aer_probe+0xd4/0x274
[    5.858418] [<ffff0000083d9064>] pcie_port_probe_service+0x38/0x80
[    5.865007] [<ffff0000084c36b0>] driver_probe_device+0x200/0x2a0
[    5.871378] [<ffff0000084c37fc>] __driver_attach+0xac/0xb0
[    5.877215] [<ffff0000084c1720>] bus_for_each_dev+0x58/0x98
[    5.883138] [<ffff0000084c2fc0>] driver_attach+0x20/0x28
[    5.888800] [<ffff0000084c2bd8>] bus_add_driver+0x1c8/0x22c
[    5.894749] [<ffff0000084c40b4>] driver_register+0x60/0xf4
[    5.900611] [<ffff0000083d8fb0>] pcie_port_service_register+0x58/0x68
[    5.907477] [<ffff000008ce3dd8>] aer_service_init+0x30/0x38
[    5.913400] [<ffff000008083334>] do_one_initcall+0x38/0x128
[    5.919323] [<ffff000008cc0cc8>] kernel_init_freeable+0x150/0x1f0
[    5.925809] [<ffff0000088f4278>] kernel_init+0x10/0xfc
[    5.931239] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[    5.936913] genirq: Setting trigger mode 8 for irq 50 failed
(gic_set_type+0x0/0x74)
[    5.945163] aer 0000:00:00.0:pcie002: request IRQ failed
[    5.950844] aer: probe of 0000:00:00.0:pcie002 failed with error -22

>
> I suspect most of ARM partners are already using interrupt links to
> work around this and Duc was the first one reporting the issue
> with the ACPI specs (ie interrupt links should just be used for
> configurable interrupt pins - which, I will say it again - it is
> likely to be a consequence of how x86 and their APIC works).

I tried your suggestion about using interrupt links and it works. But
unfortunately, it requires firmware change.

>
>> The ACPI code in the kernel (drivers/acpi/pci_irq.c) is behaving as per
>> spec, so nothing to be done there IMHO. The problem arises due to the
>> integration of two mismatched components - PCI is level low and the GIC
>> supports only level high - making it necessary to introduce glue
>> elements like the inverter.
>
> That glue can well be the interrupt link. I reiterate my point:
> I will start dumping x86 ACPI tables and peruse the _PRT on x86 systems,
> but in principle even on x86 the legacy PCI interrupt can be re-routed
> and their polarity specified through interrupt links. It is not a
> given that the legacy IRQs are active low at interrupt controller
> level even on x86, at least that's not ruled out by ACPI specs.
>
> Am I wrong ?
>
> The inverter you and Marc mentioned can be described through an
> interrupt link defining the interrupt polarity. On x86 there is
> probably an IRQ router sitting downstream the ACPI that allows
> to a) configure the IOAPIC pin for the legacy IRQ and b) control
> the polarity, but as I mentioned I do not have enough x86 knowledge,
> so I am just guessing.
>
>> This would all be OK if ACPI had a mechanism to specify the interrupt
>> type (trigger and polarity). As an alternative, for Juno I created a
>> link device (as Lorenzo suggests) to provide this information to the
>> kernel.
>>
>> With this fix the warnings went away and I suspect this will address
>> Duc's issue as well. But that is playing naughty with the spec (ACPI 6.1
>> Section. 6.2.13).
>
> ACPI specs were written for x86 boxes, there is nothing naughty
> in asking for them to be updated and work on other architectures.
>
> The only issue I see with interrupt links is that they may allow
> reprogramming through the _SRS method, which is optional BTW.
>
>> If there are no good reason to restrict using link devices to
>> configurable interrupts, perhaps the spec needs an update.
>
> Yes and that's what I am going to ask if nobody complains.

In my opinion, if the interrupt is not configurable, I should be able
to choose not to use interrupt link, which requires a spec. update as
well to specify the polarity of the fixed interrupts?

>
>> Perhaps Rafael knows why is there a restriction on using link devices
>> for fixed interrupts in the ACPI spec...
>
> See above, I do not know why that restriction is there given that
> to me an interrupt link is a superset of static values, I do not
> see why they should be prevented for non-configurable interrupts,
> I am happy to be corrected if there is something we are missing.
>
> Lorenzo

Regards,
Duc Dang.

Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
 <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
Date: Thu, 20 Oct 2016 13:01:04 -0700
MIME-Version: 1.0
In-Reply-To: <20161019224405.GA14915@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/19/2016 3:44 PM, Bjorn Helgaas wrote:
[cut]

>>
>> Same problem here. This line will be broken after the sci_penalty change.
>>
>>                 acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
>>                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
> 
> I think the fragility of this code is an indication that we have a
> design problem, so I want to step back from the nitty gritty details
> for a bit and look at the overall design.

This is all because we started with a very simple design where we replaced
the array with a get_penalty function. Set penalty function would dynamically
reallocate the link list so that we have a design that works no matter
what the number of IRQs are. 

As we hit the first problem on existing platform, we realized that we can't
actually dynamically reallocate an interrupt because get_penalty function
gets called from early boot stages where heap is not initialized yet.

Then, we started restructuring the code so that we can discover the IRQs
by iterating the link list rather than using an array. While transitioning
into this new design, we forgot the fact that irq_get_penalty function
became a fixed array penalty + dynamically calculated penalty. 

This line was trying to increment the static array but ended up gathering
the dynamic pieces together.

This obviously is a bug and was forgotten in the code.

> 
> Let me restate the overall problem: We have a PCI device connected to
> an interrupt link.  The interrupt link can be connected to one of
> several IRQs, and we want to choose one of those IRQs to minimize IRQ
> sharing.
> 
> That means we need information about which IRQs are used.
> Historically we've started with a compiled-in table of common ISA IRQ
> usage, and we also collect information about which IRQs are used and
> which *might* be used.  So we have the following inputs:
> 
>   - Compiled-in ISA IRQ usage: the static acpi_isa_irq_penalty[]
>     values.  ACPI is *supposed* to tell us about all these usages, so
>     I don't know why we have the table.  But it's been there as long
>     as I can remember.  The table is probably x86-specific, but we
>     keep it in the supposedly generic pci_link.c.
> 

I think it is because the ISA IRQ functions get called in early boot stages
and there is no heap allocator at that point of execution.

>   - The "acpi_irq_isa=" and "acpi_irq_pci=" command-line overrides via
>     acpi_irq_pci().  I suppose these are for cases where we can't
>     figure things out automatically.  I would resist adding parameters
>     like this today (I would treat the need for them as a bug and look
>     for a fix or a quirk), but we might be stuck with these.
> 
>   - SCI information from the ACPI FADT (acpi_penalize_sci_irq()).
> 
>   - PNPBIOS and PNPACPI device IRQ usage from _CRS and _PRS via
>     acpi_penalize_isa_irq().  This is only for IRQs 0-15, and it does
>     NOT include interrupt link (PNP0C0F) devices because we don't
>     handle them as PNPACPI devices.  I think this is related to the
>     fact that PNP0C0F doesn't appear in acpi_pnp_device_ids[].

The original code supports the entire IRQ range (0..255). We limited it
to 16 during redesign.

> 
>   - For non-PNP0C0F, non-PNPACPI devices, we completely ignore IRQ
>     information from _CRS and _PRS.  This seems sub-optimal and
>     possibly buggy.
> 
>   - Interrupt link (PNP0C0F) IRQ usage from _CRS and _PRS via
>     acpi_irq_penalty_init().  This is only for IRQs 0-15, and we only
>     call this on x86.  If _PRS exists, we penalize each possible IRQ.
>     If there's no _PRS but _CRS contains an active IRQ, we penalize
>     it.

Correct.

> 
>   - Interrupt link (PNP0C0F) IRQ usage from _CRS and _PRS when
>     enabling a new link.  In acpi_irq_pci_sharing_penalty(), we
>     penalize an IRQ if it appears in _CRS or _PRS of any link device
>     in the system.
>     
>     For IRQs 0-15, this overlaps with the penalization done at
>     boot-time by acpi_irq_penalty_init(): if a device has _PRS, we'll
>     add the "possible" penalty twice (once in acpi_irq_penalty_init()
>     and again in acpi_irq_pci_sharing_penalty()), and the "using"
>     penalty once (in acpi_irq_pci_sharing_penalty()).
> 
>     If a device has no _PRS but has _CRS, the "using" penalty is
>     applied twice (once in once in acpi_irq_penalty_init() and again
>     in acpi_irq_pci_sharing_penalty())
> 
> I think this whole thing is baroque and grotesque.

Regardless of these, we hit four different bugs because we didn't understand
the usage model.

1. You can't use kmalloc in IRQ get penalty
2. SCI IRQ type cannot be gathered from IRQ API
3. acpi_irq_penalty cannot be called from early stages since it is iterating
the link list. If there is a penalty assignment requirement from early stages,
this needs to be done on a statically allocated array.
4. acpi_irq_penalty_init is redundant.

> 
> Here's a strawman idea:
> 
>   - Maintain a mapping of (IRQ, penalty).  Initially all penalties are
>     zero.  This is for *all* IRQs, not just ISA ones.  This could be a
>     linked list, but the structure is not important as long as we can
>     add things dynamically.

Dynamic allocation doesn't work due to early calls from x86 architecture.
This is the reason why we iterate the link objects.

> 
>   - Add a "acpi_penalize_irq()" function similar to
>     acpi_penalize_isa_irq(), but not restricted to ISA, so we can
>     increase the penalty for any IRQ, and maybe we can specify how
>     much penalty to add.

This was my first patch. It didn't work due to heap requirements.

> 
>   - Make acpi_irq_get_penalty() a simple lookup in the mapping.  No
>     iterating through all link devices.
> 
>   - If we think the compiled-in penalties are really necessary, move
>     the table to x86 code and add a boot-time loop to use
>     acpi_penalize_irq() to penalize these IRQs.  Same for the
>     command-line options.

I agree, we can move all of the ISA interrupt stuff out of this file
if we want to.

I really don't like the fact that we have a acpi_penalize_isa_irq function.
The penalty information should have been contained in this file. 

acpi_penalize_isa_irq gets called from arbitrary contexts.

I'm not sure adding a acpi_penalize_irq function is a good idea. All penalty
users should have been in this file. 

> 
>   - Change acpi_penalize_sci_irq() to use acpi_penalize_irq().
>     Probably the mapping needs to pay attention to trigger/polarity
>     somehow, too.
> 
>   - Figure out how to make the ACPI core use acpi_penalize_irq() to
>     based on the _CRS and _PRS of every ACPI device, including
>     PNPACPI, PNP0C0F, etc.  Then we can remove acpi_irq_penalty_init().
> 

I think this is a new feature.

>   - Change acpi_pci_link_set() to use acpi_penalize_irq() for the IRQ
>     it is enabling.  Conceptually maybe this should be done in the
>     acpi_set_current_resources() path so it happens whenever we use
>     _CRS to enable an IRQ on *any* ACPI device.
> 
> I think the biggest issue is figuring out how to get the ACPI core to
> look at the _CRS for *all* devices.  If we could do that, I think it
> could substantially simplify this code.

I think my V4 patch satisfies all of these requirements and also fixes
the existing regression. (I have test vectors captured from the machines
with issues.)

1. You can't use kmalloc in IRQ get penalty
2. SCI IRQ type cannot be gathered from IRQ API
3. acpi_irq_penalty cannot be called from early stages since it is iterating
the link list. If there is a penalty assignment requirement from early stages,
this needs to be done on a statically allocated array.
4. acpi_irq_penalty_init is redundant.

and your goal to have some common code that can be used with any IRQ we want.

If we want to move the ISA pieces out of this file, that can be done too. 
We can also add support for PNPACPI. I'm not a very big fan of scratch
everything and start from beginning approach. This refactoring effort already
failed 3 times. I'd like to close the issue and move on.

> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

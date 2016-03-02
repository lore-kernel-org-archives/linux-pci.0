Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost> <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D7317F.7090500@codeaurora.org>
Date: Wed, 2 Mar 2016 13:31:27 -0500
MIME-Version: 1.0
In-Reply-To: <20160301194340.GA19783@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/1/2016 2:43 PM, Bjorn Helgaas wrote:
> On Tue, Mar 01, 2016 at 01:49:34PM -0500, Sinan Kaya wrote:
>>> There's so much code there, that I think all the code obscures the
>>> fact that there's almost nothing really happening.  In broad outline,
>>> I think we care about:
>>>
>>>   - the legacy ISA IRQs, i.e., the contents of acpi_irq_isa_penalty[]
>>>   - acpi_irq_isa= from command line
>>>   - acpi_irq_pci= from command line
>>>   - which IRQ is used for SCI
>>>   - number of PCI Interrupt Link devices sharing an IRQ
>>>
>>> I doubt we need any dynamic allocation at all to manage this.  We
>>> already have the acpi_irq_isa_penalty[] table statically allocated.
>>> The SCI IRQ is one word.  
>>
>> Just to be clear, we have resized acpi_irq_penalty table to 16 and named it
>> acpi_irq_isa_penalty. We are dynamically allocating memory for the rest of 
>> the interrupts that is bigger than 16. 
>>
>> The SCI interrupt that caused the failure is interrupt 22 in this case. The code
>> was trying to allocate a new entry with kzalloc. 22 won't fit into the 
>> acpi_irq_isa_penalty array. How do we handle such case? Is there a cap on the SCI
>> interrupt number? 
>>
>> That's why, I was trying to reallocate some memory in this code.
> 
> I don't think there's a restriction on what the SCI IRQ can be.  But
> there is only one SCI IRQ, so all we have to do is keep track of what
> it is, which only requires one word.
> 
>>> I bet the command-line stuff is only
>>> useful for the 16 ISA IRQs and could be merged into
>>> acpi_irq_isa_penalty[].  
>>> Same for acpi_penalize_isa_irq() and
>>> acpi_isa_irq_available().  
>>
>> Agreed. No issues with ISA IRQs.
>>
>>> We could easily compute the
>>> number of links sharing an IRQ by traversing acpi_link_list.
>>
>> Sorry, I couldn't quite get this. Where would you do this?
> 
> I've never been exactly clear on how these links work.  So pardon me
> while I think out loud and bore you with what you already know
> (correct me if I get this wrong):
> 
>   - A link device has a PCI wired interrupt (INTA, INTB, etc.) on its
>     "downstream" end.
> 
>   - The link device has a set of possible interrupt controller inputs
>     to which it can connect the PCI interrupt.  _PRS contains this
>     set.
> 
>   - When we enable a PCI device's interrupt, Interrupt Pin from config
>     space tells us which INTx it uses.  The _PRT tells us whether that
>     INTx is connected to (a) a fixed GSI or (b) an Interrupt Link that
>     can be configured to one of several interrupt controller inputs.
> 
>   - If the latter, we must select one of the interrupt controller
>     inputs to use, i.e., one of the IRQs from _PRS, and enable the
>     Link.
> 
>   - If the Link is already active, we probably shouldn't change its
>     configuration because other devices might already be using it.
> 
>   - If the Link is inactive, we must choose an IRQ and activate it.
>     We should be able to choose anything from _PRS (as long as the
>     level & trigger attributes match), but we can try to reduce IRQ
>     sharing by avoiding an IRQ that's already in use.
> 

Really nice write up. We need to fold this into the code. It was never 
obvious.

I'll send something soon.

> This IRQ selection process is where we use the penalty information.
> In acpi_pci_link_allocate(), we iterate through the possible choices
> (link->irq.possible[i]) and choose the one with the smallest penalty.
> 
> Here's a sketch of what I'm thinking the code could look like.  In x86
> code:
> 
>   int pcibios_irq_penalty(int irq)
>   {
>     if (irq >= ACPI_MAX_ISA_IRQ)
>       return 0;
> 
>     return acpi_irq_isa_penalty[irq] + acpi_irq_cmd_line_penalty[irq];
>   }
> 

> In pci_link.c:
> 
>   static int sci_irq, sci_irq_penalty;
> 
>   void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>   {
>     if (irq < 0)
>       return;
> 
>     sci_irq = irq;
>     if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>         polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>           sci_irq_penalty = infinite;  /* can't use for PCI at all */
>     else
>       sci_irq_penalty = PIRQ_PENALTY_PCI_USING;
>   }
> 
>   static pci_irq_sharing_penalty(int irq)
>   {
>     struct acpi_pci_link *link;
>     int penalty = 0;
> 
>     list_for_each_entry(link, &acpi_link_list, list) {
> 
>       /*
>        * If a link is active, penalize its IRQ heavily so we try to choose
>        * a different IRQ.
>        */
>       if (link->irq.active && link->irq.active == irq)
>         penalty += PIRQ_PENALTY_PCI_USING;
>       else {
> 
>         /*
>          * If a link is inactive, penalize the IRQs it might use, but
>          * not as severely.
>          */ 
>         for (i = 0; i < link->irq.possible_count; i++)
>           if (link->irq.possible[i] == irq)
>             penalty += PIRQ_PENALTY_PCI_POSSIBLE;
>       }
>     }
> 
>     return penalty;
>   }
> 
>   int __weak pcibios_irq_penalty(int irq)
>   {
>     return 0;
>   }
> 
>   static int acpi_irq_get_penalty(int irq)
>   {
>     int penalty;
> 
>     penalty = pcibios_irq_penalty(irq);
> 
>     if (irq == sci_irq)
>       penalty += sci_irq_penalty;
> 
>     penalty += pci_irq_sharing_penalty(irq);
>     return penalty;
>   }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

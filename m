Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D5E43E.7050406@codeaurora.org>
Date: Tue, 1 Mar 2016 13:49:34 -0500
MIME-Version: 1.0
In-Reply-To: <20160229223453.GA12162@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> There's so much code there, that I think all the code obscures the
> fact that there's almost nothing really happening.  In broad outline,
> I think we care about:
> 
>   - the legacy ISA IRQs, i.e., the contents of acpi_irq_isa_penalty[]
>   - acpi_irq_isa= from command line
>   - acpi_irq_pci= from command line
>   - which IRQ is used for SCI
>   - number of PCI Interrupt Link devices sharing an IRQ
> 
> I doubt we need any dynamic allocation at all to manage this.  We
> already have the acpi_irq_isa_penalty[] table statically allocated.
> The SCI IRQ is one word.  

Just to be clear, we have resized acpi_irq_penalty table to 16 and named it
acpi_irq_isa_penalty. We are dynamically allocating memory for the rest of 
the interrupts that is bigger than 16. 

The SCI interrupt that caused the failure is interrupt 22 in this case. The code
was trying to allocate a new entry with kzalloc. 22 won't fit into the 
acpi_irq_isa_penalty array. How do we handle such case? Is there a cap on the SCI
interrupt number? 

That's why, I was trying to reallocate some memory in this code.


> I bet the command-line stuff is only
> useful for the 16 ISA IRQs and could be merged into
> acpi_irq_isa_penalty[].  
> Same for acpi_penalize_isa_irq() and
> acpi_isa_irq_available().  

Agreed. No issues with ISA IRQs.

> We could easily compute the
> number of links sharing an IRQ by traversing acpi_link_list.

Sorry, I couldn't quite get this. Where would you do this?

> 
> I think only x86 cares about the first three items (legacy ISA IRQs
> and command-line args).  This should be reflected in the code.  Only
> x86 calls acpi_irq_penalty_init(), but that's pretty non-obvious.

Very true. It looks like somebody sneaked in some code there.

> 
> I think it would be better to completely rewrite this penalty stuff
> than to keep making it more complicated by fixing things in the
> existing design.
> 
OK. Let's find out what it needs to look like. I need guidance on what IRQs on
Intel systems look like. 

>>>> Reported-by: Nalla, Ravikanth <ravikanth.nalla@hpe.com>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> ---
>>>>  drivers/acpi/pci_link.c | 19 +++++++++++++++----
>>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>>>> index fa28635..14fe3ca 100644
>>>> --- a/drivers/acpi/pci_link.c
>>>> +++ b/drivers/acpi/pci_link.c
>>>> @@ -47,6 +47,7 @@ ACPI_MODULE_NAME("pci_link");
>>>>  #define ACPI_PCI_LINK_FILE_INFO		"info"
>>>>  #define ACPI_PCI_LINK_FILE_STATUS	"state"
>>>>  #define ACPI_PCI_LINK_MAX_POSSIBLE	16
>>>> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024
>>>>  
>>>>  static int acpi_pci_link_add(struct acpi_device *device,
>>>>  			     const struct acpi_device_id *not_used);
>>>> @@ -473,6 +474,8 @@ struct irq_penalty_info {
>>>>  };
>>>>  
>>>>  static LIST_HEAD(acpi_irq_penalty_list);
>>>> +static struct irq_penalty_info early_irq_infos[ACPI_PCI_LINK_MAX_EARLY_IRQINFO];
>>>> +static int early_irq_info_counter;
>>>>  
>>>>  static int acpi_irq_get_penalty(int irq)
>>>>  {
>>>> @@ -507,10 +510,17 @@ static int acpi_irq_set_penalty(int irq, int new_penalty)
>>>>  		}
>>>>  	}
>>>>  
>>>> -	/* nope, let's allocate a slot for this IRQ */
>>>> -	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
>>>> -	if (!irq_info)
>>>> -		return -ENOMEM;
>>>> +	if (!acpi_gbl_permanent_mmap) {
>>>> +		if (early_irq_info_counter < ARRAY_SIZE(early_irq_infos))
>>>> +			irq_info = &early_irq_infos[early_irq_info_counter++];
>>>> +		else
>>>> +			return -ENOMEM;
>>>> +	} else {
>>>> +		/* nope, let's allocate a slot for this IRQ */
>>>> +		irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
>>>> +		if (!irq_info)
>>>> +			return -ENOMEM;
>>>> +	}
>>>>  
>>>>  	irq_info->irq = irq;
>>>>  	irq_info->penalty = new_penalty;
>>>> @@ -968,3 +978,4 @@ void __init acpi_pci_link_init(void)
>>>>  	register_syscore_ops(&irqrouter_syscore_ops);
>>>>  	acpi_scan_add_handler(&pci_link_handler);
>>>>  }
>>>> +
>>>> -- 
>>>> 1.8.2.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> -- 
>> Sinan Kaya
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

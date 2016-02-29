Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D4A53A.1070708@codeaurora.org>
Date: Mon, 29 Feb 2016 15:08:26 -0500
MIME-Version: 1.0
In-Reply-To: <20160229192420.GC3653@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2/29/2016 2:24 PM, Bjorn Helgaas wrote:
> On Thu, Feb 18, 2016 at 08:19:41AM -0500, Sinan Kaya wrote:
>> A crash has been observed when assigning penalty on x86 systems.
>>
>> It looks like this problem happens on x86 platforms with IOAPIC and an SCI
>> interrupt override in the ACPI table with interrupt number greater than
>> 16. (22 in this example)
>>
>> The bug has been introduced by "ACPI, PCI, irq: remove interrupt count
>> restriction" commit. The code was using kmalloc to resize the interrupt
> 
> When referring to a previous commit, please include the SHA1, e.g.,
> 
>   b5bd02695471 ("ACPI, PCI, irq: remove interrupt count restriction")

OK

> 
>> list. In this use case, the set penalty call is coming from early phase
>> and the heap is not initialized yet.
>>
>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>> IP: [<ffffffff811e8b9d>] kmem_cache_alloc_trace+0xad/0x1c0
>> PGD 0
>> Oops: 0000 [#1] SMP
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc2Feb-3_RK #1
>> Hardware name: HP Superdome2 16s, BIOS Bundle: 007.006.000 SFW: 033.162.000
>> 10/30/2015
>> [<ffffffff813bc190>] acpi_irq_set_penalty+0x60/0x8e
>> [<ffffffff813bc1df>] acpi_irq_add_penalty+0x21/0x26
>> [<ffffffff813bc76d>] acpi_penalize_sci_irq+0x25/0x28
>> [<ffffffff81b8260d>] acpi_sci_ioapic_setup+0x68/0x78
>> [<ffffffff81b830fc>] acpi_boot_init+0x2cc/0x533
>> [<ffffffff810677c8>] ? set_pte_vaddr_pud+0x48/0x50
>> [<ffffffff81b828cf>] ? acpi_parse_x2apic+0x77/0x77
>> [<ffffffff81b82858>] ? dmi_ignore_irq0_timer_override+0x30/0x30
>> [<ffffffff81b77c1e>] setup_arch+0xc24/0xce9
>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>> [<ffffffff81b6ed94>] start_kernel+0xfc/0x506
>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>> [<ffffffff81b6e5ee>] x86_64_start_reservations+0x2a/0x2c
>> [<ffffffff81b6e73c>] x86_64_start_kernel+0x14c/0x16f
>>
>> Besides from the use case above, there is one more situation where
>> set_penalty is being called from the init context like. There is support
>> for setting the penalty through kernel command line.
>>
>> Adding support to be called from early context for limited number of
>> interrupts.
> 
> I can't believe this whole IRQ penalty thing needs to be so
> complicated.
> 
> The only time we actually use the penalty information is when we're
> attaching a driver to a PCI device, i.e., in this path:
> 
>   pci_device_probe
>     pcibios_alloc_irq
>       pcibios_enable_irq
> 
> That happens pretty late, so there's no "can't allocate memory during
> early boot" problem.

Correct, this is the path that code is intended for.

> 
> I bet the only thing that might happen early enough to be an issue is
> the acpi_penalize_sci_irq() thing, which is a special case that
> doesn't need to be handled generically.

The second use case is the kernel command line. See the bottom of the code, 
there are routines there to go get the penalty information from command line.

How would you like to proceed ?

- merge this to the original patch
- remove the acpi_penalize_sci_irq code to somewhere else.
- what about the kernel command line?


> 
>> Reported-by: Nalla, Ravikanth <ravikanth.nalla@hpe.com>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/pci_link.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index fa28635..14fe3ca 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -47,6 +47,7 @@ ACPI_MODULE_NAME("pci_link");
>>  #define ACPI_PCI_LINK_FILE_INFO		"info"
>>  #define ACPI_PCI_LINK_FILE_STATUS	"state"
>>  #define ACPI_PCI_LINK_MAX_POSSIBLE	16
>> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024
>>  
>>  static int acpi_pci_link_add(struct acpi_device *device,
>>  			     const struct acpi_device_id *not_used);
>> @@ -473,6 +474,8 @@ struct irq_penalty_info {
>>  };
>>  
>>  static LIST_HEAD(acpi_irq_penalty_list);
>> +static struct irq_penalty_info early_irq_infos[ACPI_PCI_LINK_MAX_EARLY_IRQINFO];
>> +static int early_irq_info_counter;
>>  
>>  static int acpi_irq_get_penalty(int irq)
>>  {
>> @@ -507,10 +510,17 @@ static int acpi_irq_set_penalty(int irq, int new_penalty)
>>  		}
>>  	}
>>  
>> -	/* nope, let's allocate a slot for this IRQ */
>> -	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
>> -	if (!irq_info)
>> -		return -ENOMEM;
>> +	if (!acpi_gbl_permanent_mmap) {
>> +		if (early_irq_info_counter < ARRAY_SIZE(early_irq_infos))
>> +			irq_info = &early_irq_infos[early_irq_info_counter++];
>> +		else
>> +			return -ENOMEM;
>> +	} else {
>> +		/* nope, let's allocate a slot for this IRQ */
>> +		irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
>> +		if (!irq_info)
>> +			return -ENOMEM;
>> +	}
>>  
>>  	irq_info->irq = irq;
>>  	irq_info->penalty = new_penalty;
>> @@ -968,3 +978,4 @@ void __init acpi_pci_link_init(void)
>>  	register_syscore_ops(&irqrouter_syscore_ops);
>>  	acpi_scan_add_handler(&pci_link_handler);
>>  }
>> +
>> -- 
>> 1.8.2.1
>>
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

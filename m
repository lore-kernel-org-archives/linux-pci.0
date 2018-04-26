Return-Path: <SRS0=seWT=HP=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=seWT=HP=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 26 Apr 2018 11:03:22 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Linux PCI
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya
 <okaya@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt acknowledgement
In-Reply-To: <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-3-keith.busch@intel.com>
 <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ce4d5c59dd5106350a750e656ddbc3c3@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-04-04 02:08, Bjorn Helgaas wrote:
> [+cc Thomas, Rafael]
> 
> On Mon, Apr 02, 2018 at 10:21:58AM -0600, Keith Busch wrote:
>> From: Oza Pawandeep <poza@codeaurora.org>
>> 
>> The DPC driver was acknowledging the DPC interrupt status in deferred
>> work. That works for edge triggered interrupts, but causes an 
>> interrupt
>> storm with level triggered legacy interrupts.
>> 
>> This patch fixes that by clearing the interrupt status in interrupt
>> handler.
> 
> I'm fuzzy on this question of edge vs. level and where the interrupt
> should be cleared.  I'd like to understand this better and include the
> general rule in the changelog in case I'm not the only one who is
> unclear on this.
> 
> Here's my understanding, gleaned from kernel/irq/chip.c and
> https://notes.shichao.io/lkd/ch7/ :
> 
>   The generic IRQ handling code ensures that an interrupt handler runs
>   with its interrupt masked or disabled.  If the interrupt is
>   level-triggered, the interrupt handler must tell its device to stop
>   asserting the interrupt before returning.  If it doesn't, we will
>   immediately take the interrupt again when the handler returns and
>   the generic code unmasks the interrupt.
> 
>   The driver doesn't know whether its interrupt is edge- or
>   level-triggered, so it must clear its interrupt source directly in
>   its interrupt handler.
> 
> I'd also like to convince myself that we don't have similar issues
> with other services, e.g., AER, PME, pciehp.  Here are my notes about
> those:
> 
>   1) pciehp:
>     request_irq(irq, pcie_isr, ...)
>     pcie_isr
>       pciehp_isr
>         # clear Slot Status event bits
>         pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> 	events = status & (...)
> 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> 
>   2) AER:
>     request_irq(dev->irq, aer_irq, ...)
>     aer_irq
>       # clear AER Root Error Status bits
>       pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, 
> &status);
>       pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, 
> status);
> 
>   3) DPC:
>     devm_request_irq(..., dev->irq, dpc_irq, ...)
>     dpc_irq
>       schedule_work(<dpc_work>)
>     ...
>     dpc_work
>       # clear DPC Interrupt Status
>       pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> PCI_EXP_DPC_STATUS_INTERRUPT);
> 
>   4) PME:
>     request_irq(srv->irq, pcie_pme_irq, ...)
>     pcie_pme_irq
>       pcie_pme_interrupt_enable(port, false);
>         # clear PME Interrupt Enable
> 	pcie_capability_clear_word(dev, PCI_EXP_RTCTL, PCI_EXP_RTCTL_PMEIE);
>       schedule_work(<pcie_pme_work_fn>)
>     ...
>     pcie_pme_work_fn
>       # clear PME Status
>       pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
>       pcie_pme_interrupt_enable(port, true);
>         # set PME Interrupt Enable
>         pcie_capability_set_word(dev, PCI_EXP_RTCTL, 
> PCI_EXP_RTCTL_PMEIE);
> 
> The pciehp and AER cases look OK to me.  DPC looks definitely wrong,
> and this patch should fix it.
> 
> I *guess* PME looks OK, although I would feel better about it if it
> used the same strategy as the others.  All of these things have both
> "Interrupt Enable" and "Interrupt Status" bits.  PME is the only one
> that twiddles the Interrupt Enable in the interrupt path.
> 
> Bottom line, I think this patch is fine and I applied it with the
> following changelog:
> 
>   PCI/DPC: Clear interrupt status in interrupt handler top half
> 
>   The generic IRQ handling code ensures that an interrupt handler runs 
> with
>   its interrupt masked or disabled.  If the interrupt is 
> level-triggered, the
>   interrupt handler must tell its device to stop asserting the 
> interrupt
>   before returning.  If it doesn't, we will immediately take the 
> interrupt
>   again when the handler returns and the generic code unmasks the 
> interrupt.
> 
>   The driver doesn't know whether its interrupt is edge- or 
> level-triggered,
>   so it must clear its interrupt source directly in its interrupt 
> handler.
> 
>   Previously we cleared the DPC interrupt status in the bottom half, 
> i.e., in
>   deferred work, which can cause an interrupt storm if the DPC 
> interrupt
>   happens to be level-triggered, e.g., if we're using INTx instead of 
> MSI.
> 
>   Clear the DPC interrupt status bit in the interrupt handler, not in 
> the
>   deferred work.
> 
>   Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>   Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
>   [bhelgaas: changelog]
>   Reviewed-by: Keith Busch <keith.busch@intel.com>
> 
> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> [changelog]
>> Reviewed-by: Keith Busch <keith.busch@intel.com>
>> ---
>>  drivers/pci/pcie/pcie-dpc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index a9be6938417f..82644245cb4d 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -112,7 +112,7 @@ static void dpc_work(struct work_struct *work)
>>  	}
>> 
>>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>> -		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>> 
>>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
>>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
>> @@ -222,6 +222,9 @@ static irqreturn_t dpc_irq(int irq, void *context)
>>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>>  		dpc_process_rp_pio_error(dpc);
>> 
>> +	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_INTERRUPT);
>> +
>>  	schedule_work(&dpc->work);
>> 
>>  	return IRQ_HANDLED;
>> --
>> 2.14.3
>> 

Hi Bjorn,

Is this change left out in 4.17 for some reason ?


Regards,
Oza.

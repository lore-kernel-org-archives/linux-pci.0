Return-Path: <SRS0=ffoY=J7=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=ffoY=J7=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 16 Jul 2018 00:25:07 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
In-Reply-To: <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
 <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <a7eccede32492b13f9ba84404fbb997a@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-13 03:21, Bjorn Helgaas wrote:
> [+cc Keith for DPC question]
> 
> On Thu, Jul 12, 2018 at 11:33:42AM -0600, Thomas Tai wrote:
>> Hi Bjorn,
>> Thank you very much to review the V1 patch. I reworked the patch as
>> you have suggested. Your suggestion is indeed better and cleaner.
>> Would you please have a look for me?
>> 
>> FYI, I did not clear the device structure in aer_isr_one_error()
>> just to avoid over complicated the fix.
> 
> I think that was a bad idea anyway.  I think the problem there is that
> add_error_device() copies the pci_dev pointer without taking a
> reference on it:
> 
>   aer_isr
>     get_e_source              # dequeue from rpc->e_sources[]
>       *e_src = rpc->e_sources[x]
>     aer_isr_one_error
>       pdev = rpc->rpd         # pdev = Root Port pci_dev
>       find_source_device(pdev)
> 	find_device_iter
> 	  add_error_device
> 	    e_info->dev[i] = dev   # <-- save pci_dev pointer
>       aer_process_err_devices
> 	handle_error_source(e_info->dev[i])
> 	  pcie_do_fatal_recovery
> 
> At this point, we have pci_dev pointers in e_info->dev[] that are
> potentially stale.  Right now nobody uses them, but I think it's
> sloppy that we still have them at all.
> 
> I think a better way to fix this would be to call pci_dev_get() in
> add_error_device() when we save the pointer, and then do the
> corresponding pci_dev_put() in aer_isr_one_error(), after we return
> from aer_process_err_devices().
> 
> This could be done with a little helper function that iterates through
> e_info->dev[i], calls pci_dev_put() for each, and clears
> e_info->error_dev_num (which could then be removed from
> find_source_device()).
> 
> I think this would fix the problem you're seeing, so we wouldn't need
> the change in pcie_do_fatal_recovery().
> 
> However, I think we're also slightly exposed in dpc_work(), in 
> basically
> the same (possibly harmless) way.
> 
>   dpc_irq
>     schedule_work(&dpc->work)
>   ...
>   dpc_work
>     pdev = dpc->dev->port
>     pcie_do_fatal_recovery(pdev)
> 
> pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is 
> still
> holding onto a pointer (which it never uses again).
> 
> The DPC driver should be holding a reference to pdev (through some 
> black
> magic I don't understand), but that would be released when pdev is 
> removed,
> and I don't know what ensures that dpc_work() runs before that release.
> 

Is not that dpc_work() is calling pcie_do_fatal_recovery() which in-turn 
is removing pdev.
I do not see DPC is using any more reference beyond that.
So, isnt it safe to assume that no matter when the dpc_work() run, the 
pdev it reference is always intact.
this is with the fact, that both AER and DPC can not trigger 
simultaneously, and and hence no race for removal.
who else would remove that pdev other than AER and DPC ?

With Keith's patch, are not we just improving the latency with threaded 
irq instead of workqueue ?

the potential problem is another interrupt arriving while we have 
acknowledged it in dpc_reset_link() and we are about to remove the 
devices.
The acknowledgement of DPC status trigger and re-enabling interrupt can 
be done in
dpc_work() or threaded_handler() after we are done with 
pcie_do_fatal_recovery()

dpc_reset_link()
{
         following can be moved after pcie_do_fatal_recovery() ??
	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
			      PCI_EXP_DPC_STATUS_TRIGGER);

	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
			      ctl | PCI_EXP_DPC_CTL_INT_EN);
}

and probably following also one also can be done after recovery.

pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
			      PCI_EXP_DPC_STATUS_INTERRUPT);

I am not sure if this was the concern or I did talk about something else 
all together !

> Bjorn

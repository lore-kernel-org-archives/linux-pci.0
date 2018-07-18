Return-Path: <SRS0=jtRJ=KC=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=jtRJ=KC=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, poza@codeaurora.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
 <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <14a59c5c-8821-c326-e2ca-e822169c6a5c@oracle.com>
Date: Wed, 18 Jul 2018 17:32:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Keith,
Please have a look at the below inline comment.

On 07/12/2018 05:51 PM, Bjorn Helgaas wrote:
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
>    aer_isr
>      get_e_source              # dequeue from rpc->e_sources[]
>        *e_src = rpc->e_sources[x]
>      aer_isr_one_error
>        pdev = rpc->rpd         # pdev = Root Port pci_dev
>        find_source_device(pdev)
> 	find_device_iter
> 	  add_error_device
> 	    e_info->dev[i] = dev   # <-- save pci_dev pointer
>        aer_process_err_devices
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

I tried the request_threaded_irq() method, hoping that it will hold on 
to the device, unfortunately I am still seeing the use-after-free issue. 
I guess the next step is to implement Bjorn's suggestion. If we fix the 
issue in the add_error_device(), that would require DPC to hold on to 
the device. Would Keith has any concern about it?

Thank you,
Thomas

> 
> I think this would fix the problem you're seeing, so we wouldn't need
> the change in pcie_do_fatal_recovery().
> 
> However, I think we're also slightly exposed in dpc_work(), in basically
> the same (possibly harmless) way.
> 
>    dpc_irq
>      schedule_work(&dpc->work)
>    ...
>    dpc_work
>      pdev = dpc->dev->port
>      pcie_do_fatal_recovery(pdev)
> 
> pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is still
> holding onto a pointer (which it never uses again).
> 
> The DPC driver should be holding a reference to pdev (through some black
> magic I don't understand), but that would be released when pdev is removed,
> and I don't know what ensures that dpc_work() runs before that release.
> 
> Bjorn
> 

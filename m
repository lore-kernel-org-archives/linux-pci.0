Return-Path: <SRS0=AvBC=J4=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=AvBC=J4=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH] PCI/AER: fix use-after-free in pcie_do_fatal_recovery
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, poza@codeaurora.org, linux-pci@vger.kernel.org
References: <1531179952-11060-1-git-send-email-thomas.tai@oracle.com>
 <20180711224211.GA28466@bhelgaas-glaptop.roam.corp.google.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <675c2f93-d3a1-83ab-7688-58004e5c66eb@oracle.com>
Date: Thu, 12 Jul 2018 09:37:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180711224211.GA28466@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

[ ... ]
> Hmmm.  I suppose this is probably fallout from 7e9084b36740 ("PCI/AER:
> Handle ERR_FATAL with removal and re-enumeration of devices"), right?
> After that commit, we remove devices for fatal errors.
> 
> This looks like a regression we introduced in v4.18-rc1, so we should
> fix it for v4.18.

Hi Bjorn,
Thanks for your comment. Yes, you are right, this issue came from v4.18.

[ ... ]
>> @@ -309,7 +316,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>   	result = reset_link(udev, service);
>>   
>>   	if ((service == PCIE_PORT_SERVICE_AER) &&
>> -	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
>> +	    (hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
>>   		/*
>>   		 * If the error is reported by a bridge, we think this error
>>   		 * is related to the downstream link of the bridge, so we
>> @@ -322,13 +329,18 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>   	if (result == PCI_ERS_RESULT_RECOVERED) {
>>   		if (pcie_wait_for_link(udev, true))
>>   			pci_rescan_bus(udev->bus);
>> -		pci_info(dev, "Device recovery from fatal error successful\n");
>> +		pr_info("%s %s: Device recovery from fatal error successful\n",
>> +			driver_str, name_str);
>>   	} else {
>>   		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>> -		pci_info(dev, "Device recovery from fatal error failed\n");
>> +		pr_info("%s %s: Device recovery from fatal error failed\n",
>> +			driver_str, name_str);
> 
> If the problem is that "dev" has been deallocated, the
> pci_uevent_ers(dev) call above should also be a problem.

Right! you are correct, I missed out the other functions which use dev, 
let me follow your suggested path to dig around. Will keep you posted.

Thank you,
Thomas

> 
> The pci_cleanup_aer_uncorrect_error_status(dev) is also questionable.
> It's too complicated to argue that "we cache hdr_type just in case dev
> will be removed, but when dev is a bridge, we don't remove it, so it's
> safe to use it".
> 
> I think you're right that after pcie_do_fatal_recovery() calls
> pci_dev_put(pdev), the pdev may have been freed:
> 
>    pcie_do_fatal_recovery(dev)
>      udev = dev->bus->self            # bridge leading to "dev"
>      parent = udev->subordinate       # (same as dev->bus)
>      list_for_each_entry_safe_reverse(pdev, ..., &parent->devices)
>        pci_dev_get(pdev)              # "dev" is one of the pdevs
>        pci_stop_and_remove_bus_device(pdev)
>        pci_dev_put(pdev)
> 
> At this point, "dev" may point to a deallocated struct pci_dev, so
> *anything* that uses "dev" is a problem.
> 
> I think a better fix would be to add a pci_dev_get(dev) and
> pci_dev_put(dev) around the code that needs "dev", i.e., most of this
> function.
> 
> For completeness, I looked for issues in the callers of
> pcie_do_fatal_recovery().  Just for posterity:
> 
>    1)  aer_isr
> 	aer_isr_one_error
> 	  aer_process_err_devices
> 	    handle_error_source(e_info->dev[i])
> 	      pcie_do_fatal_recovery
> 
>      I don't think this path uses e_info->dev[i] after calling
>      pcie_do_fatal_recovery(), so it should be safe.  But it's probably
>      worth clearing out that pointer so we can catch any attempts to use
>      it.
> 
>    2)  aer_recover_queue
> 	kfifo_put(&aer_recover_ring, entry)
> 	schedule_work(&aer_recover_work)
>        ...
>        aer_recover_work_func
>          pdev = pci_get_domain_bus_and_slot(...)
> 	pcie_do_fatal_recovery(pdev)
> 	pci_dev_put(pdev)
> 
>      This path does a "get" on pdev before calling
>      pcie_do_fatal_recovery(), so it shouldn't have the use-after-free
>      problem because the free won't happen until the pci_dev_put(), and
>      it doesn't use "pdev" after that.
> 
>    3)  dpc_irq
> 	schedule_work(&dpc->work)
>        ...
>        dpc_work
> 	pcie_do_fatal_recovery(pdev)
> 
>      I think this path is OK too because we don't use "pdev" after
>      return.  It gets removed, of course, and the rescan should
>      rediscover it and reattach the DPC driver to it.
> 
>>   	}
>>   
>>   	pci_unlock_rescan_remove();
>> +
>> +	kfree(driver_str);
>> +	kfree(name_str);
>>   }
>>   
>>   /**
>> -- 
>> 1.8.3.1
>>

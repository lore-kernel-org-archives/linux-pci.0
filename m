Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:45906 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaDHJX0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 05:23:26 -0400
Message-ID: <5343BFBC.1030208@huawei.com>
Date: Tue, 8 Apr 2014 17:22:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] PCI: rename pci_is_bridge() to pci_has_subordinate()
References: <1394789889-11500-1-git-send-email-wangyijing@huawei.com> <20140404233157.GA15806@google.com>
In-Reply-To: <20140404233157.GA15806@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>  
>> -	/*
>> -	 * pci_is_bridge() is not suitable here, because pci_dev->subordinate
>> -	 * is set only after acpi_pci_find_device() has been called for the
>> -	 * given device.
>> -	 */
> 
> This hunk shouldn't be here.  My guess is that you intended to replace
> the code below with the new pci_is_bridge() that you introduced in
> patch [2/2].  That new pci_is_bridge() is never used, and it does the
> same hdr_type test as the code below.  But you apparently forgot to
> change this code to use it?
> 
>>  	check_children = pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE
>>  			|| pci_dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>>  	/* Please ref to ACPI spec for the syntax of _ADR */
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c


Hi Bjorn, I noticed the kernel compare (pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) directly
to identify bridge device. But the pci_is_brdge() helper function(which seems to do this) actually
only check the device whether has subordinate bus. This maybe confuses people.

So I think we should rename current pci_is_brdge(), and refactor a new pci_is_bridge() helper function.
This can make code more readable, also there are a lot of codes using (pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) directly compare.
If you think this make sense, we can replace them by the new pci_is_bridge().

eg. in acpiphp:

enable_device()
    ......
    	for (pass = 0; pass < 2; pass++) {
		list_for_each_entry(dev, &bus->devices, bus_list) {
			if (PCI_SLOT(dev->devfn) != slot->device)
				continue;
			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
				max = pci_scan_bridge(bus, dev, max, pass);
				if (pass && dev->subordinate)
					pci_bus_size_bridges(dev->subordinate);
			}
		}
	}
    ......

and in PCI core code

pci_rescan_bus()
    .......
    	down_read(&pci_bus_sem);
	list_for_each_entry(dev, &bus->devices, bus_list)
		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
			if (dev->subordinate)
				__pci_bus_size_bridges(dev->subordinate,
							 &add_list);
	up_read(&pci_bus_sem);
    ..........


Thanks!
Yijing.





>> index 25f0bc6..019dcb2 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -580,14 +580,14 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>>  {
>>  	pci_fixup_device(pci_fixup_resume, pci_dev);
>>  
>> -	if (!pci_is_bridge(pci_dev))
>> +	if (!pci_has_subordinate(pci_dev))
> 
> The rest of this is a simple rename and looks fine to me.
> 
>>  		pci_enable_wake(pci_dev, PCI_D0, false);
>>  }
>>  
>>  static void pci_pm_default_suspend(struct pci_dev *pci_dev)
>>  {
>>  	/* Disable non-bridge devices without PM support */
>> -	if (!pci_is_bridge(pci_dev))
>> +	if (!pci_has_subordinate(pci_dev))
>>  		pci_disable_enabled_device(pci_dev);
>>  }
>>  
>> @@ -711,7 +711,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>>  
>>  	if (!pci_dev->state_saved) {
>>  		pci_save_state(pci_dev);
>> -		if (!pci_is_bridge(pci_dev))
>> +		if (!pci_has_subordinate(pci_dev))
>>  			pci_prepare_to_sleep(pci_dev);
>>  	}
>>  
>> @@ -954,7 +954,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>>  			return error;
>>  	}
>>  
>> -	if (!pci_dev->state_saved && !pci_is_bridge(pci_dev))
>> +	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>>  		pci_prepare_to_sleep(pci_dev);
>>  
>>  	/*
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4df38df..a3b9cc1 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -79,7 +79,7 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
>>  	pm_wakeup_event(&dev->dev, 100);
>>  }
>>  
>> -static inline bool pci_is_bridge(struct pci_dev *pci_dev)
>> +static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
>>  {
>>  	return !!(pci_dev->subordinate);
>>  }
>> -- 
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing


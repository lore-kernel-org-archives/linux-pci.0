Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:48474 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaE1Ddg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 23:33:36 -0400
Message-ID: <538558D2.3050706@huawei.com>
Date: Wed, 28 May 2014 11:32:34 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com> <20140528032213.GP11907@google.com>
In-Reply-To: <20140528032213.GP11907@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/5/28 11:22, Bjorn Helgaas wrote:
> [+cc Yinghai]
> 
> On Thu, May 22, 2014 at 11:32:24AM +0800, Yijing Wang wrote:
>> Fix device_attach() return vaule in pci_bus_add_device
>> instead of meaningless 0.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/bus.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index ba2bf55..42b42b7 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -253,7 +253,7 @@ int pci_bus_add_device(struct pci_dev *dev)
>>  
>>  	dev->is_added = 1;
>>  
>> -	return 0;
>> +	return retval;
> 
> I'd like to see a Reviewed-by: from Yinghai, since he recently changed
> this area, e.g.,
> 
>   4f535093cf8f PCI: Put pci_dev in device tree as early as possible
>   58d9a38f6fac PCI: Skip attaching driver in device_add()

OK, Yinghai, can you look at this change ?

I found some kernel code still check this return value, and I also think return the
real retval make sense.

eg.

	list_for_each_entry(dev, &bus->devices, bus_list) {
		/* Skip already-added devices */
		if (dev->is_added)
			continue;
		retval = pci_bus_add_device(dev);
		if (retval)
			dev_err(&dev->dev, "Error adding device (%d)\n",
				retval);
	}



	if (!blocked) {
		dev = pci_get_slot(bus, 0);
		if (dev) {
			/* Device already present */
			pci_dev_put(dev);
			goto out_put_dev;
		}
		dev = pci_scan_single_device(bus, 0);
		if (dev) {
			pci_bus_assign_resources(bus);
			if (pci_bus_add_device(dev))
				pr_err("Unable to hotplug wifi\n");
		}

Thanks!
Yijing.



>>  }
>>  
>>  /**
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


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23173 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab2ISFxF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 01:53:05 -0400
Message-ID: <50595DA3.4030103@huawei.com>
Date: Wed, 19 Sep 2012 13:52:35 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/6] PCI/AER: fix pci_ops return NULL when hotplug a pci
 bus doing aer error inject
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>  <1348022442-7816-2-git-send-email-wangyijing@huawei.com> <1348031618.8212.124.camel@yhuang-dev>
In-Reply-To: <1348031618.8212.124.camel@yhuang-dev>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/19 13:13, Huang Ying wrote:
> On Wed, 2012-09-19 at 10:40 +0800, Yijing Wang wrote:
>> When we inject aer errors to the target pcie device by aer_inject module, the pci_ops of pci
>> bus which the target device is on will be assigned to pci_ops_aer.So if the target pci device
>> is a bridge, once we hot-remove and hot-add the bridge, the newly created child bus's pci_ops
>> will be assigned to pci_ops_aer too.Now every access to the child bus's devices will result to
>> system panic, because it get a NULL pci_ops in pci_read_aer/pci_write_aer.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Reviewed-by: Sven Dietrich <Sven.Dietrich@huawei.com>
>> ---
>>  drivers/pci/pcie/aer/aer_inject.c |   27 ++++++++++++++++++++++++++-
>>  1 files changed, 26 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
>> index 4e24cb8..0f00a27 100644
>> --- a/drivers/pci/pcie/aer/aer_inject.c
>> +++ b/drivers/pci/pcie/aer/aer_inject.c
>> @@ -109,6 +109,26 @@ static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
>>  	return __find_aer_error((u16)domain, dev->bus->number, dev->devfn);
>>  }
>>  
>> +/* find pci_ops of the nearest parent bus */
>> +static struct pci_ops *__find_pci_bus_ops_parent(struct pci_bus *bus)
>> +{
>> +	struct pci_bus_ops *bus_ops;
>> +	struct pci_bus *pbus = bus->parent;
>> +
>> +	if (!pbus)
>> +		return NULL;
>> +
>> +	while (pbus) {
>> +		list_for_each_entry(bus_ops, &pci_bus_ops_list, list)
>> +			if (bus_ops->bus == pbus)
>> +				return bus_ops->ops;
>> +
>> +		pbus = pbus->parent;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>  /* inject_lock must be held before calling */
>>  static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>>  {
>> @@ -118,7 +138,9 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>>  		if (bus_ops->bus == bus)
>>  			return bus_ops->ops;
>>  	}
>> -	return NULL;
>> +
>> +	/* can't find bus_ops, fall back to get bus_ops of upstream bus */
>> +	return __find_pci_bus_ops_parent(bus);
>>  }
>>  
>>  static struct pci_bus_ops *pci_bus_ops_pop(void)
>> @@ -208,6 +230,7 @@ static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
>>  	}
>>  out:
>>  	ops = __find_pci_bus_ops(bus);
>> +	BUG_ON(!ops);
>>  	spin_unlock_irqrestore(&inject_lock, flags);
>>  	return ops->read(bus, devfn, where, size, val);
>>  }
>> @@ -243,6 +266,7 @@ int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where, int size,
>>  	}
>>  out:
>>  	ops = __find_pci_bus_ops(bus);
>> +	BUG_ON(!ops);
>>  	spin_unlock_irqrestore(&inject_lock, flags);
>>  	return ops->write(bus, devfn, where, size, val);
>>  }
>> @@ -506,6 +530,7 @@ static struct miscdevice aer_inject_device = {
>>  	.fops = &aer_inject_fops,
>>  };
>>  
>> +
> 
> unnecessary new line?
> 

Yes, it's unnecessary, I will clean this later.

Thanks
Yijing

> Best Regards,
> Huang Ying
> 
>>  static int __init aer_inject_init(void)
>>  {
>>  	return misc_register(&aer_inject_device);
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing


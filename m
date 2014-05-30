Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:35617 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaE3CmS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 22:42:18 -0400
Message-ID: <5387EFFE.8020707@huawei.com>
Date: Fri, 30 May 2014 10:42:06 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/3] PCI: remove the unnecssary checking for pci_bus_add_device
References: <1401346866-11648-1-git-send-email-wangyijing@huawei.com> <1401346866-11648-2-git-send-email-wangyijing@huawei.com> <20140530020751.GA4607@google.com>
In-Reply-To: <20140530020751.GA4607@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/5/30 10:07, Bjorn Helgaas wrote:
> On Thu, May 29, 2014 at 03:01:04PM +0800, Yijing Wang wrote:
>> Kernel will WARN_ON(retval < 0) if device_attach() fail with
>> error in pci_bus_add_device(). currently, all the kernel code
>> to check pci_bus_add_device() return value only for printing
>> warning message, no other actions. So we can remove the
>> unnecessary checking codes.
> 
> If we remove all the checks of the return value, why wouldn't we convert it
> to a void function?  If we keep the return value, it seems like we're
> saying "this function could fail someday," but we removing all the code
> that would actually *check* for that failure.
> 
> If you convert it to void, please just squash them all into a single patch.

Hi Bjorn,
   I didn't convert it to void because the device_attach() has a __must_check prefix
which need a retval to avoid compiler warning. But as you mentioned, maybe this will
make people confuse. I will rework it and squash them into a single one.

Thanks!
Yijing.

> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/bus.c   |    6 +-----
>>  drivers/pci/iov.c   |    2 +-
>>  include/linux/pci.h |    2 +-
>>  3 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index ba2bf55..f0efbee 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -266,16 +266,12 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>>  {
>>  	struct pci_dev *dev;
>>  	struct pci_bus *child;
>> -	int retval;
>>  
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>>  		/* Skip already-added devices */
>>  		if (dev->is_added)
>>  			continue;
>> -		retval = pci_bus_add_device(dev);
>> -		if (retval)
>> -			dev_err(&dev->dev, "Error adding device (%d)\n",
>> -				retval);
>> +		pci_bus_add_device(dev);
>>  	}
>>  
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index de7a747..cb6f247 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -106,7 +106,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	pci_device_add(virtfn, virtfn->bus);
>>  	mutex_unlock(&iov->dev->sriov->lock);
>>  
>> -	rc = pci_bus_add_device(virtfn);
>> +	pci_bus_add_device(virtfn);
>>  	sprintf(buf, "virtfn%u", id);
>>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>>  	if (rc)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 65f22e8..3c4c0cf 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -781,7 +781,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn);
>>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
>> -int __must_check pci_bus_add_device(struct pci_dev *dev);
>> +int pci_bus_add_device(struct pci_dev *dev);
>>  void pci_read_bridge_bases(struct pci_bus *child);
>>  struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>>  					  struct resource *res);
>> -- 
>> 1.7.1
>>
>>
> 
> 


-- 
Thanks!
Yijing


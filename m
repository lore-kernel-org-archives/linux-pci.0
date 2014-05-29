Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:25880 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaE2Bhh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 21:37:37 -0400
Message-ID: <53868F40.8000909@huawei.com>
Date: Thu, 29 May 2014 09:37:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>	<20140528032213.GP11907@google.com>	<538558D2.3050706@huawei.com> <CAE9FiQWM15UHvX=7wv4aMXfTp5QLsB+J9c1qjOzpZ1vU0ePB4A@mail.gmail.com>
In-Reply-To: <CAE9FiQWM15UHvX=7wv4aMXfTp5QLsB+J9c1qjOzpZ1vU0ePB4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> I found some kernel code still check this return value, and I also think return the
>> real retval make sense.
> 
> No, that is not right.
> 
> If you look closely,
> 
> device_attach() returns
> 1: success
> 0: not attached
> <0: fail.

Hi Yinghai,
   Thanks for your explanation.
I found all the kernel code to check its return value, only for print a warning for users.


So I think we can drop all return checking from calling path, or rework pci_bus_add_device(),
return 0 if device_attach success, otherwise return -1, indicates the device not bound to a driver.

int pci_bus_add_device(struct pci_dev *dev)
{
	int retval;

	/*
	 * Can not put in pci_device_add yet because resources
	 * are not assigned yet for some devices.
	 */
	pci_fixup_device(pci_fixup_final, dev);
	pci_create_sysfs_dev_files(dev);
	pci_proc_attach_device(dev);

	dev->match_driver = true;
	retval = device_attach(&dev->dev);
	WARN_ON(retval < 0);

	dev->is_added = 1;

	return retval >=0 ? 0:-1;
}

Yinghai, which solution would you prefer?

Thanks!
Yijing.

> 
> so if you return ret directly, you have false warning from
> 
> drivers/edac/i82875p_edac.c:            err = pci_bus_add_device(dev);
> drivers/edac/i82875p_edac.c:                            "%s():
> pci_bus_add_device() Failed\n",
> drivers/platform/x86/asus-wmi.c:                                if
> (pci_bus_add_device(dev))
> drivers/platform/x86/eeepc-laptop.c:                            if
> (pci_bus_add_device(dev))
> 
> We already have
>     WARN_ON(retval < 0);
> 
> so please just remove all return checking from calling path.
> compiler already drop them...
> 
>>
>> eg.
>>
>>         list_for_each_entry(dev, &bus->devices, bus_list) {
>>                 /* Skip already-added devices */
>>                 if (dev->is_added)
>>                         continue;
>>                 retval = pci_bus_add_device(dev);
>>                 if (retval)
>>                         dev_err(&dev->dev, "Error adding device (%d)\n",
>>                                 retval);
> 
> should be dropped.
> 
>>         }
>>
>>
>>
>>         if (!blocked) {
>>                 dev = pci_get_slot(bus, 0);
>>                 if (dev) {
>>                         /* Device already present */
>>                         pci_dev_put(dev);
>>                         goto out_put_dev;
>>                 }
>>                 dev = pci_scan_single_device(bus, 0);
>>                 if (dev) {
>>                         pci_bus_assign_resources(bus);
>>                         if (pci_bus_add_device(dev))
>>                                 pr_err("Unable to hotplug wifi\n");
> oh, no, no one have that report. instead if should have trace printed out.
>>                 }
> 
> Thanks
> 
> Yinghai
> 
> .
> 


-- 
Thanks!
Yijing


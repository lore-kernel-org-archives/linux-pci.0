Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:45531 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbaE2A2Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 20:28:25 -0400
Received: by mail-ig0-f170.google.com with SMTP id uy17so2969297igb.5
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2014 17:28:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <538558D2.3050706@huawei.com>
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>
	<20140528032213.GP11907@google.com>
	<538558D2.3050706@huawei.com>
Date: Wed, 28 May 2014 17:28:24 -0700
Message-ID: <CAE9FiQWM15UHvX=7wv4aMXfTp5QLsB+J9c1qjOzpZ1vU0ePB4A@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 27, 2014 at 8:32 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/5/28 11:22, Bjorn Helgaas wrote:
>> [+cc Yinghai]
>>
>> On Thu, May 22, 2014 at 11:32:24AM +0800, Yijing Wang wrote:
>>> Fix device_attach() return vaule in pci_bus_add_device
>>> instead of meaningless 0.
>>>
>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> ---
>>>  drivers/pci/bus.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>> index ba2bf55..42b42b7 100644
>>> --- a/drivers/pci/bus.c
>>> +++ b/drivers/pci/bus.c
>>> @@ -253,7 +253,7 @@ int pci_bus_add_device(struct pci_dev *dev)
>>>
>>>      dev->is_added = 1;
>>>
>>> -    return 0;
>>> +    return retval;
>>
>> I'd like to see a Reviewed-by: from Yinghai, since he recently changed
>> this area, e.g.,
>>
>>   4f535093cf8f PCI: Put pci_dev in device tree as early as possible
>>   58d9a38f6fac PCI: Skip attaching driver in device_add()
>
> OK, Yinghai, can you look at this change ?
>
> I found some kernel code still check this return value, and I also think return the
> real retval make sense.

No, that is not right.

If you look closely,

device_attach() returns
1: success
0: not attached
<0: fail.

so if you return ret directly, you have false warning from

drivers/edac/i82875p_edac.c:            err = pci_bus_add_device(dev);
drivers/edac/i82875p_edac.c:                            "%s():
pci_bus_add_device() Failed\n",
drivers/platform/x86/asus-wmi.c:                                if
(pci_bus_add_device(dev))
drivers/platform/x86/eeepc-laptop.c:                            if
(pci_bus_add_device(dev))

We already have
    WARN_ON(retval < 0);

so please just remove all return checking from calling path.
compiler already drop them...

>
> eg.
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 /* Skip already-added devices */
>                 if (dev->is_added)
>                         continue;
>                 retval = pci_bus_add_device(dev);
>                 if (retval)
>                         dev_err(&dev->dev, "Error adding device (%d)\n",
>                                 retval);

should be dropped.

>         }
>
>
>
>         if (!blocked) {
>                 dev = pci_get_slot(bus, 0);
>                 if (dev) {
>                         /* Device already present */
>                         pci_dev_put(dev);
>                         goto out_put_dev;
>                 }
>                 dev = pci_scan_single_device(bus, 0);
>                 if (dev) {
>                         pci_bus_assign_resources(bus);
>                         if (pci_bus_add_device(dev))
>                                 pr_err("Unable to hotplug wifi\n");
oh, no, no one have that report. instead if should have trace printed out.
>                 }

Thanks

Yinghai

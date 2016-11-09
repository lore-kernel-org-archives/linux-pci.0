Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33109 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbcKIU7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 15:59:43 -0500
Received: by mail-yw0-f171.google.com with SMTP id r204so222438417ywb.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2016 12:59:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161109195812.GA7528@wunner.de>
References: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org> <20161109195812.GA7528@wunner.de>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 9 Nov 2016 12:59:01 -0800
Message-ID: <CACK8Z6EJ45m+_fSNPQGpoTq52vWHwRyDguO6Syau3XFUt-HdkA@mail.gmail.com>
Subject: Re: [PATCH] pciehp_resume: don't add existing device
To: Lukas Wunner <lukas@wunner.de>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-pci@vger.kernel.org, Todd Broch <tbroch@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        paul.gortmaker@windriver.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 9, 2016 at 11:58 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Nov 09, 2016 at 10:05:35AM -0800, Ravi Chandra Sadineni wrote:
>> If a slot was occupied before supend, and nothing has changed after
>> resume, we call pciehp_enable_slot() although it fails a little
>> later with the message:
>>    Device XXXX:XX:XX.X already exists at XXXX:XX:XX, cannot hot-add
>>    Cannot add device at XXXX:XX:XX
>>
>> This was partly discussed here: https://lkml.org/lkml/2013/7/9/452
>> and I'm pulling only the part4 of that patch, since it does not change
>> anything functionally (or atleast does not seem to make it worse), but
>> prevents uncomfortable messages pointed above.

Missing "Signed-off-by" :-)

>> ---
>>  drivers/pci/hotplug/pciehp_core.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
>> index 612b21a..873cff8 100644
>> --- a/drivers/pci/hotplug/pciehp_core.c
>> +++ b/drivers/pci/hotplug/pciehp_core.c
>> @@ -290,6 +290,7 @@ static int pciehp_resume(struct pcie_device *dev)
>>  {
>>       struct controller *ctrl;
>>       struct slot *slot;
>> +     struct pci_bus *pbus = dev->port->subordinate;
>>       u8 status;
>>
>>       ctrl = get_service_data(dev);
>> @@ -302,10 +303,13 @@ static int pciehp_resume(struct pcie_device *dev)
>>       /* Check if slot is occupied */
>>       pciehp_get_adapter_status(slot, &status);
>>       mutex_lock(&slot->hotplug_lock);
>> -     if (status)
>> -             pciehp_enable_slot(slot);
>> -     else
>> +     if (status) {

should be "} else {" (on the same line)


>> +             if (list_empty(&pbus->devices))
>> +                     pciehp_enable_slot(slot);
>> +     }
>> +     else {
>>               pciehp_disable_slot(slot);
>> +     }
>
> What if the device plugged in after suspend is a different one
> and requires e.g. an entirely different driver or different resource
> allocations?

I may be missing it completely, but this situation does not seem be
handled well today (even without this patch). In the cases that you
mention, it seems to me that the code will bail out (as of today) a
little later in pciehp_configure_device().

       dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
        if (dev) {
                ctrl_err(ctrl, "Device %s already exists at
%04x:%02x:00, cannot hot-add\n",
                         pci_name(dev), pci_domain_nr(parent), parent->number);
                pci_dev_put(dev);
                ret = -EEXIST;
                goto out;
        }

I wasn't able to figure out that if the device was replaced, how the
old driver would be notified or the new driver's probe routine get
called. Or how do the resources get assigned to the new device?

So I'm trying to understand if this patch makes things any worse than
they are now (since atleast it makes the resume time quite faster
(avoiding up to 1 second delay in pciehp_check_link_status waiting for
link))?

>
> What if the device is the same but child devices have been plugged
> in during system sleep? (E.g. additional devices attached to a
> Thunderbolt daisy chain.)
>
> At the very least you need to rescan the bus here.

I agree. But how does this work today then?

Thanks,

Rajat




>
> Thanks,
>
> Lukas
>
>>       mutex_unlock(&slot->hotplug_lock);
>>       return 0;
>>  }
>> --
>> 2.6.6

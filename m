Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:40446 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbGQBPF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 21:15:05 -0400
Message-ID: <55A856F2.1040900@huawei.com>
Date: Fri, 17 Jul 2015 09:14:26 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rajat Jain <rajatja@google.com>,
	"Guenter Roeck" <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com> <20150716042203.GC25591@google.com> <55A76361.8070604@huawei.com> <20150716152548.GD25591@google.com>
In-Reply-To: <20150716152548.GD25591@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> If I'm mistaken, please correct me and explain why this patch is safe.
>>
>> Hi Bjorn, I think pci_bus_sem here was introduced to protect the bus->slots list, because it
>> use down_write() here, for bus->devices list, we only traverse it, won't add/remove it, for the latter, down_read() is enough.
>> When I posted this patch, I thought we should protect the bus when we start to register a slot,
>> something like a big lock at outermost routine to tell others not to touch its children devices, use pci_bus_sem to protect hotplug
>> cases is not a good idea, and actually in PCI code, we have found several deadlock caused by the pci_bus_sem.
>>
>> But for this patch, I know what you worried, what about add a down_read(&pci_bus_sem) to avoid to introduce a regression ?
>>
>>
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 396c200..a9079d9 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -14,6 +14,7 @@
>>
>>  struct kset *pci_slots_kset;
>>  EXPORT_SYMBOL_GPL(pci_slots_kset);
>> +static DEFINE_MUTEX(pci_slot_mutex);
>>
>>  static ssize_t pci_slot_attr_show(struct kobject *kobj,
>>                                         struct attribute *attr, char *buf)
>> @@ -106,9 +107,11 @@ static void pci_slot_release(struct kobject *kobj)
>>         dev_dbg(&slot->bus->dev, "dev %02x, released physical slot %s\n",
>>                 slot->number, pci_slot_name(slot));
>>
>> +       down_read(&pci_bus_sem);
>>         list_for_each_entry(dev, &slot->bus->devices, bus_list)
>>                 if (PCI_SLOT(dev->devfn) == slot->number)
>>                         dev->slot = NULL;
>> +       up_read(&pci_bus_sem);
>>
>>         list_del(&slot->list);
> 
> This list_del() updates the bus->slots list.

It's safe here, because we have locked the pci_slot_mutex in pci_destroy_slot(), which is the only caller of pci_slot_release().

Thanks!
Yijing.

> 
>> @@ -195,7 +198,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>>  {
>>         struct pci_slot *slot;
>>         /*
>> -        * We already hold pci_bus_sem so don't worry
>> +        * We already hold pci_slot_mutex so don't worry
>>          */
>>         list_for_each_entry(slot, &parent->slots, list)
>>                 if (slot->number == slot_nr) {
>> @@ -253,7 +256,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>         int err = 0;
>>         char *slot_name = NULL;
>>
>> -       down_write(&pci_bus_sem);
>> +       mutex_lock(&pci_slot_mutex);
>>
>>         if (slot_nr == -1)
>>                 goto placeholder;
>> @@ -301,16 +304,18 @@ placeholder:
>>         INIT_LIST_HEAD(&slot->list);
>>         list_add(&slot->list, &parent->slots);
>>
>> +       down_read(&pci_bus_sem);
>>         list_for_each_entry(dev, &parent->devices, bus_list)
>>                 if (PCI_SLOT(dev->devfn) == slot_nr)
>>                         dev->slot = slot;
>> +       up_read(&pci_bus_sem);
>>
>>         dev_dbg(&parent->dev, "dev %02x, created physical slot %s\n",
>>                 slot_nr, pci_slot_name(slot));
>>
>>  out:
>>         kfree(slot_name);
>> -       up_write(&pci_bus_sem);
>> +       mutex_unlock(&pci_slot_mutex);
>>         return slot;
>>  err:
>>         kfree(slot);
>> @@ -332,9 +337,9 @@ void pci_destroy_slot(struct pci_slot *slot)
>>         dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
>>                 slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);
>>
>> -       down_write(&pci_bus_sem);
>> +       mutex_lock(&pci_slot_mutex);
>>         kobject_put(&slot->kobj);
>> -       up_write(&pci_bus_sem);
>> +       mutex_unlock(&pci_slot_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_destroy_slot);
> 
> .
> 


-- 
Thanks!
Yijing


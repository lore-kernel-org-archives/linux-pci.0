Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34678 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbGQCqp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 22:46:45 -0400
Received: by wgkl9 with SMTP id l9so71853619wgk.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2015 19:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55A86754.7070408@huawei.com>
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com>
 <20150716042203.GC25591@google.com> <55A76361.8070604@huawei.com>
 <20150716152548.GD25591@google.com> <55A856F2.1040900@huawei.com>
 <CAErSpo6UTEfBieOm3P4Ms45rXhp5SS80QqU_wcDjNswdBzzifg@mail.gmail.com>
 <55A8605A.6000902@huawei.com> <CAErSpo56r2ZK59jWF9LhT=Vqy8E6FS_ozS2ye978=OfVjEi4iA@mail.gmail.com>
 <55A86754.7070408@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Jul 2015 21:46:24 -0500
Message-ID: <CAErSpo78rQW0LE8gVyHiZst4FC_m1B4ts2zf-vX5zr+4CQK+=A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 16, 2015 at 9:24 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>>>> This list_del() updates the bus->slots list.
>>>>>
>>>>> It's safe here, because we have locked the pci_slot_mutex in pci_destroy_slot(), which is the only caller of pci_slot_release().
>>>>
>>>> That doesn't protect anybody else who might be traversing the
>>>> bus->slots list while we're deleting this entry.
>>>
>>> Hi Bjorn, sorry, I don't understand your point, before this patch, we use pci_bus_sem to protect the whole pci_slot_release(),
>>> in which, we would traverse the bus->devices list and update the bus->slots list. And now what we did is introduce a new pci_slot_mutex
>>> to protect the bus->slots here, and use down_read(pci_bus_sem) instead of down_write(pci_bus_sem).
>>
>> pci_setup_device() does this:
>>
>>         list_for_each_entry(slot, &dev->bus->slots, list)
>>                 if (PCI_SLOT(dev->devfn) == slot->number)
>>                         dev->slot = slot;
>>
>> What keeps that code from running at the same time pci_slot_release()
>> is removing something from the bus->slots list?
>>
>> It looks to me like the loop in pci_setup_device() is unsafe to begin
>> with.  But the obvious thing to do would be to add
>> down_read(&pci_bus_sem) there, and then you'd need a down_write() in
>> pci_slot_release(), so you're back where we started.
>
> I got it, I missed the bus->slots list traverse in pci scan code,
> What about moving the bus->slots loop code from pci_setup_device() to drivers/pci/slot.c, and add a pci_slot_mutex to protect it ?
> I think we should avoid to use pci_bus_sem to protect bus->slots list.

Seems better, although it's starting to feel a bit ad hoc.  We would
need to write down this locking rule somewhere, e.g., near the struct
pci_bus declaration.

> Something like this:
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..6f00273 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1149,10 +1149,7 @@ int pci_setup_device(struct pci_dev *dev)
>         dev->error_state = pci_channel_io_normal;
>         set_pcie_port_type(dev);
>
> -       list_for_each_entry(slot, &dev->bus->slots, list)
> -               if (PCI_SLOT(dev->devfn) == slot->number)
> -                       dev->slot = slot;
> -
> +       pci_dev_assign_slot(dev);
>         /* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
>            set this higher, assuming the system even supports it.  */
>         dev->dma_mask = 0xffffffff;
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index a9079d9..cf259e7 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -99,6 +99,15 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>         return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
>
> +void pci_dev_assign_slot(struct pci_dev *dev)
> +{
> +       mutex_lock(&pci_slot_mutex);
> +       list_for_each_entry(slot, &dev->bus->slots, list)
> +               if (PCI_SLOT(dev->devfn) == slot->number)
> +                       dev->slot = slot;
> +       mutex_unlock(&pci_slot_mutex);
> +}
> +
>  static void pci_slot_release(struct kobject *kobj)
>  {
>         struct pci_dev *dev;
>
>
>>
>>>>>>> @@ -195,7 +198,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>>>>>>>  {
>>>>>>>         struct pci_slot *slot;
>>>>>>>         /*
>>>>>>> -        * We already hold pci_bus_sem so don't worry
>>>>>>> +        * We already hold pci_slot_mutex so don't worry
>>>>>>>          */
>>>>>>>         list_for_each_entry(slot, &parent->slots, list)
>>>>>>>                 if (slot->number == slot_nr) {
>>>>>>> @@ -253,7 +256,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>>>>>>         int err = 0;
>>>>>>>         char *slot_name = NULL;
>>>>>>>
>>>>>>> -       down_write(&pci_bus_sem);
>>>>>>> +       mutex_lock(&pci_slot_mutex);
>>>>>>>
>>>>>>>         if (slot_nr == -1)
>>>>>>>                 goto placeholder;
>>>>>>> @@ -301,16 +304,18 @@ placeholder:
>>>>>>>         INIT_LIST_HEAD(&slot->list);
>>>>>>>         list_add(&slot->list, &parent->slots);
>>>>>>>
>>>>>>> +       down_read(&pci_bus_sem);
>>>>>>>         list_for_each_entry(dev, &parent->devices, bus_list)
>>>>>>>                 if (PCI_SLOT(dev->devfn) == slot_nr)
>>>>>>>                         dev->slot = slot;
>>>>>>> +       up_read(&pci_bus_sem);
>>>>>>>
>>>>>>>         dev_dbg(&parent->dev, "dev %02x, created physical slot %s\n",
>>>>>>>                 slot_nr, pci_slot_name(slot));
>>>>>>>
>>>>>>>  out:
>>>>>>>         kfree(slot_name);
>>>>>>> -       up_write(&pci_bus_sem);
>>>>>>> +       mutex_unlock(&pci_slot_mutex);
>>>>>>>         return slot;
>>>>>>>  err:
>>>>>>>         kfree(slot);
>>>>>>> @@ -332,9 +337,9 @@ void pci_destroy_slot(struct pci_slot *slot)
>>>>>>>         dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
>>>>>>>                 slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);
>>>>>>>
>>>>>>> -       down_write(&pci_bus_sem);
>>>>>>> +       mutex_lock(&pci_slot_mutex);
>>>>>>>         kobject_put(&slot->kobj);
>>>>>>> -       up_write(&pci_bus_sem);
>>>>>>> +       mutex_unlock(&pci_slot_mutex);
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL_GPL(pci_destroy_slot);
>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Thanks!
>>>>> Yijing
>>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>> --
>>> Thanks!
>>> Yijing
>>>
>>
>> .
>>
>
>
> --
> Thanks!
> Yijing
>

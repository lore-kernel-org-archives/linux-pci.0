Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:22797 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbGPH6N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 03:58:13 -0400
Message-ID: <55A76361.8070604@huawei.com>
Date: Thu, 16 Jul 2015 15:55:13 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rajat Jain <rajatja@google.com>,
	"Guenter Roeck" <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com> <20150716042203.GC25591@google.com>
In-Reply-To: <20150716042203.GC25591@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/16 12:22, Bjorn Helgaas wrote:
> [+cc Guenter, Rafael]
> 
> On Thu, Jun 11, 2015 at 07:12:14PM +0800, Yijing Wang wrote:
>> Rajat Jain reported a deadlock when a hierarchical hot plug
>> thread and aer recovery thread both run.
>> https://lkml.org/lkml/2015/3/11/861
>>
>> thread 1:
>> pciehp_enable_slot()
>> 	pciehp_configure_device()
>> 		pci_bus_add_devices()
>> 			device_attach(dev)
>> 				device_lock(dev) //acquire device mutex successfully
>> 			...
>> 			pciehp_probe(dev)
>> 				__pci_hp_register()
>> 					pci_create_slot()
>> 						down_write(pci_bus_sem) //deadlock here
>>
>> thread 2:
>> aer_isr_one_error()
>> 	aer_process_err_device()
>> 		do_recovery()
>> 			broadcast_error_message()
>> 				pci_walk_bus()
>> 					down_read(&pci_bus_sem) //acquire pci_bus_sem successfully
>> 						report_error_detected(dev)
>> 							device_lock(dev) // deadlock here
>>
>> Now we use pci_bus_sem to protect pci_slot creation and destroy,
>> it's unnecessary. We could introduce a new local mutex instead of
>> pci_bus_sem to avoid the deadlock.
> 
> I see there's definitely a problem here, and using a new mutex instead of
> pci_bus_sem certainly avoids the deadlock.
> 
> I'm trying to convince myself that it is safe.  I think we need to protect:
> 
>   - search of bus->slots list in get_slot()
>   - addition to bus->slots list in pci_create_slot()
>   - search of bus->devices list in pci_create_slot()
>   - search of bus->devices list in pci_slot_release()
>   - deletion from bus->slots list in pci_slot_release()
> 
> Most other maintenance of these lists is protected by pci_bus_sem, so using
> a different mutex here seems like a problem.
> 
> If I'm mistaken, please correct me and explain why this patch is safe.

Hi Bjorn, I think pci_bus_sem here was introduced to protect the bus->slots list, because it
use down_write() here, for bus->devices list, we only traverse it, won't add/remove it, for the latter, down_read() is enough.
When I posted this patch, I thought we should protect the bus when we start to register a slot,
something like a big lock at outermost routine to tell others not to touch its children devices, use pci_bus_sem to protect hotplug
cases is not a good idea, and actually in PCI code, we have found several deadlock caused by the pci_bus_sem.

But for this patch, I know what you worried, what about add a down_read(&pci_bus_sem) to avoid to introduce a regression ?


diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 396c200..a9079d9 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -14,6 +14,7 @@

 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
+static DEFINE_MUTEX(pci_slot_mutex);

 static ssize_t pci_slot_attr_show(struct kobject *kobj,
                                        struct attribute *attr, char *buf)
@@ -106,9 +107,11 @@ static void pci_slot_release(struct kobject *kobj)
        dev_dbg(&slot->bus->dev, "dev %02x, released physical slot %s\n",
                slot->number, pci_slot_name(slot));

+       down_read(&pci_bus_sem);
        list_for_each_entry(dev, &slot->bus->devices, bus_list)
                if (PCI_SLOT(dev->devfn) == slot->number)
                        dev->slot = NULL;
+       up_read(&pci_bus_sem);

        list_del(&slot->list);

@@ -195,7 +198,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 {
        struct pci_slot *slot;
        /*
-        * We already hold pci_bus_sem so don't worry
+        * We already hold pci_slot_mutex so don't worry
         */
        list_for_each_entry(slot, &parent->slots, list)
                if (slot->number == slot_nr) {
@@ -253,7 +256,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
        int err = 0;
        char *slot_name = NULL;

-       down_write(&pci_bus_sem);
+       mutex_lock(&pci_slot_mutex);

        if (slot_nr == -1)
                goto placeholder;
@@ -301,16 +304,18 @@ placeholder:
        INIT_LIST_HEAD(&slot->list);
        list_add(&slot->list, &parent->slots);

+       down_read(&pci_bus_sem);
        list_for_each_entry(dev, &parent->devices, bus_list)
                if (PCI_SLOT(dev->devfn) == slot_nr)
                        dev->slot = slot;
+       up_read(&pci_bus_sem);

        dev_dbg(&parent->dev, "dev %02x, created physical slot %s\n",
                slot_nr, pci_slot_name(slot));

 out:
        kfree(slot_name);
-       up_write(&pci_bus_sem);
+       mutex_unlock(&pci_slot_mutex);
        return slot;
 err:
        kfree(slot);
@@ -332,9 +337,9 @@ void pci_destroy_slot(struct pci_slot *slot)
        dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
                slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);

-       down_write(&pci_bus_sem);
+       mutex_lock(&pci_slot_mutex);
        kobject_put(&slot->kobj);
-       up_write(&pci_bus_sem);
+       mutex_unlock(&pci_slot_mutex);
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);


Thanks!
Yijing.




> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/slot.c |   11 ++++++-----
>>  1 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 396c200..feb08de 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -14,6 +14,7 @@
>>  
>>  struct kset *pci_slots_kset;
>>  EXPORT_SYMBOL_GPL(pci_slots_kset);
>> +static DEFINE_MUTEX(pci_slot_mutex);
>>  
>>  static ssize_t pci_slot_attr_show(struct kobject *kobj,
>>  					struct attribute *attr, char *buf)
>> @@ -195,7 +196,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>>  {
>>  	struct pci_slot *slot;
>>  	/*
>> -	 * We already hold pci_bus_sem so don't worry
>> +	 * We already hold pci_slot_mutex so don't worry
>>  	 */
>>  	list_for_each_entry(slot, &parent->slots, list)
>>  		if (slot->number == slot_nr) {
>> @@ -253,7 +254,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>  	int err = 0;
>>  	char *slot_name = NULL;
>>  
>> -	down_write(&pci_bus_sem);
>> +	mutex_lock(&pci_slot_mutex);
>>  
>>  	if (slot_nr == -1)
>>  		goto placeholder;
>> @@ -310,7 +311,7 @@ placeholder:
>>  
>>  out:
>>  	kfree(slot_name);
>> -	up_write(&pci_bus_sem);
>> +	mutex_unlock(&pci_slot_mutex);
>>  	return slot;
>>  err:
>>  	kfree(slot);
>> @@ -332,9 +333,9 @@ void pci_destroy_slot(struct pci_slot *slot)
>>  	dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
>>  		slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);
>>  
>> -	down_write(&pci_bus_sem);
>> +	mutex_lock(&pci_slot_mutex);
>>  	kobject_put(&slot->kobj);
>> -	up_write(&pci_bus_sem);
>> +	mutex_unlock(&pci_slot_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_destroy_slot);
>>  
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:2583 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbbFSDg6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 23:36:58 -0400
Message-ID: <55838E50.5000803@huawei.com>
Date: Fri, 19 Jun 2015 11:36:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Trivial comment fix
References: <1434628020-4143-1-git-send-email-wangyijing@huawei.com> <20150618162454.GC7710@google.com>
In-Reply-To: <20150618162454.GC7710@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/19 0:24, Bjorn Helgaas wrote:
> Hi Yijing,
> 
> The subject should start with a verb, e.g., "Fix DocBook comments".
> 
> On Thu, Jun 18, 2015 at 07:47:00PM +0800, Yijing Wang wrote:
> 
> This needs a changelog, even if it's a trivial one.

OK.

> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/hotplug/pci_hotplug_core.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
>> index 56d8486..117c8f9 100644
>> --- a/drivers/pci/hotplug/pci_hotplug_core.c
>> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
>> @@ -408,8 +408,8 @@ static struct hotplug_slot *get_slot_from_name(const char *name)
>>  
>>  /**
>>   * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
>> - * @bus: bus this slot is on
>>   * @slot: pointer to the &struct hotplug_slot to register
>> + * @bus: bus this slot is on
>>   * @devnr: device number
>>   * @name: name registered with kobject core
>>   * @owner: caller module owner
>> @@ -469,7 +469,7 @@ EXPORT_SYMBOL_GPL(__pci_hp_register);
>>   * pci_hp_deregister - deregister a hotplug_slot with the PCI hotplug subsystem
>>   * @hotplug: pointer to the &struct hotplug_slot to deregister
>>   *
>> - * The @slot must have been registered with the pci hotplug subsystem
>> + * The @hotplug must have been registered with the pci hotplug subsystem
> 
> This doesn't read like English because "hotplug" is not a noun.
> 
> Please extend your patch so the entire file consistently uses "slot" for a
> struct hotplug_slot, and "pci_slot" for a struct pci_slot.  Right now, the
> file is a mix of random names, which is confusing and leads to errors.
> 
> You might need to do this with more than one patch to make it possible to
> review it.


I rework this patch and rename struct hotplug_slot to slot, and rename
struct pci_slot to pci_slot, so we could distinguish them easily.
Also I would update the comment in that patch.

Thanks!
Yijing.

> 
>>   * previously with a call to pci_hp_register().
>>   *
>>   * Returns 0 if successful, anything else for an error.
>> @@ -509,7 +509,7 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
>>   * @hotplug: pointer to the slot whose info has changed
>>   * @info: pointer to the info copy into the slot's info structure
>>   *
>> - * @slot must have been registered with the pci
>> + * @hotplug must have been registered with the pci
>>   * hotplug subsystem previously with a call to pci_hp_register().
>>   *
>>   * Returns 0 if successful, anything else for an error.
>> -- 
>> 1.7.1
>>
> 
> 


-- 
Thanks!
Yijing


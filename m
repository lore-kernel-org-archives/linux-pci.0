Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33817 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab2EJXyZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 May 2012 19:54:25 -0400
Message-ID: <4FAC5518.5060807@redhat.com>
Date: Fri, 11 May 2012 07:54:00 +0800
From: Amos Kong <akong@redhat.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, alex.williamson@redhat.com,
	kevin@koconnor.net
Subject: Re: [Qemu-devel] [PATCH v3] pci: clean all funcs when hot-removing
 multifunc device
References: <1315976141-6684-1-git-send-email-akong@redhat.com> <20120510154423.11306.85353.stgit@t> <4FABF639.4070205@gmail.com> <20120510185516.GI14647@redhat.com>
In-Reply-To: <20120510185516.GI14647@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2012 02:55 AM, Michael S. Tsirkin wrote:
> On Fri, May 11, 2012 at 01:09:13AM +0800, Jiang Liu wrote:
>> On 05/10/2012 11:44 PM, Amos Kong wrote:
>>
>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>>> index 806c44f..a7442d9 100644
>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>>> @@ -885,7 +885,7 @@ static void disable_bridges(struct pci_bus *bus)
>>>  static int disable_device(struct acpiphp_slot *slot)
>>>  {
>>>  	struct acpiphp_func *func;
>>> -	struct pci_dev *pdev;
>>> +	struct pci_dev *pdev, *tmp;
>>>  	struct pci_bus *bus = slot->bridge->pci_bus;
>>>  
>>>  	/* The slot will be enabled when func 0 is added, so check
>>> @@ -902,9 +902,10 @@ static int disable_device(struct acpiphp_slot *slot)
>>>  			func->bridge = NULL;
>>>  		}
>>>  
>>> -		pdev = pci_get_slot(slot->bridge->pci_bus,
>>> -				    PCI_DEVFN(slot->device, func->function));
>>> -		if (pdev) {
>>> +		list_for_each_entry_safe(pdev, tmp, &bus->devices, bus_list) {
>>> +			if (PCI_SLOT(pdev->devfn) != slot->device)
>>> +				continue;
>>> +
>> The pci_bus_sem lock should be acquired when walking the bus->devices list.
>> Otherwise it may cause invalid memory access if another thread is modifying
>> the bus->devices list concurrently.


>> BTW, what's the relationship with "[PATCH v3] hotplug: add device per func
>> in ACPI DSDT tables"? Seems they are both solving the same issue.

Two work need to be done when we disable a slot, cleaning
configuration(in OS) and power off slot.

Currently the second part(power off) works fine, all funcs disappear
from "(qemu)#info block" after hot-remove slot.
The only problem is func 1~7 are not unconfigured, so I NAKed seabios
patch, and try to fix this problem in pci driver.

(btw, winxp & win7 hotplug works currently)

/**
 * acpiphp_disable_slot - power off slot
 * @slot: ACPI PHP slot
 */
int acpiphp_disable_slot(struct acpiphp_slot *slot)
{
        mutex_lock(&slot->crit_sect);

        /* unconfigure all functions */
        retval = disable_device(slot);

        /* power off all functions */
        retval = power_off_slot(slot);
        ....
}

> That's a bios patch. It's needed if you want broken linux to work.  This
> makes linux behave properly on the original bios.
> 
>>>  			pci_stop_bus_device(pdev);
>>>  			if (pdev->subordinate) {
>>>  				disable_bridges(pdev->subordinate);



-- 
			Amos.

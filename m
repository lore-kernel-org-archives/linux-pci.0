Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42705 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659Ab2EKOAx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2012 10:00:53 -0400
Received: by dady13 with SMTP id y13so3141151dad.19
        for <linux-pci@vger.kernel.org>; Fri, 11 May 2012 07:00:53 -0700 (PDT)
Message-ID: <4FAD1B88.2060905@gmail.com>
Date: Fri, 11 May 2012 22:00:40 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Amos Kong <akong@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, alex.williamson@redhat.com,
	kevin@koconnor.net
Subject: Re: [Qemu-devel] [PATCH v3] pci: clean all funcs when hot-removing
 multifunc device
References: <1315976141-6684-1-git-send-email-akong@redhat.com> <20120510154423.11306.85353.stgit@t> <4FABF639.4070205@gmail.com> <20120510185516.GI14647@redhat.com> <4FAC5518.5060807@redhat.com> <4FAC5C32.9080009@redhat.com>
In-Reply-To: <4FAC5C32.9080009@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2012 08:24 AM, Amos Kong wrote:
> On 05/11/2012 07:54 AM, Amos Kong wrote:
>> On 05/11/2012 02:55 AM, Michael S. Tsirkin wrote:
>>> On Fri, May 11, 2012 at 01:09:13AM +0800, Jiang Liu wrote:
>>>> On 05/10/2012 11:44 PM, Amos Kong wrote:
>>>>
>>>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>>>>> index 806c44f..a7442d9 100644
>>>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>>>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>>>>> @@ -885,7 +885,7 @@ static void disable_bridges(struct pci_bus *bus)
>>>>>  static int disable_device(struct acpiphp_slot *slot)
>>>>>  {
>>>>>  	struct acpiphp_func *func;
>>>>> -	struct pci_dev *pdev;
>>>>> +	struct pci_dev *pdev, *tmp;
>>>>>  	struct pci_bus *bus = slot->bridge->pci_bus;
>>>>>  
>>>>>  	/* The slot will be enabled when func 0 is added, so check
>>>>> @@ -902,9 +902,10 @@ static int disable_device(struct acpiphp_slot *slot)
>>>>>  			func->bridge = NULL;
>>>>>  		}
>>>>>  
>>>>> -		pdev = pci_get_slot(slot->bridge->pci_bus,
>>>>> -				    PCI_DEVFN(slot->device, func->function));
>>>>> -		if (pdev) {
>>>>> +		list_for_each_entry_safe(pdev, tmp, &bus->devices, bus_list) {
>>>>> +			if (PCI_SLOT(pdev->devfn) != slot->device)
>>>>> +				continue;
>>>>> +
>>>> The pci_bus_sem lock should be acquired when walking the bus->devices list.
>>>> Otherwise it may cause invalid memory access if another thread is modifying
>>>> the bus->devices list concurrently.
> 
> pci_bus_sem lock is only request for writing &bus->devices list, right ?
> and this protection already exists in pci_destory_dev().
That's for writer. For reader to walk the pci_bus->devices list, you also need
to acquire the reader lock by down_read(&pci_bus_sem). Please refer to 
pci_get_slot() for example. This especially import for native OS because there
may be multiple PCI slots/devices on the bus.


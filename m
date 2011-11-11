Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758164Ab1KKTNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Nov 2011 14:13:14 -0500
Message-ID: <4EBD73C8.8070407@redhat.com>
Date: Fri, 11 Nov 2011 14:13:12 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: James Paradis <jparadis@redhat.com>
CC: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2011 12:41 PM, James Paradis wrote:
> Hmmm... would it be better to do this as a quirk or as a boot
> parameter?  I've heard reports that other systems may be running
Hearsay?  if you have definite cases, then please share them,
so folks know when to flip the boot parameter on.  
note: it would have to be an early boot param as well.
> into similar issues... if we don't know exactly which systems
> these are then maybe a boot parameter would be a more flexible
> approach...
>
> --jim
>
> ----- Original Message -----
>> On 11/10/2011 09:31 AM, Matthew Wilcox wrote:
>>> On Thu, Nov 10, 2011 at 09:00:13AM -0500, Prarit Bhargava wrote:
>>>> Stratus systems have a hierarchy that includes a PCIE Downstream
>>>> bridge
>>>> connected to a PCIE Upstream bridge and a PCI Downstream bridge.
>>>>   The system
>>>> boots with this wrong hierarchy into a crippled mode (USB doesn't
>>>> work,
>>>> network doesn't work ...).  Avoiding the Downstream bridge check
>>>> in
>>>> only_one_child() causes all the bridges to be enumerated and the
>>>> system
>>>> to function properly.
>>>
>>>> @@ -1275,7 +1276,15 @@ static int only_one_child(struct pci_bus
>>>> *bus)
>>>>    	struct pci_dev *parent = bus->self;
>>>>    	if (!parent || !pci_is_pcie(parent))
>>>>    		return 0;
>>>> -	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
>>>> +	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
>>>> +		return 1;
>>>> +	/*
>>>> +	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in
>>>> which
>>>> +	 * one upstream and one downstream port are plugged into a
>>>> downstream
>>>> +	 * port.  Avoiding the downstream port check here results in a
>>>> +	 * functional system.
>>>> +	 */
>>>> +	if (!dmi_name_in_vendors("ftServer")&&
>>>>    	parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
>>>>    		return 1;
>>>>    	return 0;
>>>
>>> dmi_name_in_vendors is relatively expensive, so the order of these
>>> two
>>> should be swapped, at least:
>>>
>>>> 	if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM&&
>>>>    	!dmi_name_in_vendors("ftServer"))
>>>
>>> Plus, this gets called for every PCI bridge.  We should be caching
>>> it
>>> somewhere, so it's only called once.
>>>
>> Then i recommend a dmi_name_in_vendors() check at init; stick result
>> in
>> global (or local static), and then it's not exec'd on each bridge,
>> just
>> a simple flag check.
>> If that's the case, I'd re-cast my vote for putting the code in
>> pci_quirks
>> with an export, so it is tracked as a quirk.  that may get messy
>> wrt other arches though (the export in common code; not sure if
>> quirks is
>> included on all arches).
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


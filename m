Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556528DA.60809@oracle.com>
Date: Tue, 26 May 2015 22:15:54 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Sander Eikelenboom <linux@eikelenboom.it>, david.vrabel@citrix.com,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI / ACPI: Do not set ACPI companions for host bridges
 with parents
References: <555FDDA1.8030806@oracle.com> <2625308.mOex6suvmm@vostro.rjw.lan> <556483E3.4010202@oracle.com> <1758616.haLhQtkBS0@vostro.rjw.lan>
In-Reply-To: <1758616.haLhQtkBS0@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/26/2015 08:07 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 26, 2015 10:32:03 AM Boris Ostrovsky wrote:
>> On 05/25/2015 10:17 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, May 26, 2015 03:08:17 AM Rafael J. Wysocki wrote:
>>>> On Tuesday, May 26, 2015 01:42:16 AM Rafael J. Wysocki wrote:
>>>>> On Tuesday, May 26, 2015 01:22:12 AM Rafael J. Wysocki wrote:
>>>>>> On Friday, May 22, 2015 09:53:37 PM Boris Ostrovsky wrote:
>>>>>>> On 05/22/2015 04:11 AM, Sander Eikelenboom wrote:
>>>>>>>> Hello Sander,
>>>>>>>>
>>>>> [cut]
>>>>>
>>>>>>> (+Rafael again)
>>>>>>>
>>>>>>> So the immediate cause of those errors is that pdev->evtchn is 0.
>>>>>>> Backend is not notified and things not go well then.
>>>>>>>
>>>>>>> And it is indeed caused by 97badf873ab60e841243b66133ff9eff2a46ef29:
>>>>>>>
>>>>>>> We allocate pcifront_sd in pcifront_scan_root() and then pass it to
>>>>>>> pci_scan_bus_parented() as sysdata. Eventually this sysdata is used in
>>>>>>> pcibios_root_bridge_prepare() as pci_sysdata. It is dereferenced as
>>>>>>> pci_sysdata->companion (which I believe is aliased to pcifront_sd->pdev)
>>>>> Well, there is an int node field between them, so I'm not sure.
>>>>>
>>>>>>> and then set_primary_fwnode() writes it, thus corrupting
>>>>>>> pcifront_sd->pdev (and I think this is what sets evtchn to zero).
>>>>> So the corruption happens when set_primary_fwnode() writes NULL to the
>>>>> 'secondary' field of object pointed to by 'fwnode'.
>>>>>
>>>>> This isn't strictly necessary and we might avoid the crash by only
>>>>> writing to fwnode->secondary if fn is not NULL.
>>>>>
>>>>> So, Sander please test the patch below too if possible.
>>>>>
>>>>> Of course, that doesn't solve a problem of passing an incorrect pointer
>>>>> to ACPI_COMPANION_SET() in pcibios_root_bridge_prepare().
>>>> And here's one more thing to test.
>>> And the below is how I'd fix it, so you can simply test this patch and skip the
>>> previous ones.
>>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: PCI / ACPI: Do not set ACPI companions for host bridges with parents
>>>
>>> Commit 97badf873ab6 (device property: Make it possible to use
>>> secondary firmware nodes) uncovered a bug in the x86 (and ia64) PCI
>>> host bridge initialization code that assumes bridge->bus->sysdata
>>> to always point to a struct pci_sysdata object which need not be
>>> the case (in particular, the Xen PCI frontend driver sets it to point
>>> to a different data type).  If it is not the case, an incorrect
>>> pointer (or a piece of data that is not a pointer at all) will be
>>> passed to ACPI_COMPANION_SET() and that may cause interesting
>>> breakage to happen going forward.
>>>
>>> To work around this problem use the observation that the ACPI
>>> host bridge initialization always passes NULL as parent to
>>> pci_create_root_bus(), so if pcibios_root_bridge_prepare() sees
>>> a non-NULL parent of the bridge, it should not attempt to set
>>> an ACPI companion for it, because that means that
>>> pci_create_root_bus() has been called by someone else.
>>
>> I am wondering whether at some point we might want to use companion
>> information in Xen as well.
>>
>> Another option might be to require that whoever creates their own
>> sysdata structure to have pci_sysdata as its first element, e.g.
> Well, I was thinking about that, but it would be x86-specific and I believe
> that Xen is supposed to work on other architectures too (or at least will be
> in the future).
>
>> --- a/drivers/pci/xen-pcifront.c
>> +++ b/drivers/pci/xen-pcifront.c
>> @@ -52,7 +52,12 @@ struct pcifront_device {
>>    };
>>
>>    struct pcifront_sd {
>> +       /*
>> +        * Must be the first element of this structure since pcifront_sd
>> +        * is assigned to bus' sysdata and may later be dereferenced as
>> +        * pci_sysdata.
>> +        */
>> +       struct pci_sysdata sd;
>>           struct pcifront_device *pdev;
>>    };
> Also if you want to use an ACPI companion, it will be a good question *which* one.
>
> My half-way educated guess is that will be the ACPI companion of the parent,
> in which case it's better to modify pcibios_root_bridge_prepare().  In any
> case, we need to talk about that beforehand, so please let me know when you
> have more specific plans.

I don't have anything specific. And after looking at this code some more 
I am not sure pcifront will ever want to use companions since ACPI is 
not part of device initialization here (it's done via xenbus, which is a 
purely software construct).


>
> As for 4.1 (which currently is broken for Sander), I think the $subject patch
> is the cleanest and least intrusive thing we can do.

OK. Thank you for fixing this.

-boris


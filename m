Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbbCJP3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Mar 2015 11:29:06 -0400
Message-ID: <54FF0DC0.2010308@ti.com>
Date: Tue, 10 Mar 2015 11:29:04 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PCI] BUG: unable to handle kernel
References: <20150306060631.GD28187@wfg-t540p.sh.intel.com> <54F9C407.5020602@ti.com> <54F9CC6B.5070803@ti.com> <20150306165504.GA30094@roeck-us.net> <54F9EAA8.30007@ti.com> <54FDAB8B.3010404@ti.com> <CAErSpo52A+S-SSp2TG=W3oskyg_pgg9LYZzrissvfTogTSazPg@mail.gmail.com> <54FDC1FC.2030807@ti.com> <54FDC52B.1070602@roeck-us.net> <54FDD277.2060406@ti.com> <54FDD995.1080000@roeck-us.net> <54FDE1EC.9040207@ti.com> <54FDE29A.1060400@roeck-us.net>
In-Reply-To: <54FDE29A.1060400@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/09/2015 02:12 PM, Guenter Roeck wrote:
> On 03/09/2015 11:09 AM, Murali Karicheri wrote:
>> On 03/09/2015 01:34 PM, Guenter Roeck wrote:
>>> On 03/09/2015 10:03 AM, Murali Karicheri wrote:
>>>> On 03/09/2015 12:07 PM, Guenter Roeck wrote:
>>>>> On 03/09/2015 08:53 AM, Murali Karicheri wrote:
>>>>>> On 03/09/2015 10:44 AM, Bjorn Helgaas wrote:
>>>>>>> On Mon, Mar 9, 2015 at 9:17 AM, Murali
>>>>>>> Karicheri<m-karicheri2@ti.com>
>>>>>>> wrote:
>>>>>>>> On 03/06/2015 12:58 PM, Murali Karicheri wrote:
>>>>>>>>>
>>>>>>>>> On 03/06/2015 11:55 AM, Guenter Roeck wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Mar 06, 2015 at 10:48:59AM -0500, Murali Karicheri wrote:
>>>>>>>>>> [ ... ]
>>>>>>>>>>
>>>>>>>>>>>> From 098b4f5e4ab9407fbdbfcca3a91785c17e25cf03 Mon Sep 17
>>>>>>>>>>>> 00:00:00 2001
>>>>>>>>>>> From: Murali Karicheri<m-karicheri2@ti.com>
>>>>>>>>>>> Date: Fri, 6 Mar 2015 10:23:08 -0500
>>>>>>>>>>> Subject: [PATCH] pci: of : fix kernel crash
>>>>>>>>>>>
>>>>>>>>>>> This is a debug patch to root cause the kernel crash
>>>>>>>>>>>
>>>>>>>>>>> commit 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6
>>>>>>>>>>>
>>>>>>>>>>> PCI: Update DMA configuration from DT
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/of/of_pci.c | 8 ++++++++
>>>>>>>>>>> drivers/pci/host-bridge.c | 5 +++++
>>>>>>>>>>> 2 files changed, 13 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>>>>>>>>>>> index 86d3c38..5a59fb8 100644
>>>>>>>>>>> --- a/drivers/of/of_pci.c
>>>>>>>>>>> +++ b/drivers/of/of_pci.c
>>>>>>>>>>> @@ -129,6 +129,14 @@ void of_pci_dma_configure(struct pci_dev
>>>>>>>>>>> *pci_dev)
>>>>>>>>>>> struct device *dev =&pci_dev->dev;
>>>>>>>>>>> struct device *bridge = pci_get_host_bridge_device(pci_dev);
>>>>>>>>>>>
>>>>>>>>>>> + if (!bridge || !bridge->parent) {
>>>>>>>>>>> + if (!bridge)
>>>>>>>>>>> + pr_err("PCI bridge not found\n");
>>>>>>>>>>> + if (!bridge->parent)
>>>>>>>>>>> + pr_err("PCI bridge parent not found\n");
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> You'll see a crash here if bridge is NULL. Maybe add an else
>>>>>>>>>> before
>>>>>>>>>> the second
>>>>>>>>>> if statement ? Also, dev_err might be a bit more useful and
>>>>>>>>>> would be
>>>>>>>>>> available.
>>>>>>>>>>
>>>>>>>>> Fixed and attached.
>>>>>>>>>
>>>>>>>>> Murali
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Guenter
>>>>>>>>>>
>>>>>>>>>>> + return;
>>>>>>>>>>> + }
>>>>>>>>>>> +
>>>>>>>>>>> of_dma_configure(dev, bridge->parent->of_node);
>>>>>>>>>>> pci_put_host_bridge_device(bridge);
>>>>>>>>>>> }
>>>>>>>>>>> diff --git a/drivers/pci/host-bridge.c
>>>>>>>>>>> b/drivers/pci/host-bridge.c
>>>>>>>>>>> index 3e5bbf9..ef2ab51 100644
>>>>>>>>>>> --- a/drivers/pci/host-bridge.c
>>>>>>>>>>> +++ b/drivers/pci/host-bridge.c
>>>>>>>>>>> @@ -28,6 +28,11 @@ struct device
>>>>>>>>>>> *pci_get_host_bridge_device(struct
>>>>>>>>>>> pci_dev *dev)
>>>>>>>>>>> struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
>>>>>>>>>>> struct device *bridge = root_bus->bridge;
>>>>>>>>>>>
>>>>>>>>>>> + if (!bridge) {
>>>>>>>>>>> + pr_err("PCI: bridge not found\n");
>>>>>>>>>>> + return NULL;
>>>>>>>>>>> + }
>>>>>>>>>>> +
>>>>>>>>>>> kobject_get(&bridge->kobj);
>>>>>>>>>>> return bridge;
>>>>>>>>>>> }
>>>>>>>>>>> --
>>>>>>>>>>> 1.7.9.5
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>> BJorn,
>>>>>>>>
>>>>>>>> Any chance of applying the attached debug patch to see if this
>>>>>>>> fixes
>>>>>>>> and
>>>>>>>> provide some additional information on this BUG? Not sure who will
>>>>>>>> pick this
>>>>>>>> one and apply.
>>>>>>>
>>>>>>> The change that caused the oops (0b2af171520e ("PCI: Update DMA
>>>>>>> configuration from DT")) only exists on my pci/iommu branch, so I'm
>>>>>>> the one to apply it.
>>>>>>>
>>>>>>> It's much easier for me to deal with plain text patches (not
>>>>>>> attachments).
>>>>>>>
>>>>>>> I'm hesitating because I don't want to encourage use of the 0-day
>>>>>>> testing robot as a tool at which we can just throw debug patches.
>>>>>>> The
>>>>>>> robot is a service that costs somebody real money, and I want to
>>>>>>> be a
>>>>>>> good neighbor when using it.
>>>>>>
>>>>>> Thanks for the clarification as I don't have much information on the
>>>>>> testing robot. At the same time the question is how similar incidence
>>>>>> in the past have been handled. I am a newbie w.r.t to this. This is
>>>>>> first time I have introduced a patch that impacts multiple
>>>>>> arch/machines.
>>>>>>
>>>>>>>
>>>>>>> Was the information in the robot's report enough to reproduce the
>>>>>>> oops? If not, is there additional information we could add to the
>>>>>>> report that would enable you to reproduce it? Even if we can't
>>>>>>> reproduce the oops, the report seems detailed enough that we
>>>>>>> should be
>>>>>>> able to deduce the problem and produce a fix in which we have high
>>>>>>> confidence.
>>>>>>
>>>>>> The BUG report essentially indicates the crash happened in
>>>>>> of_pci_dma_configure(). The machine specific log make sense to a
>>>>>> person familiar with this arch and I am not familiar with the
>>>>>> same. So
>>>>>> anyone can help narrow down the root cause of this?
>>>>>>
>>>>>> Looking at the code, there are two ptr variables that are accessed
>>>>>> without checking for NULL as initial thinking was that these can
>>>>>> never
>>>>>> be NULL. So the debug patch is just adding addition check before
>>>>>> accessing the ptr. I can send this patch without debug prints if that
>>>>>> make sense. I was thinking to get confirmation that this is indeed
>>>>>> the
>>>>>> case before adding the check. What do you think the right approach
>>>>>> here? Send a patch for this to the ML for adding the check as a
>>>>>> potential fix? Or someone can help me investigate the crash dump and
>>>>>> root cause it? or if we can use test robot to confirm this, I can
>>>>>> re-send the patch ASIS to the list. Please clarify.
>>>>>>
>>>>> If the assumption is that the pointers can never be NULL,
>>>>> wouldn't it be important to see a call trace and to find out
>>>>> if the NULL pointers can actually be seen by design,
>>>>> or if there is some other bug ?
>>>>
>>>> Call trace shows
>>>>
>>>> [ 0.576666] [<7976c1ac>] pci_device_add+0xbc/0x820
>>>> [ 0.576666] [<7976c1ac>] pci_device_add+0xbc/0x820
>>>>
>>>>
>>>> And BUG seems to be in of_pci_dma_configure() as shown in the BUG
>>>> report.
>>>>
>>>> of_pci_dma_configure() calls newly added API call to
>>>> pci_get_host_bridge_device(). Seems like this has succeeded which
>>>> means bridge is non NULL IMO. However in this function it passes
>>>> bridge->parent->of_node to of_dma_configure(). So I suspect
>>>> bridge->parent is NULL for some reason. Is there a chance for parent
>>>> being NULL in this or any other platform?
>>>>
>>>
>>> Can bridge be the root bridge ?
>>
>> Going by the code below, bridge is assigned the ptr to bridge on the
>> root bus.
>>
>> +struct device *pci_get_host_bridge_device(struct pci_dev *dev)
>> +{
>> + struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
>> + struct device *bridge = root_bus->bridge;
>> +
>> + kobject_get(&bridge->kobj);
>> + return bridge;
>> +}
>> +
>>
>> So to answer your question, yes it is the root bridge.
>>
> AFAIK the root bridge does not have a parent.
>
> Guenter
>
BJorn,

Just posted a patch to the PCI list which I believe is a potential fix 
for this issue. Please review and apply if looks good.

Subject patch : pci: of : fix BUG: unable to handle kernel

-- 
Murali Karicheri
Linux Kernel, Texas Instruments

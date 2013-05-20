Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55745 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab3ETP2J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 11:28:09 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so945932pbc.40
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2013 08:28:08 -0700 (PDT)
Message-ID: <519A40F8.5010306@gmail.com>
Date: Mon, 20 May 2013 23:27:52 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>, Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: unset the resource if we can't get the correct
 CPU address
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com> <1368536876-27307-3-git-send-email-haokexin@gmail.com> <519506BF.3010400@gmail.com> <20130517021128.GB13975@pek-khao-d1.corp.ad.wrs.com> <519643E8.3020102@gmail.com> <20130519022445.GA25698@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130519022445.GA25698@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun 19 May 2013 10:24:45 AM CST, Kevin Hao wrote:
> On Fri, May 17, 2013 at 10:51:20PM +0800, Liu Jiang wrote:
>> On Fri 17 May 2013 10:11:29 AM CST, Kevin Hao wrote:
>>> On Fri, May 17, 2013 at 12:18:07AM +0800, Liu Jiang wrote:
>>>> On Tue 14 May 2013 09:07:56 PM CST, Kevin Hao wrote:
>>>>> In the current kernel, we just set the CPU address to the bus address
>>>>> if we can't find the match region for one specific bus address. If BAR
>>>>> of one pci device is set to address which happens to be a legitimate
>>>>> CPU address by firmware, the kernel will think this resource is legal
>>>>> and will not try to reassign later. In cases the CPU address and bus
>>>>> address isn't equal, the device will not work. So we should check
>>>>> if we can translate the bus address to CPU address correctly. If not,
>>>>> we should unset this resource and wish the kernel will reassign it
>>>>> later.
>>>>>
>>>>> Since we will invoke pcibios_bus_to_resource unconditionally if we
>>>>> don't goto fail, move it out of if/else wrap.
>>>>>
>>>>> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>>>>> ---
>>>>>   drivers/pci/probe.c | 9 ++++++---
>>>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>> index 70f10fa..c96772f 100644
>>>>> --- a/drivers/pci/probe.c
>>>>> +++ b/drivers/pci/probe.c
>>>>> @@ -250,12 +250,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>>>>>   			pci_write_config_dword(dev, pos + 4, 0);
>>>>>   			region.start = 0;
>>>>>   			region.end = sz64;
>>>>> -			pcibios_bus_to_resource(dev, res, &region);
>>>>>   			bar_disabled = true;
>>>>>   		} else {
>>>>>   			region.start = l64;
>>>>>   			region.end = l64 + sz64;
>>>>> -			pcibios_bus_to_resource(dev, res, &region);
>>>>>   		}
>>>>>   	} else {
>>>>>   		sz = pci_size(l, sz, mask);
>>>>> @@ -265,7 +263,12 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>>>>>
>>>>>   		region.start = l;
>>>>>   		region.end = l + sz;
>>>>> -		pcibios_bus_to_resource(dev, res, &region);
>>>>> +	}
>>>>> +
>>>>> +	if (!pcibios_bus_to_resource(dev, res, &region)) {
>>>>> +		res->flags |= IORESOURCE_UNSET;
>>>>> +		res->end -= res->start;
>>>>> +		res->start = 0;
>>>>>   	}
>>>>>
>>>>>   	goto out;
>>>>
>>>> Hi Kevin,
>>>>       Will this break subtractive decode PCI bridges and devices?
>>>
>>> No. A subtractive decode occurs only when no other pci bridge or device
>>> claim the transactions. As you can see that when we are trying to translate
>>> a bus address to cpu address we search the address regions of pci host
>>> bridge instead of a pci bridge. The pci host bridge address regions should
>>> cover all the bus address we can use for the pci device or bridge under this
>>> pci controller. This definitely also include the bus address regions used by
>>> the expansion bus for subtractive decode. So if a pci device use a bus address
>>> that is unknown to this pci host bridge, there is definitely something wrong
>>> here. This is the case we are trying to fix.
>>>
>> Hi Kevin,
>>        I'm not sure about this assumption "the pci host bridge
>> address regions should cover
>> all the bus address we can use for the pci device or bridge under
>> this pci controller".
>> I have a fear that it may cause regressions to some legacy x86
>> platforms, such as an AMD
>> platform with PCI based IOAPICs, though I have no evidences for it.
>
> Does any x86 expert can confirm whether the assumption that "the pci host
> bridge address regions should cover all the bus address we can use for the
> pci device or bridge under this pci host bridge" is true or not on x86?
> It seems definitely wrong in logical. But things always happen out of
> expectation in reality. :-)
>
> Thanks,
> Kevin
>
>> Regards!
>> Gerry
>>> Thanks,
>>> Kevin
>>>
>>>> Regards!
>>>> Gerry
>>
>>

Hi Yinghai,
      Any comments here?

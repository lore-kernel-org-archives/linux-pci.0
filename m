Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:59768 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaIYBXw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 21:23:52 -0400
Message-ID: <54236E7B.5000905@huawei.com>
Date: Thu, 25 Sep 2014 09:23:07 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com> <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com> <5409117E.2000002@huawei.com> <alpine.LRH.2.03.1409241547430.4696@AMR> <CAErSpo5upA7KYVo=_SvwJ9pdNot_5ENi3OtiPpuzZjpwj3ghPA@mail.gmail.com>
In-Reply-To: <CAErSpo5upA7KYVo=_SvwJ9pdNot_5ENi3OtiPpuzZjpwj3ghPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/9/25 7:30, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2014 at 4:41 PM, Keith Busch <keith.busch@intel.com> wrote:
>> Just poking this thread to make sure it's not dead. :)
>>
>> I tested Yijing's proposal and it is successful on our Intel server
>> platforms; hoping either this or something that derives similar behavior
>> will be applied so we can remove bus tuning kernel parameters.
>>
>> Tested-by: Keith Busch <keith.busch@intel.com>
> 
> Oops, thanks for poking me, because this was indeed dead.
> 
> My main objection was to testing "is_hotplug_bridge".  That doesn't
> seem right, because this issue really isn't specific to hotplug.  I
> didn't see a resolution of that, but let me know if I missed it.

Why I introduced "is_hotplug_bridge" is to avoid to touch the MPS which is not
in hotplug case when pcie_bus_config == PCIE_BUS_TUNE_OFF.

It's so sad that PCIe spec doesn't give a detailed guide to configure MPS.

I'd like to refactor current MPS framework, but now there are still some puzzles
to me. I need to have a deeper understanding of pcie mps. I read Jon's mps patch
log from git, I found he turn off all this MPS config, because some issues were found
in some platforms, but no platforms detailed info and no bugzilla records.


> 
> Bjorn
> 
>> On Thu, 4 Sep 2014, Yijing Wang wrote:
>>>>>>>
>>>>>>>      if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>>>>>> +            pcie_bus_update_set(dev);
>>>>>>
>>>>>>
>>>>>> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
>>>>>> problem occur for other pcie_bus_config settings?
>>>>>
>>>>>
>>>>> We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like
>>>>> PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
>>>>> This issue won't happen.
>>>>
>>>>
>>>> Sorry, I can't parse this.  Are you saying the problem won't happen in
>>>> the other modes?  Why not?
>>>
>>>
>>> Hi Bjorn, when in PCIE_BUS_SAFE mode, pcie_find_smpss() will find the
>>> largest available mpss in a pcie path.
>>> Then call pcie_bus_configure_set() to set all devices' mps to the largest
>>> available mps in this path, so
>>> all devices in the path will have the same mps. When in
>>> PCIE_BUS_PEER2PEER, all devices' mps will be set to 128B
>>> for safety. And to the PCIE_BUS_PERFORMANCE mode, I found Jon's comment in
>>> pcie_write_mps(),
>>>
>>>                         /* For "Performance", the assumption is made that
>>>                          * downstream communication will never be larger
>>> than
>>>                          * the MRRS.  So, the MPS only needs to be
>>> configured
>>>                          * for the upstream communication.  This being the
>>> case, <------
>>>                          * walk from the top down and set the MPS of the
>>> child
>>>                          * to that of the parent bus.
>>>
>>> So I think the problem won't happen in other modes.
>>>
>>> Thanks!
>>> Yijing.
>>>
>>>
>>>>
>>>>>>>              pcie_bus_detect_mps(dev);
>>>>>>>              return 0;
>>>>>>>      }
>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>> --
>>> Thanks!
>>> Yijing
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing


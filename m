Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:57692 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaIXXbA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 19:31:00 -0400
Received: by mail-qc0-f169.google.com with SMTP id r5so3167144qcx.28
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2014 16:30:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.03.1409241547430.4696@AMR>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
 <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com>
 <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com>
 <5409117E.2000002@huawei.com> <alpine.LRH.2.03.1409241547430.4696@AMR>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Sep 2014 17:30:39 -0600
Message-ID: <CAErSpo5upA7KYVo=_SvwJ9pdNot_5ENi3OtiPpuzZjpwj3ghPA@mail.gmail.com>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
To: Keith Busch <keith.busch@intel.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 24, 2014 at 4:41 PM, Keith Busch <keith.busch@intel.com> wrote:
> Just poking this thread to make sure it's not dead. :)
>
> I tested Yijing's proposal and it is successful on our Intel server
> platforms; hoping either this or something that derives similar behavior
> will be applied so we can remove bus tuning kernel parameters.
>
> Tested-by: Keith Busch <keith.busch@intel.com>

Oops, thanks for poking me, because this was indeed dead.

My main objection was to testing "is_hotplug_bridge".  That doesn't
seem right, because this issue really isn't specific to hotplug.  I
didn't see a resolution of that, but let me know if I missed it.

Bjorn

> On Thu, 4 Sep 2014, Yijing Wang wrote:
>>>>>>
>>>>>>      if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>>>>> +            pcie_bus_update_set(dev);
>>>>>
>>>>>
>>>>> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
>>>>> problem occur for other pcie_bus_config settings?
>>>>
>>>>
>>>> We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like
>>>> PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
>>>> This issue won't happen.
>>>
>>>
>>> Sorry, I can't parse this.  Are you saying the problem won't happen in
>>> the other modes?  Why not?
>>
>>
>> Hi Bjorn, when in PCIE_BUS_SAFE mode, pcie_find_smpss() will find the
>> largest available mpss in a pcie path.
>> Then call pcie_bus_configure_set() to set all devices' mps to the largest
>> available mps in this path, so
>> all devices in the path will have the same mps. When in
>> PCIE_BUS_PEER2PEER, all devices' mps will be set to 128B
>> for safety. And to the PCIE_BUS_PERFORMANCE mode, I found Jon's comment in
>> pcie_write_mps(),
>>
>>                         /* For "Performance", the assumption is made that
>>                          * downstream communication will never be larger
>> than
>>                          * the MRRS.  So, the MPS only needs to be
>> configured
>>                          * for the upstream communication.  This being the
>> case, <------
>>                          * walk from the top down and set the MPS of the
>> child
>>                          * to that of the parent bus.
>>
>> So I think the problem won't happen in other modes.
>>
>> Thanks!
>> Yijing.
>>
>>
>>>
>>>>>>              pcie_bus_detect_mps(dev);
>>>>>>              return 0;
>>>>>>      }
>>>
>>>
>>> .
>>>
>>
>>
>> --
>> Thanks!
>> Yijing
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

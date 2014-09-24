Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24721 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaIXWlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 18:41:10 -0400
Date: Wed, 24 Sep 2014 16:41:09 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
In-Reply-To: <5409117E.2000002@huawei.com>
Message-ID: <alpine.LRH.2.03.1409241547430.4696@AMR>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com> <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com> <5409117E.2000002@huawei.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just poking this thread to make sure it's not dead. :)

I tested Yijing's proposal and it is successful on our Intel server
platforms; hoping either this or something that derives similar behavior
will be applied so we can remove bus tuning kernel parameters.

Tested-by: Keith Busch <keith.busch@intel.com>

On Thu, 4 Sep 2014, Yijing Wang wrote:
>>>>>      if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>>>> +            pcie_bus_update_set(dev);
>>>>
>>>> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
>>>> problem occur for other pcie_bus_config settings?
>>>
>>> We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
>>> This issue won't happen.
>>
>> Sorry, I can't parse this.  Are you saying the problem won't happen in
>> the other modes?  Why not?
>
> Hi Bjorn, when in PCIE_BUS_SAFE mode, pcie_find_smpss() will find the largest available mpss in a pcie path.
> Then call pcie_bus_configure_set() to set all devices' mps to the largest available mps in this path, so
> all devices in the path will have the same mps. When in PCIE_BUS_PEER2PEER, all devices' mps will be set to 128B
> for safety. And to the PCIE_BUS_PERFORMANCE mode, I found Jon's comment in pcie_write_mps(),
>
> 			/* For "Performance", the assumption is made that
> 			 * downstream communication will never be larger than
> 			 * the MRRS.  So, the MPS only needs to be configured
> 			 * for the upstream communication.  This being the case, <------
> 			 * walk from the top down and set the MPS of the child
> 			 * to that of the parent bus.
>
> So I think the problem won't happen in other modes.
>
> Thanks!
> Yijing.
>
>
>>
>>>>>              pcie_bus_detect_mps(dev);
>>>>>              return 0;
>>>>>      }
>>
>> .
>>
>
>
> -- 
> Thanks!
> Yijing
>
>

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:2408 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaIEB1l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 21:27:41 -0400
Message-ID: <5409117E.2000002@huawei.com>
Date: Fri, 5 Sep 2014 09:27:26 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com> <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com>
In-Reply-To: <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>>>      if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>>> +            pcie_bus_update_set(dev);
>>>
>>> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
>>> problem occur for other pcie_bus_config settings?
>>
>> We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
>> This issue won't happen.
> 
> Sorry, I can't parse this.  Are you saying the problem won't happen in
> the other modes?  Why not?

Hi Bjorn, when in PCIE_BUS_SAFE mode, pcie_find_smpss() will find the largest available mpss in a pcie path.
Then call pcie_bus_configure_set() to set all devices' mps to the largest available mps in this path, so
all devices in the path will have the same mps. When in PCIE_BUS_PEER2PEER, all devices' mps will be set to 128B
for safety. And to the PCIE_BUS_PERFORMANCE mode, I found Jon's comment in pcie_write_mps(),

			/* For "Performance", the assumption is made that
			 * downstream communication will never be larger than
			 * the MRRS.  So, the MPS only needs to be configured
			 * for the upstream communication.  This being the case, <------
 			 * walk from the top down and set the MPS of the child
			 * to that of the parent bus.

So I think the problem won't happen in other modes.

Thanks!
Yijing.


> 
>>>>              pcie_bus_detect_mps(dev);
>>>>              return 0;
>>>>      }
> 
> .
> 


-- 
Thanks!
Yijing

